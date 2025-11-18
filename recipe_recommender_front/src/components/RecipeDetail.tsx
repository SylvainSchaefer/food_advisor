import React, { useState } from 'react';
import { Recipe, RecipeStep, Ingredient } from '../types';
import { api } from '../services/api';
import { RecipeEditor } from './RecipeEditor';
import './RecipeDetail.css';

interface RecipeDetailProps {
  recipe: Recipe;
  onClose: () => void;
  canEdit: boolean;
  onRecipeUpdated: () => void;
  onRecipeDeleted?: () => void;
}

export const RecipeDetail: React.FC<RecipeDetailProps> = ({
  recipe: initialRecipe,
  onClose,
  canEdit,
  onRecipeUpdated,
  onRecipeDeleted
}) => {
  const [recipe, setRecipe] = useState(initialRecipe);
  const [isEditing, setIsEditing] = useState(false);
  const [showRatingModal, setShowRatingModal] = useState(false);
  const [showDeleteConfirm, setShowDeleteConfirm] = useState(false);
  const [rating, setRating] = useState(5);
  const [comment, setComment] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isDeleting, setIsDeleting] = useState(false);
  const [error, setError] = useState('');

  const getDifficultyLabel = (difficulty: string) => {
    switch (difficulty) {
      case 'Easy':
        return 'Facile';
      case 'Medium':
        return 'Moyen';
      case 'Hard':
        return 'Difficile';
      default:
        return difficulty;
    }
  };

  const handleOverlayClick = (e: React.MouseEvent) => {
    if (e.target === e.currentTarget) {
      onClose();
    }
  };

  const handleMarkAsCompleted = async () => {
    try {
      await api.completeRecipe(recipe.recipe_id);
      setShowRatingModal(true);
    } catch (err: any) {
      setError(err.message || 'Erreur lors du marquage de la recette');
    }
  };

  const handleSubmitRating = async () => {
    setIsSubmitting(true);
    setError('');

    try {
      await api.completeRecipe(recipe.recipe_id, rating, comment);
      setShowRatingModal(false);
      onRecipeUpdated();
      onClose();
    } catch (err: any) {
      setError(err.message || 'Erreur lors de la soumission de la note');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleSaveEdit = async (updatedRecipe: Recipe) => {
    setRecipe(updatedRecipe);
    setIsEditing(false);
    onRecipeUpdated();
  };

  const handleDelete = async () => {
    setIsDeleting(true);
    setError('');

    try {
      await api.deleteRecipe(recipe.recipe_id);
      setShowDeleteConfirm(false);
      if (onRecipeDeleted) {
        onRecipeDeleted();
      }
      onClose();
    } catch (err: any) {
      setError(err.message || 'Erreur lors de la suppression de la recette');
    } finally {
      setIsDeleting(false);
    }
  };

  if (isEditing) {
    return (
      <RecipeEditor
        recipe={recipe}
        onClose={() => setIsEditing(false)}
        onSave={handleSaveEdit}
      />
    );
  }

  return (
    <div className="recipe-detail-overlay" onClick={handleOverlayClick}>
      <div className="recipe-detail">
        <button className="close-btn" onClick={onClose}>
          ✕
        </button>

        <div className="detail-header">
          {recipe.image_url ? (
            <img src={recipe.image_url} alt={recipe.title} className="detail-image" />
          ) : (
            <div className="detail-image-placeholder">
              <span>🍽️</span>
            </div>
          )}

          <div className="detail-header-content">
            <h2>{recipe.title}</h2>
            <p className="detail-description">{recipe.description}</p>

            <div className="detail-meta">
              {recipe.rating && (
                <div className="meta-item">
                  <span className="meta-label">Note</span>
                  <span className="meta-value">⭐ {recipe.rating.toFixed(1)}</span>
                </div>
              )}
              <div className="meta-item">
                <span className="meta-label">Difficulté</span>
                <span className="meta-value">{getDifficultyLabel(recipe.difficulty)}</span>
              </div>
              <div className="meta-item">
                <span className="meta-label">Portions</span>
                <span className="meta-value">👥 {recipe.servings}</span>
              </div>
              {recipe.total_time && (
                <div className="meta-item">
                  <span className="meta-label">Temps</span>
                  <span className="meta-value">⏱️ {recipe.total_time} min</span>
                </div>
              )}
            </div>

            <div className="detail-author">
              Par {recipe.author_first_name} {recipe.author_last_name}
            </div>

            <div className="detail-actions">
              {canEdit && (
                <>
                  <button className="btn-edit" onClick={() => setIsEditing(true)}>
                    ✏️ Modifier
                  </button>
                  <button
                    className="btn-delete"
                    onClick={() => setShowDeleteConfirm(true)}
                    style={{
                      backgroundColor: '#f44336',
                      color: 'white',
                      border: 'none',
                      padding: '0.75rem 1.5rem',
                      borderRadius: '4px',
                      cursor: 'pointer',
                      fontSize: '1rem',
                      fontWeight: 'bold',
                      transition: 'background-color 0.3s'
                    }}
                  >
                    🗑️ Supprimer
                  </button>
                </>
              )}
              {(
                <button className="btn-complete" onClick={handleMarkAsCompleted}>
                  ✓ Marquer comme réalisée
                </button>
              )}
            </div>
          </div>
        </div>

        <div className="detail-content">
          {recipe.ingredients && recipe.ingredients.length > 0 && (
            <div className="detail-section">
              <h3>Ingrédients</h3>
              <ul className="ingredients-list">
                {recipe.ingredients.map((ingredient, index) => (
                  <li key={index} className={ingredient.is_optional ? 'optional' : ''}>
                    <span className="ingredient-quantity">
                      {ingredient.quantity} {ingredient.measurement_unit}
                    </span>
                    <span className="ingredient-name">{ingredient.name}</span>
                    {ingredient.is_optional && (
                      <span className="optional-badge">optionnel</span>
                    )}
                  </li>
                ))}
              </ul>
            </div>
          )}

          {recipe.steps && recipe.steps.length > 0 && (
            <div className="detail-section">
              <h3>Étapes de préparation</h3>
              <ol className="steps-list">
                {recipe.steps
                  .sort((a, b) => a.step_order - b.step_order)
                  .map((step) => (
                    <li key={step.recipe_step_id}>
                      <div className="step-content">
                        <p>{step.description}</p>
                        {step.duration_minutes > 0 && (
                          <span className="step-duration">
                            ⏱️ {step.duration_minutes} min
                          </span>
                        )}
                      </div>
                    </li>
                  ))}
              </ol>
            </div>
          )}

          {(!recipe.ingredients || recipe.ingredients.length === 0) &&
            (!recipe.steps || recipe.steps.length === 0) && (
              <div className="no-details">
                <p>Les détails de cette recette ne sont pas encore disponibles.</p>
              </div>
            )}
        </div>
      </div>

      {showRatingModal && (
        <div className="rating-modal-overlay" onClick={(e) => e.stopPropagation()}>
          <div className="rating-modal">
            <h3>Notez cette recette</h3>
            <p>Comment avez-vous trouvé cette recette ?</p>

            {error && <div className="error-message">{error}</div>}

            <div className="rating-stars">
              {[1, 2, 3, 4, 5].map((star) => (
                <button
                  key={star}
                  className={`star-btn ${rating >= star ? 'active' : ''}`}
                  onClick={() => setRating(star)}
                >
                  ⭐
                </button>
              ))}
            </div>

            <textarea
              className="rating-comment"
              placeholder="Ajoutez un commentaire (optionnel)"
              value={comment}
              onChange={(e) => setComment(e.target.value)}
              rows={4}
            />

            <div className="rating-modal-actions">
              <button
                className="btn-cancel"
                onClick={() => setShowRatingModal(false)}
                disabled={isSubmitting}
              >
                Annuler
              </button>
              <button
                className="btn-submit"
                onClick={handleSubmitRating}
                disabled={isSubmitting}
              >
                {isSubmitting ? 'Envoi...' : 'Envoyer'}
              </button>
            </div>
          </div>
        </div>
      )}

      {showDeleteConfirm && (
        <div className="rating-modal-overlay" onClick={(e) => e.stopPropagation()}>
          <div className="rating-modal">
            <h3>Confirmer la suppression</h3>
            <p>Êtes-vous sûr de vouloir supprimer la recette "{recipe.title}" ?</p>
            <p style={{ color: '#f44336', fontWeight: 'bold' }}>
              Cette action est irréversible.
            </p>

            {error && <div className="error-message">{error}</div>}

            <div className="rating-modal-actions">
              <button
                className="btn-cancel"
                onClick={() => setShowDeleteConfirm(false)}
                disabled={isDeleting}
              >
                Annuler
              </button>
              <button
                className="btn-submit"
                onClick={handleDelete}
                disabled={isDeleting}
                style={{
                  backgroundColor: '#f44336'
                }}
              >
                {isDeleting ? 'Suppression...' : 'Supprimer'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
