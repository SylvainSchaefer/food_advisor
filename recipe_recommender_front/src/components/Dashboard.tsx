import React, { useState, useEffect, useRef, useCallback } from 'react';
import { PaginatedResponse, Recipe, UserProfile } from '../types';
import { api } from '../services/api';
import { RecipeCard } from './RecipeCard';
import { RecipeDetail } from './RecipeDetail';
import { PreferencesPage } from './PreferencesPage';
import { RecipeEditor } from './RecipeEditor';
import { StatsPage } from './StatsPage';
import './Dashboard.css';

interface DashboardProps {
  onLogout: () => void;
}

export const Dashboard: React.FC<DashboardProps> = ({ onLogout }) => {
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [selectedRecipe, setSelectedRecipe] = useState<Recipe | null>(null);
  const [isCreatingRecipe, setIsCreatingRecipe] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const [hasMore, setHasMore] = useState(true);
  const [sortBy, setSortBy] = useState<'rating' | 'recent' | 'difficulty' | 'cost'>('rating');
  const [view, setView] = useState<'recommendations' | 'all' | 'my' | 'preferences' | 'stats'>('recommendations');
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null);

  const observer = useRef<IntersectionObserver | null>(null);

  const lastRecipeElementRef = useCallback((node: HTMLDivElement | null) => {

    if (isLoading) {
      return;
    }

    if (observer.current) {
      observer.current.disconnect();
    }

    observer.current = new IntersectionObserver(entries => {
      if (entries[0].isIntersecting && hasMore) {
        setCurrentPage(prev => {
          return prev + 1;
        });
      }
    });

    if (node) {
      observer.current.observe(node);
    }
  }, [isLoading, hasMore]);

  useEffect(() => {
    loadUserProfile();
  }, []);

  // Réinitialiser quand la vue ou le tri change
  useEffect(() => {
    setRecipes([]);
    setCurrentPage(1);
    setHasMore(true);
  }, [view, sortBy]);

  // Charger les recettes quand la page change
  useEffect(() => {
    if (view !== 'preferences' && view !== 'stats') {
      loadRecipes();
    }
  }, [currentPage, view]);

  const loadUserProfile = async () => {
    try {
      const profile = await api.getUserProfile();
      setUserProfile(profile);
    } catch (err: any) {
      console.error('Erreur chargement profil:', err);
    }
  };

  const loadRecipes = async () => {
    setIsLoading(true);
    setError('');

    try {
      let response: PaginatedResponse<Recipe>;
      if (view === 'recommendations') {
        response = await api.getRecommendations(currentPage, 12, sortBy);
      } else if (view === 'all') {
        response = await api.getAllRecipes(currentPage, 12);
      } else {
        response = await api.getMyRecipes(currentPage, 12);
      }

      if (currentPage === 1) {
        setRecipes(response.data);
      } else {
        setRecipes(prev => {
          const newRecipes = [...prev, ...response.data];
          return newRecipes;
        });
      }

      setHasMore(response.pagination.has_next);
    } catch (err: any) {
      console.error('❌ Erreur chargement recettes:', err);
      setError(err.message || 'Erreur lors du chargement des recettes');
    } finally {
      setIsLoading(false);
    }
  };

  const handleRecipeClick = async (recipeId: number) => {
    try {
      const recipe = await api.getRecipe(recipeId);
      const steps = await api.getRecipeSteps(recipeId);
      setSelectedRecipe({ ...recipe, steps });
    } catch (err: any) {
      setError(err.message || 'Erreur lors du chargement de la recette');
    }
  };

  const handleCloseDetail = () => {
    setSelectedRecipe(null);
  };

  const handleRecipeUpdated = () => {
    setRecipes([]);
    setCurrentPage(1);
    setHasMore(true);
  };

  const handleRecipeDeleted = async () => {
    // Rafraîchir la liste des recettes après suppression
    setIsLoading(true);
    setError('');

    try {
      let response: PaginatedResponse<Recipe>;
      if (view === 'recommendations') {
        response = await api.getRecommendations(1, 12, sortBy);
      } else if (view === 'all') {
        response = await api.getAllRecipes(1, 12);
      } else {
        response = await api.getMyRecipes(1, 12);
      }

      setRecipes(response.data);
      setCurrentPage(1);
      setHasMore(response.pagination.has_next);
    } catch (err: any) {
      console.error('❌ Erreur chargement recettes:', err);
      setError(err.message || 'Erreur lors du chargement des recettes');
    } finally {
      setIsLoading(false);
    }
  };

  const handleViewChange = (newView: typeof view) => {
    setView(newView);
  };

  const handleCreateRecipe = () => {
    setIsCreatingRecipe(true);
  };

  const handleCreateRecipeClose = () => {
    setIsCreatingRecipe(false);
  };

  const handleCreateRecipeSave = async (recipe: Recipe) => {
    setIsCreatingRecipe(false);
    // Rafraîchir la liste des recettes - forcer le rechargement de la page 1
    setIsLoading(true);
    setError('');

    try {
      let response: PaginatedResponse<Recipe>;
      if (view === 'recommendations') {
        response = await api.getRecommendations(1, 12, sortBy);
      } else if (view === 'all') {
        response = await api.getAllRecipes(1, 12);
      } else {
        response = await api.getMyRecipes(1, 12);
      }

      setRecipes(response.data);
      setCurrentPage(1);
      setHasMore(response.pagination.has_next);
    } catch (err: any) {
      console.error('❌ Erreur chargement recettes:', err);
      setError(err.message || 'Erreur lors du chargement des recettes');
    } finally {
      setIsLoading(false);
    }
  };

  const canEditRecipe = (recipe: Recipe) => {
    if (!userProfile) return false;
    return userProfile.role === 'Administrator' || recipe.author_user_id === userProfile.user_id;
  };

  if (view === 'preferences') {
    return (
      <div className="dashboard">
        <header className="dashboard-header">
          <div className="header-content">
            <h1>🍳 Food Advisor</h1>
            <button className="logout-btn" onClick={onLogout}>
              Déconnexion
            </button>
          </div>
        </header>

        <nav className="dashboard-nav">
          <button onClick={() => handleViewChange('recommendations')}>
            Recommandations
          </button>
          <button onClick={() => handleViewChange('all')}>
            Toutes les recettes
          </button>
          <button onClick={() => handleViewChange('my')}>
            Mes recettes
          </button>
          <button className="active">
            Préférences
          </button>
          {userProfile?.role === 'Administrator' && (
            <button onClick={() => handleViewChange('stats')}>
              Statistiques
            </button>
          )}
        </nav>

        <PreferencesPage />
      </div>
    );
  }

  if (view === 'stats') {
    return (
      <div className="dashboard">
        <header className="dashboard-header">
          <div className="header-content">
            <h1>🍳 Food Advisor</h1>
            <button className="logout-btn" onClick={onLogout}>
              Déconnexion
            </button>
          </div>
        </header>

        <nav className="dashboard-nav">
          <button onClick={() => handleViewChange('recommendations')}>
            Recommandations
          </button>
          <button onClick={() => handleViewChange('all')}>
            Toutes les recettes
          </button>
          <button onClick={() => handleViewChange('my')}>
            Mes recettes
          </button>
          <button onClick={() => handleViewChange('preferences')}>
            Préférences
          </button>
          {userProfile?.role === 'Administrator' && (
            <button className="active">
              Statistiques
            </button>
          )}
        </nav>

        <StatsPage />
      </div>
    );
  }

  return (
    <div className="dashboard">
      <header className="dashboard-header">
        <div className="header-content">
          <h1>🍳 Food Advisor</h1>
          <button className="logout-btn" onClick={onLogout}>
            Déconnexion
          </button>
        </div>
      </header>

      <nav className="dashboard-nav">
        <button
          className={view === 'recommendations' ? 'active' : ''}
          onClick={() => handleViewChange('recommendations')}
        >
          Recommandations
        </button>
        <button
          className={view === 'all' ? 'active' : ''}
          onClick={() => handleViewChange('all')}
        >
          Toutes les recettes
        </button>
        <button
          className={view === 'my' ? 'active' : ''}
          onClick={() => handleViewChange('my')}
        >
          Mes recettes
        </button>
        <button
          onClick={() => handleViewChange('preferences')}
        >
          Préférences
        </button>
        {userProfile?.role === 'Administrator' && (
          <button
            onClick={() => handleViewChange('stats')}
          >
            Statistiques
          </button>
        )}
      </nav>

      {view === 'recommendations' && (
        <div className="filters">
          <label>Trier par :</label>
          <select value={sortBy} onChange={(e) => {
            setSortBy(e.target.value as any);
          }}>
            <option value="rating">Note</option>
            <option value="recent">Plus récent</option>
            <option value="difficulty">Difficulté</option>
            <option value="cost">Coût</option>
          </select>
        </div>
      )}

      {view === 'my' && (
        <div className="my-recipes-header" style={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          padding: '1rem 2rem',
          borderBottom: '1px solid #e0e0e0'
        }}>
          <h2 style={{ margin: 0 }}>Mes recettes</h2>
          <button
            onClick={handleCreateRecipe}
            style={{
              backgroundColor: '#4caf50',
              color: 'white',
              border: 'none',
              padding: '0.75rem 1.5rem',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '1rem',
              fontWeight: 'bold',
              transition: 'background-color 0.3s'
            }}
            onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#45a049'}
            onMouseLeave={(e) => e.currentTarget.style.backgroundColor = '#4caf50'}
          >
            + Créer une recette
          </button>
        </div>
      )}

      <main className="dashboard-main">
        {error && <div className="error-message">{error}</div>}

        {recipes.length === 0 && !isLoading ? (
          <div className="empty-state">
            <p>Aucune recette trouvée</p>
          </div>
        ) : (
          <>
            <div className="recipes-grid">
              {recipes.map((recipe, index) => {
                const isLast = recipes.length === index + 1;

                return (
                  <RecipeCard
                    key={recipe.recipe_id}
                    recipe={recipe}
                    onClick={() => handleRecipeClick(recipe.recipe_id)}
                    ref={isLast ? lastRecipeElementRef : null}
                  />
                );
              })}
            </div>

            {isLoading && (
              <div className="loading-state">
                <div className="spinner"></div>
                <p>Chargement...</p>
              </div>
            )}
          </>
        )}
      </main>

      {selectedRecipe && (
        <RecipeDetail
          recipe={selectedRecipe}
          onClose={handleCloseDetail}
          canEdit={canEditRecipe(selectedRecipe)}
          onRecipeUpdated={handleRecipeUpdated}
          onRecipeDeleted={handleRecipeDeleted}
        />
      )}

      {isCreatingRecipe && (
        <RecipeEditor
          onClose={handleCreateRecipeClose}
          onSave={handleCreateRecipeSave}
        />
      )}
    </div>
  );
};