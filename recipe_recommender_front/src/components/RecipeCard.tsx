import React from 'react';
import { Recipe } from '../types';
import './RecipeCard.css';

interface RecipeCardProps {
  recipe: Recipe;
  onClick: () => void;
}

export const RecipeCard = React.forwardRef<HTMLDivElement, RecipeCardProps>(
  ({ recipe, onClick }, ref) => {
    const getDifficultyColor = (difficulty: string) => {
      switch (difficulty) {
        case 'Easy':
          return '#4CAF50';
        case 'Medium':
          return '#FF9800';
        case 'Hard':
          return '#F44336';
        default:
          return '#9E9E9E';
      }
    };

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

    return (
      <div className="recipe-card" onClick={onClick} ref={ref}>
        <div className="recipe-image">
          {recipe.image_url ? (
            <img src={recipe.image_url} alt={recipe.title} />
          ) : (
            <div className="recipe-image-placeholder">
              <span>🍽️</span>
            </div>
          )}
          {recipe.rating && (
            <div className="recipe-rating">
              ⭐ {recipe.rating.toFixed(1)}
            </div>
          )}
        </div>

        <div className="recipe-content">
          <h3 className="recipe-title">{recipe.title}</h3>
          <p className="recipe-description">{recipe.description}</p>

          <div className="recipe-meta">
            <span
              className="recipe-difficulty"
              style={{ color: getDifficultyColor(recipe.difficulty) }}
            >
              {getDifficultyLabel(recipe.difficulty)}
            </span>
            <span className="recipe-servings">
              👥 {recipe.servings} {recipe.servings > 1 ? 'portions' : 'portion'}
            </span>
          </div>

          {recipe.total_time && (
            <div className="recipe-time">
              ⏱️ {recipe.total_time} min
            </div>
          )}

          <div className="recipe-author">
            Par {recipe.author_first_name} {recipe.author_last_name}
          </div>
        </div>
      </div>
    );
  }
);
