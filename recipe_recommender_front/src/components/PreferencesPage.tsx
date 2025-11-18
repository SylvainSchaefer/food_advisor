import React, { useState, useEffect, useRef, useCallback } from 'react';
import { Allergy, Ingredient, PaginatedResponse } from '../types';
import { api } from '../services/api';
import './PreferencesPage.css';

export const PreferencesPage: React.FC = () => {
  const [allergies, setAllergies] = useState<Allergy[]>([]);
  const [myAllergies, setMyAllergies] = useState<Allergy[]>([]);
  const [ingredients, setIngredients] = useState<Ingredient[]>([]);
  const [myPreferences, setMyPreferences] = useState<any[]>([]);
  const [activeTab, setActiveTab] = useState<'allergies' | 'ingredients'>('allergies');
  const [isLoading, setIsLoading] = useState(true);
  const [isLoadingMoreIngredients, setIsLoadingMoreIngredients] = useState(false);
  const [error, setError] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const [hasMoreIngredients, setHasMoreIngredients] = useState(true);

  const observer = useRef<IntersectionObserver>();
  const lastIngredientElementRef = useCallback((node: HTMLDivElement | null) => {
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
    loadData();
  }, []);

  useEffect(() => {
    if (currentPage > 1) {
      loadMoreIngredients();
    }
  }, [currentPage]);

  const loadData = async () => {
    setIsLoading(true);
    setError('');

    try {
      const [allergiesData, myAllergiesData, ingredientsResponse, preferencesData] = await Promise.all([
        api.getAllAllergies(),
        api.getMyAllergies(),
        api.getAllIngredients(1, 20),
        api.getMyIngredientPreferences().catch(() => [])
      ]);

      setAllergies(allergiesData);
      setMyAllergies(myAllergiesData);
      setIngredients(ingredientsResponse.data);
      setHasMoreIngredients(ingredientsResponse.pagination.has_next);
      setMyPreferences(preferencesData);
    } catch (err: any) {
      setError(err.message || 'Erreur lors du chargement des données');
    } finally {
      setIsLoading(false);
    }
  };

  const loadMoreIngredients = async () => {
    setIsLoadingMoreIngredients(true);
    try {
      const response = await api.getAllIngredients(currentPage, 20);
      setIngredients(prev => [...prev, ...response.data]);
      setHasMoreIngredients(response.pagination.has_next);
    } catch (err) {
      console.error('Erreur chargement ingrédients:', err);
    } finally {
      setIsLoadingMoreIngredients(false);
    }
  };

  const handleAddAllergy = async (allergyId: number, severity: string) => {
    try {
      await api.addUserAllergy(allergyId, severity);
      await loadData();
    } catch (err: any) {
      setError(err.message || 'Erreur lors de l\'ajout de l\'allergie');
    }
  };

  const handleRemoveAllergy = async (allergyId: number) => {
    try {
      await api.removeUserAllergy(allergyId);
      setMyAllergies(myAllergies.filter(a => a.allergy_id !== allergyId));
    } catch (err: any) {
      setError(err.message || 'Erreur lors de la suppression de l\'allergie');
    }
  };

  const handleSetPreference = async (ingredientId: number, type: 'preferred' | 'excluded') => {
    try {
      await api.setIngredientPreference(ingredientId, type);
      await loadData();
    } catch (err: any) {
      setError(err.message || 'Erreur lors de la mise à jour de la préférence');
    }
  };

  const handleRemovePreference = async (ingredientId: number) => {
    try {
      await api.removeIngredientPreference(ingredientId);
      setMyPreferences(myPreferences.filter(p => p.ingredient_id !== ingredientId));
    } catch (err: any) {
      setError(err.message || 'Erreur lors de la suppression de la préférence');
    }
  };

  const getPreferenceForIngredient = (ingredientId: number) => {
    return myPreferences.find(p => p.ingredient_id === ingredientId);
  };

  const availableIngredients = ingredients.filter(ing => !getPreferenceForIngredient(ing.ingredient_id));

  if (isLoading) {
    return (
      <div className="preferences-page">
        <div className="loading-state">
          <div className="spinner"></div>
          <p>Chargement...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="preferences-page">
      <div className="preferences-container">
        <h2>Mes préférences alimentaires</h2>
        <p className="preferences-subtitle">
          Gérez vos allergies et préférences pour obtenir des recommandations personnalisées
        </p>

        {error && <div className="error-message">{error}</div>}

        <div className="preferences-tabs">
          <button
            className={activeTab === 'allergies' ? 'active' : ''}
            onClick={() => setActiveTab('allergies')}
          >
            🚫 Allergies ({myAllergies.length})
          </button>
          <button
            className={activeTab === 'ingredients' ? 'active' : ''}
            onClick={() => setActiveTab('ingredients')}
          >
            ❤️ Préférences d'ingrédients ({myPreferences.length})
          </button>
        </div>

        {activeTab === 'allergies' && (
          <div className="preferences-content">
            <div className="my-items-section">
              <h3>Mes allergies</h3>
              {myAllergies.length === 0 ? (
                <p className="empty-message">Vous n'avez déclaré aucune allergie</p>
              ) : (
                <div className="items-grid">
                  {myAllergies.map(allergy => (
                    <div key={allergy.allergy_id} className="item-card">
                      <div className="item-info">
                        <h4>{allergy.name}</h4>
                        <p>{allergy.description}</p>
                        {allergy.severity && (
                          <span className={`severity-badge severity-${allergy.severity.toLowerCase()}`}>
                            {allergy.severity}
                          </span>
                        )}
                      </div>
                      <button
                        className="btn-remove"
                        onClick={() => handleRemoveAllergy(allergy.allergy_id)}
                      >
                        Retirer
                      </button>
                    </div>
                  ))}
                </div>
              )}
            </div>

            <div className="available-items-section">
              <h3>Allergies disponibles</h3>
              <div className="items-grid">
                {allergies
                  .filter(a => !myAllergies.find(ma => ma.allergy_id === a.allergy_id))
                  .map(allergy => (
                    <div key={allergy.allergy_id} className="item-card">
                      <div className="item-info">
                        <h4>{allergy.name}</h4>
                        <p>{allergy.description}</p>
                      </div>
                      <div className="severity-selector">
                        <label>Sévérité:</label>
                        <select
                          onChange={(e) => {
                            if (e.target.value) {
                              handleAddAllergy(allergy.allergy_id, e.target.value);
                            }
                          }}
                          defaultValue=""
                        >
                          <option value="">Sélectionner</option>
                          <option value="Mild">Légère</option>
                          <option value="Moderate">Modérée</option>
                          <option value="Severe">Sévère</option>
                        </select>
                      </div>
                    </div>
                  ))}
              </div>
            </div>
          </div>
        )}

        {activeTab === 'ingredients' && (
          <div className="preferences-content">
            <div className="my-items-section">
              <h3>Mes préférences</h3>
              {myPreferences.length === 0 ? (
                <p className="empty-message">Vous n'avez déclaré aucune préférence</p>
              ) : (
                <div className="preferences-list">
                  {myPreferences.map(pref => {
                    const ingredient = ingredients.find(i => i.ingredient_id === pref.ingredient_id);
                    return ingredient ? (
                      <div key={pref.ingredient_id} className="preference-item">
                        <span className={`preference-icon ${pref.preference_type}`}>
                          {pref.preference_type === 'preferred' ? '❤️' : '👎'}
                        </span>
                        <span className="ingredient-name">{ingredient.name}</span>
                        <button
                          className="btn-remove-small"
                          onClick={() => handleRemovePreference(pref.ingredient_id)}
                        >
                          ✕
                        </button>
                      </div>
                    ) : null;
                  })}
                </div>
              )}
            </div>

            <div className="available-items-section">
              <h3>Ingrédients</h3>
              <div className="ingredients-grid">
                {availableIngredients.map((ingredient, index) => (
                  <div
                    key={ingredient.ingredient_id}
                    className="ingredient-card"
                    ref={availableIngredients.length === index + 1 ? lastIngredientElementRef : null}
                  >
                    <span className="ingredient-name">{ingredient.name}</span>
                    <div className="preference-buttons">
                      <button
                        className="btn-like"
                        onClick={() => handleSetPreference(ingredient.ingredient_id, 'preferred')}
                        title="J'aime"
                      >
                        ❤️
                      </button>
                      <button
                        className="btn-dislike"
                        onClick={() => handleSetPreference(ingredient.ingredient_id, 'excluded')}
                        title="Je n'aime pas"
                      >
                        👎
                      </button>
                    </div>
                  </div>
                ))}
              </div>

              {isLoadingMoreIngredients && (
                <div className="loading-state">
                  <div className="spinner"></div>
                  <p>Chargement...</p>
                </div>
              )}
            </div>
          </div>
        )}
      </div>
    </div>
  );
};