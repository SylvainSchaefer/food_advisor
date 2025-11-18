import React, { useState, useEffect } from 'react';
import { Ingredient } from '../types';
import { api } from '../services/api';
import './IngredientModal.css';

interface IngredientModalProps {
  ingredient?: Ingredient | null;
  onClose: () => void;
  onSave: (ingredient: Ingredient) => void;
  isAdmin: boolean;
}

export const IngredientModal: React.FC<IngredientModalProps> = ({
  ingredient,
  onClose,
  onSave,
  isAdmin
}) => {
  const isEditing = ingredient !== null && ingredient !== undefined;
  const [formData, setFormData] = useState({
    name: ingredient?.name || '',
    carbohydrates: ingredient?.carbohydrates || '',
    proteins: ingredient?.proteins || '',
    fats: ingredient?.fats || '',
    fibers: ingredient?.fibers || '',
    calories: ingredient?.calories || '',
    price: ingredient?.price || '',
    weight: ingredient?.weight || '',
    measurement_unit: ingredient?.measurement_unit || ''
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setError('');

    try {
      let savedIngredient: Ingredient;

      if (isEditing && ingredient) {
        if (!isAdmin) {
          setError('Seuls les administrateurs peuvent modifier des ingrédients');
          setIsSubmitting(false);
          return;
        }
        savedIngredient = await api.updateIngredient(ingredient.ingredient_id, formData);
      } else {
        savedIngredient = await api.createIngredient(formData);
      }

      onSave(savedIngredient);
      onClose();
    } catch (err: any) {
      setError(err.message || 'Erreur lors de la sauvegarde de l\'ingrédient');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleOverlayClick = (e: React.MouseEvent) => {
    if (e.target === e.currentTarget) {
      onClose();
    }
  };

  return (
    <div className="ingredient-modal-overlay" onClick={handleOverlayClick}>
      <div className="ingredient-modal">
        <div className="modal-header">
          <h2>{isEditing ? 'Modifier l\'ingrédient' : 'Créer un nouvel ingrédient'}</h2>
          <button className="close-btn" onClick={onClose}>✕</button>
        </div>

        {error && <div className="error-message">{error}</div>}

        <form onSubmit={handleSubmit} className="ingredient-form">
          <div className="form-group">
            <label htmlFor="name">Nom *</label>
            <input
              id="name"
              type="text"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              required
              placeholder="Ex: Farine de blé"
            />
          </div>

          <div className="form-group">
            <label htmlFor="measurement_unit">Unité de mesure *</label>
            <select
              id="measurement_unit"
              value={formData.measurement_unit}
              onChange={(e) => setFormData({ ...formData, measurement_unit: e.target.value })}
              required
            >
              <option value="">-- Sélectionner une unité --</option>
              <option value="tablespoon">Cuillère à soupe (tablespoon)</option>
              <option value="teaspoon">Cuillère à café (teaspoon)</option>
              <option value="liters">Litres (liters)</option>
              <option value="milliliters">Millilitres (milliliters)</option>
              <option value="grams">Grammes (grams)</option>
              <option value="kilograms">Kilogrammes (kilograms)</option>
              <option value="cups">Tasses (cups)</option>
              <option value="pieces">Pièces (pieces)</option>
            </select>
          </div>

          <div className="form-row">
            <div className="form-group">
              <label htmlFor="weight">Poids (g)</label>
              <input
                id="weight"
                type="number"
                step="0.01"
                value={formData.weight}
                onChange={(e) => setFormData({ ...formData, weight: e.target.value })}
                placeholder="100"
              />
            </div>

            <div className="form-group">
              <label htmlFor="calories">Calories (kcal)</label>
              <input
                id="calories"
                type="number"
                step="0.01"
                value={formData.calories}
                onChange={(e) => setFormData({ ...formData, calories: e.target.value })}
                placeholder="150"
              />
            </div>
          </div>

          <div className="form-row">
            <div className="form-group">
              <label htmlFor="carbohydrates">Glucides (g)</label>
              <input
                id="carbohydrates"
                type="number"
                step="0.01"
                value={formData.carbohydrates}
                onChange={(e) => setFormData({ ...formData, carbohydrates: e.target.value })}
                placeholder="25"
              />
            </div>

            <div className="form-group">
              <label htmlFor="proteins">Protéines (g)</label>
              <input
                id="proteins"
                type="number"
                step="0.01"
                value={formData.proteins}
                onChange={(e) => setFormData({ ...formData, proteins: e.target.value })}
                placeholder="8"
              />
            </div>
          </div>

          <div className="form-row">
            <div className="form-group">
              <label htmlFor="fats">Lipides (g)</label>
              <input
                id="fats"
                type="number"
                step="0.01"
                value={formData.fats}
                onChange={(e) => setFormData({ ...formData, fats: e.target.value })}
                placeholder="2"
              />
            </div>

            <div className="form-group">
              <label htmlFor="fibers">Fibres (g)</label>
              <input
                id="fibers"
                type="number"
                step="0.01"
                value={formData.fibers}
                onChange={(e) => setFormData({ ...formData, fibers: e.target.value })}
                placeholder="3"
              />
            </div>
          </div>

          <div className="form-group">
            <label htmlFor="price">Prix (€)</label>
            <input
              id="price"
              type="number"
              step="0.01"
              value={formData.price}
              onChange={(e) => setFormData({ ...formData, price: e.target.value })}
              placeholder="2.50"
            />
          </div>

          <div className="modal-actions">
            <button
              type="button"
              className="btn-cancel"
              onClick={onClose}
              disabled={isSubmitting}
            >
              Annuler
            </button>
            <button
              type="submit"
              className="btn-save"
              disabled={isSubmitting}
            >
              {isSubmitting ? 'Sauvegarde...' : (isEditing ? 'Modifier' : 'Créer')}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};
