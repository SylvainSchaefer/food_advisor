import React, { useState, useEffect, useRef, useCallback } from 'react';
import { Recipe, RecipeStep, Ingredient, UserProfile } from '../types';
import { api } from '../services/api';
import { IngredientModal } from './IngredientModal';
import './RecipeEditor.css';

interface RecipeEditorProps {
  recipe?: Recipe; // Optionnel pour la création
  onClose: () => void;
  onSave: (recipe: Recipe) => void;
}

export const RecipeEditor: React.FC<RecipeEditorProps> = ({ recipe, onClose, onSave }) => {
  const isCreating = !recipe || !recipe.recipe_id;
  const [createdRecipeId, setCreatedRecipeId] = useState<number | null>(recipe?.recipe_id || null);
  const [formData, setFormData] = useState({
    title: recipe?.title || '',
    description: recipe?.description || '',
    servings: recipe?.servings || 4,
    difficulty: recipe?.difficulty || 'Easy' as 'Easy' | 'Medium' | 'Hard',
    is_published: recipe?.is_published || false
  });
  const [steps, setSteps] = useState<RecipeStep[]>(recipe?.steps || []);
  const [ingredients, setIngredients] = useState<any[]>(Array.isArray(recipe?.ingredients) && recipe ? recipe.ingredients : []);
  const [allIngredients, setAllIngredients] = useState<Ingredient[]>([]);
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState('');
  const [activeTab, setActiveTab] = useState<'info' | 'ingredients' | 'steps' | 'image'>('info');
  const [currentPage, setCurrentPage] = useState(1);
  const [hasMoreIngredients, setHasMoreIngredients] = useState(true);
  const [isLoadingMoreIngredients, setIsLoadingMoreIngredients] = useState(false);
  const [newIngredient, setNewIngredient] = useState({
    ingredient_id: 0,
    quantity: 1,
    is_optional: false
  });
  const [showIngredientModal, setShowIngredientModal] = useState(false);
  const [editingIngredient, setEditingIngredient] = useState<Ingredient | null>(null);
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null);

  const observer = useRef<IntersectionObserver>();
  const lastIngredientElementRef = useCallback((node: HTMLOptionElement | null) => {
    if (isLoadingMoreIngredients) return;
    if (observer.current) observer.current.disconnect();

    observer.current = new IntersectionObserver(entries => {
      if (entries[0].isIntersecting && hasMoreIngredients) {
        setCurrentPage(prev => prev + 1);
      }
    });

    if (node) observer.current.observe(node);
  }, [isLoadingMoreIngredients, hasMoreIngredients]);

  useEffect(() => {
    loadAllIngredients();
    loadUserProfile();
  }, []);

  useEffect(() => {
    if (currentPage > 1) {
      loadMoreIngredients();
    }
  }, [currentPage]);

  const loadUserProfile = async () => {
    try {
      const profile = await api.getUserProfile();
      setUserProfile(profile);
    } catch (err) {
      console.error('Erreur chargement profil:', err);
    }
  };

  const loadAllIngredients = async () => {
    try {
      const response = await api.getAllIngredients(1, 50);
      setAllIngredients(response.data);
      setHasMoreIngredients(response.pagination.has_next);
    } catch (err) {
      console.error('Erreur chargement ingrédients:', err);
    }
  };

  const loadMoreIngredients = async () => {
    setIsLoadingMoreIngredients(true);
    try {
      const response = await api.getAllIngredients(currentPage, 50);
      setAllIngredients(prev => [...prev, ...response.data]);
      setHasMoreIngredients(response.pagination.has_next);
    } catch (err) {
      console.error('Erreur chargement ingrédients:', err);
    } finally {
      setIsLoadingMoreIngredients(false);
    }
  };

  const handleSubmit = async () => {
    setIsSubmitting(true);
    setError('');

    try {
      let recipeId = createdRecipeId;
      let updatedRecipe: Recipe;

      if (isCreating && !createdRecipeId) {
        // Création d'une nouvelle recette
        updatedRecipe = await api.createRecipe(formData);
        recipeId = updatedRecipe.recipe_id;
        setCreatedRecipeId(recipeId);
      } else if (recipeId) {
        // Mise à jour d'une recette existante
        updatedRecipe = await api.updateRecipe(recipeId, formData);
      } else {
        throw new Error('ID de recette manquant');
      }

      // Upload de l'image si nécessaire
      if (imageFile && recipeId) {
        await api.uploadRecipeImage(recipeId, imageFile);
      }

      onSave({ ...updatedRecipe, steps, ingredients });
    } catch (err: any) {
      setError(err.message || 'Erreur lors de la sauvegarde');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleAddStep = () => {
    const newStep: Partial<RecipeStep> = {
      step_order: steps.length + 1,
      description: '',
      duration_minutes: 0,
      step_type: 'action'
    };
    setSteps([...steps, newStep as RecipeStep]);
  };

  const handleUpdateStep = async (index: number, field: keyof RecipeStep, value: any) => {
    const updated = [...steps];
    updated[index] = { ...updated[index], [field]: value };
    setSteps(updated);

    // Sauvegarder en temps réel si l'étape existe déjà ET que la recette a été créée
    if (updated[index].recipe_step_id && createdRecipeId) {
      try {
        await api.updateRecipeStep(createdRecipeId, updated[index].recipe_step_id, updated[index]);
      } catch (err) {
        console.error('Erreur mise à jour étape:', err);
      }
    }
  };

  const handleDeleteStep = async (index: number) => {
    const step = steps[index];
    if (step.recipe_step_id && createdRecipeId) {
      try {
        await api.deleteRecipeStep(createdRecipeId, step.recipe_step_id);
      } catch (err) {
        console.error('Erreur suppression étape:', err);
        return;
      }
    }
    setSteps(steps.filter((_, i) => i !== index));
  };

  const handleSaveStep = async (index: number) => {
    if (!createdRecipeId) {
      setError('Veuillez d\'abord sauvegarder les informations de base de la recette');
      return;
    }

    const step = steps[index];
    if (!step.recipe_step_id) {
      try {
        const saved = await api.addRecipeStep(createdRecipeId, step);
        const updated = [...steps];
        updated[index] = saved;
        setSteps(updated);
      } catch (err: any) {
        setError(err.message || 'Erreur lors de l\'ajout de l\'étape');
      }
    }
  };

  const handleAddIngredient = async () => {
    if (!createdRecipeId) {
      setError('Veuillez d\'abord sauvegarder les informations de base de la recette');
      return;
    }

    if (newIngredient.ingredient_id === 0) {
      setError('Veuillez sélectionner un ingrédient');
      return;
    }

    if (newIngredient.quantity <= 0) {
      setError('La quantité doit être supérieure à 0');
      return;
    }

    try {
      await api.addRecipeIngredient(createdRecipeId, {
        ingredient_id: newIngredient.ingredient_id,
        quantity: newIngredient.quantity,
        is_optional: newIngredient.is_optional
      });

      // Recharger la recette pour obtenir la liste mise à jour
      const updated = await api.getRecipe(createdRecipeId);
      setIngredients(Array.isArray(updated.ingredients) ? updated.ingredients : []);

      // Réinitialiser le formulaire
      setNewIngredient({
        ingredient_id: 0,
        quantity: 1,
        is_optional: false
      });

      setError('');
    } catch (err: any) {
      setError(err.message || 'Erreur lors de l\'ajout de l\'ingrédient');
    }
  };

  const handleRemoveIngredient = async (ingredientId: number) => {
    if (!createdRecipeId) {
      setError('Veuillez d\'abord sauvegarder les informations de base de la recette');
      return;
    }

    try {
      await api.removeRecipeIngredient(createdRecipeId, ingredientId);
      setIngredients(ingredients.filter(ing => ing.ingredient_id !== ingredientId));
    } catch (err: any) {
      setError(err.message || 'Erreur lors de la suppression de l\'ingrédient');
    }
  };

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      setImageFile(e.target.files[0]);
    }
  };

  const handleCreateIngredient = () => {
    setEditingIngredient(null);
    setShowIngredientModal(true);
  };

  const handleEditIngredient = (ingredient: Ingredient) => {
    setEditingIngredient(ingredient);
    setShowIngredientModal(true);
  };

  const handleDeleteIngredientFromDb = async (ingredientId: number) => {
    if (!userProfile || userProfile.role !== 'Administrator') {
      setError('Seuls les administrateurs peuvent supprimer des ingrédients');
      return;
    }

    if (!window.confirm('Êtes-vous sûr de vouloir supprimer cet ingrédient de la base de données ? Cette action est irréversible.')) {
      return;
    }

    try {
      await api.deleteIngredient(ingredientId);
      // Recharger la liste des ingrédients
      await loadAllIngredients();
      setError('');
    } catch (err: any) {
      setError(err.message || 'Erreur lors de la suppression de l\'ingrédient');
    }
  };

  const handleIngredientSaved = async (ingredient: Ingredient) => {
    // Recharger la liste des ingrédients depuis le début
    setCurrentPage(1);
    setHasMoreIngredients(true);

    try {
      const response = await api.getAllIngredients(1, 50);
      setAllIngredients(response.data);
      setHasMoreIngredients(response.pagination.has_next);

      // Sélectionner automatiquement l'ingrédient qui vient d'être créé/modifié
      setNewIngredient({
        ...newIngredient,
        ingredient_id: ingredient.ingredient_id
      });
    } catch (err) {
      console.error('Erreur rechargement ingrédients:', err);
    }

    setShowIngredientModal(false);
    setEditingIngredient(null);
  };

  const availableIngredients = allIngredients.filter(
    ing => !ingredients.find(i => i.ingredient_id === ing.ingredient_id)
  );

  const getSelectedIngredientUnit = () => {
    const selected = allIngredients.find(ing => ing.ingredient_id === newIngredient.ingredient_id);
    return selected?.measurement_unit || '';
  };

  return (
    <div className="recipe-editor-overlay">
      <div className="recipe-editor">
        <div className="editor-header">
          <h2>{isCreating ? 'Créer une nouvelle recette' : 'Modifier la recette'}</h2>
          <button className="close-btn" onClick={onClose}>✕</button>
        </div>

        {error && <div className="error-message">{error}</div>}

        {isCreating && !createdRecipeId && (
          <div className="info-message" style={{
            padding: '12px',
            backgroundColor: '#e3f2fd',
            border: '1px solid #2196f3',
            borderRadius: '4px',
            marginBottom: '16px',
            color: '#1976d2'
          }}>
            <strong>Note :</strong> Pour ajouter des ingrédients ou des étapes, vous devez d'abord sauvegarder les informations de base de la recette.
          </div>
        )}

        <div className="editor-tabs">
          <button
            className={activeTab === 'info' ? 'active' : ''}
            onClick={() => setActiveTab('info')}
          >
            Informations
          </button>
          <button
            className={activeTab === 'ingredients' ? 'active' : ''}
            onClick={() => setActiveTab('ingredients')}
          >
            Ingrédients ({ingredients.length})
          </button>
          <button
            className={activeTab === 'steps' ? 'active' : ''}
            onClick={() => setActiveTab('steps')}
          >
            Étapes ({steps.length})
          </button>
          <button
            className={activeTab === 'image' ? 'active' : ''}
            onClick={() => setActiveTab('image')}
          >
            Image
          </button>
        </div>

        <div className="editor-content">
          {activeTab === 'info' && (
            <div className="editor-section">
              <div className="form-group">
                <label>Titre</label>
                <input
                  type="text"
                  value={formData.title}
                  onChange={(e) => setFormData({ ...formData, title: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label>Description</label>
                <textarea
                  value={formData.description}
                  onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                  rows={4}
                />
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>Portions</label>
                  <input
                    type="number"
                    min="1"
                    value={formData.servings}
                    onChange={(e) => setFormData({ ...formData, servings: parseInt(e.target.value) })}
                  />
                </div>

                <div className="form-group">
                  <label>Difficulté</label>
                  <select
                    value={formData.difficulty}
                    onChange={(e) => setFormData({ ...formData, difficulty: e.target.value as any })}
                  >
                    <option value="Easy">Facile</option>
                    <option value="Medium">Moyen</option>
                    <option value="Hard">Difficile</option>
                  </select>
                </div>
              </div>

              <div className="form-group">
                <label className="checkbox-label">
                  <input
                    type="checkbox"
                    checked={formData.is_published}
                    onChange={(e) => setFormData({ ...formData, is_published: e.target.checked })}
                  />
                  <span>Publier la recette</span>
                </label>
                <p className="help-text">
                  {formData.is_published
                    ? "La recette sera visible par tous les utilisateurs"
                    : "La recette restera privée et visible uniquement par vous"}
                </p>
              </div>
            </div>
          )}

          {activeTab === 'ingredients' && (
            <div className="editor-section">
              <div className="ingredients-editor">
                <h3>Ingrédients actuels</h3>
                <ul className="ingredients-list-editor">
                  {ingredients.map((ing, index) => (
                    <li key={index}>
                      <span>
                        {ing.name} - {ing.quantity} {ing.measurement_unit}
                        {ing.is_optional && <em> (optionnel)</em>}
                      </span>
                      <button
                        className="btn-delete-small"
                        onClick={() => handleRemoveIngredient(ing.ingredient_id)}
                      >
                        ✕
                      </button>
                    </li>
                  ))}
                </ul>

                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
                  <h3 style={{ margin: 0 }}>Ajouter un ingrédient</h3>
                  <button
                    type="button"
                    className="btn-create-ingredient"
                    onClick={handleCreateIngredient}
                    style={{
                      backgroundColor: '#2196f3',
                      color: 'white',
                      border: 'none',
                      padding: '0.5rem 1rem',
                      borderRadius: '4px',
                      cursor: 'pointer',
                      fontSize: '0.9rem',
                      fontWeight: 'bold'
                    }}
                  >
                    + Créer un nouvel ingrédient
                  </button>
                </div>
                <div className="add-ingredient-form">
                  <div className="form-group">
                    <label>Ingrédient</label>
                    <div style={{ display: 'flex', gap: '0.5rem', alignItems: 'flex-start' }}>
                      <select
                        value={newIngredient.ingredient_id}
                        onChange={(e) => setNewIngredient({ ...newIngredient, ingredient_id: parseInt(e.target.value) })}
                        size={10}
                        style={{ flex: 1, minHeight: '200px' }}
                      >
                        <option value="0" disabled>-- Sélectionner --</option>
                        {availableIngredients.map((ing, index) => (
                          <option
                            key={ing.ingredient_id}
                            value={ing.ingredient_id}
                            ref={availableIngredients.length === index + 1 ? lastIngredientElementRef : null}
                          >
                            {ing.name} ({ing.measurement_unit})
                          </option>
                        ))}
                        {isLoadingMoreIngredients && (
                          <option disabled>Chargement...</option>
                        )}
                      </select>
                      {userProfile?.role === 'Administrator' && newIngredient.ingredient_id > 0 && (
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                          <button
                            type="button"
                            onClick={() => {
                              const selected = allIngredients.find(ing => ing.ingredient_id === newIngredient.ingredient_id);
                              if (selected) handleEditIngredient(selected);
                            }}
                            style={{
                              backgroundColor: '#ff9800',
                              color: 'white',
                              border: 'none',
                              padding: '0.5rem',
                              borderRadius: '4px',
                              cursor: 'pointer',
                              fontSize: '0.9rem'
                            }}
                            title="Modifier cet ingrédient"
                          >
                            ✏️
                          </button>
                          <button
                            type="button"
                            onClick={() => handleDeleteIngredientFromDb(newIngredient.ingredient_id)}
                            style={{
                              backgroundColor: '#f44336',
                              color: 'white',
                              border: 'none',
                              padding: '0.5rem',
                              borderRadius: '4px',
                              cursor: 'pointer',
                              fontSize: '0.9rem'
                            }}
                            title="Supprimer cet ingrédient"
                          >
                            🗑️
                          </button>
                        </div>
                      )}
                    </div>
                  </div>

                  <div className="form-row">
                    <div className="form-group">
                      <label>Quantité {getSelectedIngredientUnit() && `(${getSelectedIngredientUnit()})`}</label>
                      <input
                        type="number"
                        min="0.1"
                        step="0.1"
                        value={newIngredient.quantity}
                        onChange={(e) => setNewIngredient({ ...newIngredient, quantity: parseFloat(e.target.value) || 0 })}
                      />
                    </div>

                    <div className="form-group">
                      <label className="checkbox-label">
                        <input
                          type="checkbox"
                          checked={newIngredient.is_optional}
                          onChange={(e) => setNewIngredient({ ...newIngredient, is_optional: e.target.checked })}
                        />
                        <span>Optionnel</span>
                      </label>
                    </div>
                  </div>

                  <button
                    className="btn-add-ingredient"
                    onClick={handleAddIngredient}
                    disabled={newIngredient.ingredient_id === 0}
                  >
                    Ajouter l'ingrédient
                  </button>
                </div>
              </div>
            </div>
          )}

          {activeTab === 'steps' && (
            <div className="editor-section">
              <div className="steps-editor">
                {steps.map((step, index) => (
                  <div key={index} className="step-editor-item">
                    <div className="step-header">
                      <h4>Étape {index + 1}</h4>
                      <button
                        className="btn-delete-small"
                        onClick={() => handleDeleteStep(index)}
                      >
                        ✕
                      </button>
                    </div>

                    <textarea
                      placeholder="Description de l'étape"
                      value={step.description}
                      onChange={(e) => handleUpdateStep(index, 'description', e.target.value)}
                      rows={3}
                    />

                    <div className="step-meta">
                      <input
                        type="number"
                        placeholder="Durée (min)"
                        value={step.duration_minutes}
                        onChange={(e) => handleUpdateStep(index, 'duration_minutes', parseInt(e.target.value) || 0)}
                      />
                      {!step.recipe_step_id && (
                        <button
                          className="btn-save-step"
                          onClick={() => handleSaveStep(index)}
                        >
                          Sauvegarder
                        </button>
                      )}
                    </div>
                  </div>
                ))}

                <button className="btn-add-step" onClick={handleAddStep}>
                  + Ajouter une étape
                </button>
              </div>
            </div>
          )}

          {activeTab === 'image' && (
            <div className="editor-section">
              <div className="image-editor">
                {recipe?.image_url && (
                  <div className="current-image">
                    <h3>Image actuelle</h3>
                    <img src={recipe.image_url} alt={recipe.title} />
                  </div>
                )}

                <div className="form-group">
                  <label>Nouvelle image</label>
                  <input
                    type="file"
                    accept="image/*"
                    onChange={handleImageChange}
                  />
                  {imageFile && (
                    <p className="file-info">Fichier sélectionné : {imageFile.name}</p>
                  )}
                </div>
              </div>
            </div>
          )}
        </div>

        <div className="editor-footer">
          <button className="btn-cancel" onClick={onClose}>
            Annuler
          </button>
          <button
            className="btn-save"
            onClick={handleSubmit}
            disabled={isSubmitting}
          >
            {isSubmitting ? 'Sauvegarde...' : 'Sauvegarder'}
          </button>
        </div>
      </div>

      {showIngredientModal && (
        <IngredientModal
          ingredient={editingIngredient}
          onClose={() => {
            setShowIngredientModal(false);
            setEditingIngredient(null);
          }}
          onSave={handleIngredientSaved}
          isAdmin={userProfile?.role === 'Administrator'}
        />
      )}
    </div>
  );
};