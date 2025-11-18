import React, { useState, useEffect } from 'react';
import { api } from '../services/api';
import {
  GlobalStats,
  TopCompletedRecipe,
  TopRatedRecipe,
  TopIngredient,
  CompletionByPeriod,
  AllergyStats,
  ActiveUser,
  CategoryUsage
} from '../types';
import './StatsPage.css';

export const StatsPage: React.FC = () => {
  const [globalStats, setGlobalStats] = useState<GlobalStats | null>(null);
  const [topCompleted, setTopCompleted] = useState<TopCompletedRecipe[]>([]);
  const [topRated, setTopRated] = useState<TopRatedRecipe[]>([]);
  const [topIngredients, setTopIngredients] = useState<TopIngredient[]>([]);
  const [completionsByPeriod, setCompletionsByPeriod] = useState<CompletionByPeriod[]>([]);
  const [allergiesStats, setAllergiesStats] = useState<AllergyStats[]>([]);
  const [activeUsers, setActiveUsers] = useState<ActiveUser[]>([]);
  const [categoriesUsage, setCategoriesUsage] = useState<CategoryUsage[]>([]);
  const [period, setPeriod] = useState<'day' | 'week' | 'month' | 'year'>('month');
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    loadAllStats();
  }, []);

  useEffect(() => {
    loadCompletionsByPeriod();
  }, [period]);

  const loadAllStats = async () => {
    setIsLoading(true);
    setError('');

    try {
      const [
        global,
        completed,
        rated,
        ingredients,
        allergies,
        users,
        categories
      ] = await Promise.all([
        api.getGlobalStats(),
        api.getTopCompletedRecipes(10),
        api.getTopRatedRecipes(10, 1),
        api.getTopIngredients(10),
        api.getAllergiesStats(),
        api.getActiveUsers(10),
        api.getCategoriesUsage()
      ]);

      setGlobalStats(global);
      setTopCompleted(completed);
      setTopRated(rated);
      setTopIngredients(ingredients);
      setAllergiesStats(allergies);
      setActiveUsers(users);
      setCategoriesUsage(categories);

      await loadCompletionsByPeriod();
    } catch (err: any) {
      setError(err.message || 'Erreur lors du chargement des statistiques');
    } finally {
      setIsLoading(false);
    }
  };

  const loadCompletionsByPeriod = async () => {
    try {
      const data = await api.getCompletionsByPeriod(period);
      setCompletionsByPeriod(data);
    } catch (err: any) {
      console.error('Erreur chargement completions:', err);
    }
  };

  if (isLoading) {
    return (
      <div className="stats-page">
        <div className="loading-state">
          <div className="spinner"></div>
          <p>Chargement des statistiques...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="stats-page">
        <div className="error-message">{error}</div>
      </div>
    );
  }

  return (
    <div className="stats-page">
      <h2 className="stats-title">Statistiques de la plateforme</h2>

      {/* Statistiques globales */}
      {globalStats && (
        <div className="stats-section">
          <h3>Vue d'ensemble</h3>
          <div className="stats-grid">
            <div className="stat-card">
              <div className="stat-icon">👥</div>
              <div className="stat-content">
                <div className="stat-value">{globalStats.total_users}</div>
                <div className="stat-label">Utilisateurs</div>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">🍳</div>
              <div className="stat-content">
                <div className="stat-value">{globalStats.total_recipes}</div>
                <div className="stat-label">Recettes</div>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">✓</div>
              <div className="stat-content">
                <div className="stat-value">{globalStats.total_recipe_completions}</div>
                <div className="stat-label">Complétions</div>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">⭐</div>
              <div className="stat-content">
                <div className="stat-value">{globalStats.average_rating}</div>
                <div className="stat-label">Note moyenne</div>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">📊</div>
              <div className="stat-content">
                <div className="stat-value">
                  {globalStats.average_rating ? Number(globalStats.average_rating).toFixed(2) : '0.00'}
                </div>
                <div className="stat-label">Note moyenne</div>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">🥕</div>
              <div className="stat-content">
                <div className="stat-value">{globalStats.total_ingredients}</div>
                <div className="stat-label">Ingrédients</div>
              </div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">⚠️</div>
              <div className="stat-content">
                <div className="stat-value">{globalStats.total_allergies}</div>
                <div className="stat-label">Allergies</div>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Complétions par période */}
      <div className="stats-section">
        <div className="section-header">
          <h3>Complétions par période</h3>
          <select
            value={period}
            onChange={(e) => setPeriod(e.target.value as any)}
            className="period-selector"
          >
            <option value="day">Par jour</option>
            <option value="week">Par semaine</option>
            <option value="month">Par mois</option>
            <option value="year">Par année</option>
          </select>
        </div>
        <div className="chart-container">
          {completionsByPeriod.length > 0 ? (
            <div className="bar-chart">
              {completionsByPeriod.map((item, index) => {
                const maxCount = Math.max(...completionsByPeriod.map(i => i.completion_count));
                const height = maxCount > 0 ? (item.completion_count / maxCount) * 200 : 0;
                return (
                  <div key={index} className="bar-item">
                    <div className="bar" style={{ height: `${height}px` }}>
                      <span className="bar-value">{item.completion_count}</span>
                    </div>
                    <div className="bar-label">{item.period}</div>
                  </div>
                );
              })}
            </div>
          ) : (
            <p className="no-data">Aucune donnée disponible</p>
          )}
        </div>
      </div>

      <div className="stats-row">
        {/* Top recettes complétées */}
        <div className="stats-section half">
          <h3>Top 10 recettes complétées</h3>
          <div className="table-container">
            <table className="stats-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Recette</th>
                  <th>Complétions</th>
                  <th>Note moyenne</th>
                </tr>
              </thead>
              <tbody>
                {topCompleted.map((recipe, index) => (
                  <tr key={recipe.recipe_id}>
                    <td>{index + 1}</td>
                    <td>{recipe.title}</td>
                    <td>{recipe.completion_count}</td>
                    <td>{recipe.average_rating ? Number(recipe.average_rating).toFixed(1) : 'N/A'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {/* Top recettes notées */}
        <div className="stats-section half">
          <h3>Top 10 recettes les mieux notées</h3>
          <div className="table-container">
            <table className="stats-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Recette</th>
                  <th>Note</th>
                  <th>Nb notes</th>
                </tr>
              </thead>
              <tbody>
                {topRated.map((recipe, index) => (
                  <tr key={recipe.recipe_id}>
                    <td>{index + 1}</td>
                    <td>{recipe.title}</td>
                    <td>⭐ {recipe.average_rating ? Number(recipe.average_rating).toFixed(1) : 'N/A'}</td>
                    <td>{recipe.rating_count}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <div className="stats-row">
        {/* Top ingrédients avec graphique */}
        <div className="stats-section half">
          <h3>Top 10 ingrédients les plus utilisés</h3>
          {topIngredients.length > 0 && (
            <div className="horizontal-bar-chart">
              {topIngredients.map((ingredient, index) => {
                const maxCount = topIngredients[0]?.recipe_count || 1;
                const widthPct = (ingredient.recipe_count / maxCount) * 100;

                return (
                  <div key={ingredient.ingredient_id} className="h-bar-item">
                    <div className="h-bar-label">
                      <span className="rank">#{index + 1}</span>
                      <span className="name">{ingredient.name}</span>
                    </div>
                    <div className="h-bar-container">
                      <div
                        className="h-bar"
                        style={{ width: `${widthPct}%` }}
                      >
                        <span className="h-bar-value">{ingredient.recipe_count}</span>
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>

        {/* Utilisateurs actifs */}
        <div className="stats-section half">
          <h3>Top 10 utilisateurs actifs</h3>
          <div className="table-container">
            <table className="stats-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Utilisateur</th>
                  <th>Complétions</th>
                  <th>Note moyenne</th>
                </tr>
              </thead>
              <tbody>
                {activeUsers.map((user, index) => (
                  <tr key={user.user_id}>
                    <td>{index + 1}</td>
                    <td>{user.first_name} {user.last_name}</td>
                    <td>{user.completed_recipes_count}</td>
                    <td>{user.average_rating_given}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>

      {/* Statistiques allergies avec graphiques */}
      <div className="stats-section">
        <h3>Statistiques des allergies</h3>
        {allergiesStats.length > 0 ? (
          <div className="allergies-visualization">
            {/* Graphique à barres empilées pour les sévérités */}
            <div className="severity-chart">
              <h4>Répartition des sévérités par allergie</h4>
              <div className="stacked-bar-chart">
                {allergiesStats.map((allergy) => {
                  const total = allergy.total_user_count;
                  const mildPct = total > 0 ? (allergy.mild_count / total) * 100 : 0;
                  const moderatePct = total > 0 ? (allergy.moderate_count / total) * 100 : 0;
                  const severePct = total > 0 ? (allergy.severe_count / total) * 100 : 0;
                  const lifeThreatPct = total > 0 ? (allergy.life_threatening_count / total) * 100 : 0;

                  return (
                    <div key={allergy.allergy_id} className="stacked-bar-item">
                      <div className="bar-name">{allergy.name}</div>
                      <div className="stacked-bar">
                        {allergy.mild_count > 0 && (
                          <div
                            className="bar-segment mild"
                            style={{ width: `${mildPct}%` }}
                            title={`Légère: ${allergy.mild_count} (${mildPct.toFixed(1)}%)`}
                          >
                            {allergy.mild_count > 0 && <span>{allergy.mild_count}</span>}
                          </div>
                        )}
                        {allergy.moderate_count > 0 && (
                          <div
                            className="bar-segment moderate"
                            style={{ width: `${moderatePct}%` }}
                            title={`Modérée: ${allergy.moderate_count} (${moderatePct.toFixed(1)}%)`}
                          >
                            {allergy.moderate_count > 0 && <span>{allergy.moderate_count}</span>}
                          </div>
                        )}
                        {allergy.severe_count > 0 && (
                          <div
                            className="bar-segment severe"
                            style={{ width: `${severePct}%` }}
                            title={`Sévère: ${allergy.severe_count} (${severePct.toFixed(1)}%)`}
                          >
                            {allergy.severe_count > 0 && <span>{allergy.severe_count}</span>}
                          </div>
                        )}
                        {allergy.life_threatening_count > 0 && (
                          <div
                            className="bar-segment life-threatening"
                            style={{ width: `${lifeThreatPct}%` }}
                            title={`Critique: ${allergy.life_threatening_count} (${lifeThreatPct.toFixed(1)}%)`}
                          >
                            {allergy.life_threatening_count > 0 && <span>{allergy.life_threatening_count}</span>}
                          </div>
                        )}
                      </div>
                      <div className="bar-total">
                        {allergy.total_user_count} ({Number(allergy.percentage).toFixed(1)}%)
                      </div>
                    </div>
                  );
                })}
              </div>
              <div className="legend">
                <div className="legend-item">
                  <span className="legend-color mild"></span>
                  <span>Légère</span>
                </div>
                <div className="legend-item">
                  <span className="legend-color moderate"></span>
                  <span>Modérée</span>
                </div>
                <div className="legend-item">
                  <span className="legend-color severe"></span>
                  <span>Sévère</span>
                </div>
                <div className="legend-item">
                  <span className="legend-color life-threatening"></span>
                  <span>Critique</span>
                </div>
              </div>
            </div>

            {/* Tableau détaillé */}
            <div className="table-container" style={{ marginTop: '2rem' }}>
              <h4>Détails des allergies</h4>
              <table className="stats-table">
                <thead>
                  <tr>
                    <th>Allergie</th>
                    <th>Total</th>
                    <th>% Utilisateurs</th>
                    <th>Légère</th>
                    <th>Modérée</th>
                    <th>Sévère</th>
                    <th>Critique</th>
                  </tr>
                </thead>
                <tbody>
                  {allergiesStats.map((allergy) => (
                    <tr key={allergy.allergy_id}>
                      <td><strong>{allergy.name}</strong></td>
                      <td>{allergy.total_user_count}</td>
                      <td>{Number(allergy.percentage).toFixed(1)}%</td>
                      <td>{allergy.mild_count}</td>
                      <td>{allergy.moderate_count}</td>
                      <td>{allergy.severe_count}</td>
                      <td>{allergy.life_threatening_count}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        ) : (
          <p className="no-data">Aucune donnée disponible</p>
        )}
      </div>

      <div className="stats-row">

        {/* Usage des catégories avec graphique */}
        <div className="stats-section half">
          <h3>Usage des catégories</h3>
          {categoriesUsage.length > 0 && (
            <div className="horizontal-bar-chart">
              {categoriesUsage.map((category, index) => {
                const maxCount = Math.max(...categoriesUsage.map(c => c.recipe_count));
                const widthPct = maxCount > 0 ? (category.recipe_count / maxCount) * 100 : 0;

                return (
                  <div key={category.category_id} className="h-bar-item">
                    <div className="h-bar-label">
                      <span className="name">{category.name}</span>
                    </div>
                    <div className="h-bar-container">
                      <div
                        className="h-bar category"
                        style={{ width: `${widthPct}%` }}
                      >
                        <span className="h-bar-value">
                          {category.recipe_count} recettes
                        </span>
                      </div>
                      <span className="preference-badge" title="Préférences utilisateurs">
                        👤 {category.ingredient_count}
                      </span>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};
