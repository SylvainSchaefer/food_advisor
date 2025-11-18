import {
  Recipe,
  AuthResponse,
  LoginRequest,
  RegisterRequest,
  PaginatedResponse,
  Allergy,
  RecipeStep,
  RecipeIngredient,
  Ingredient,
  UserProfile,
  GlobalStats,
  TopCompletedRecipe,
  TopRatedRecipe,
  TopIngredient,
  CompletionByPeriod,
  AllergyStats,
  ActiveUser,
  CategoryUsage
} from '../types';

const API_BASE_URL = 'http://localhost:8080/api';

class ApiService {
  private getAuthHeader(): HeadersInit {
    const token = localStorage.getItem('auth_token');
    return {
      'Content-Type': 'application/json',
      ...(token && { 'Authorization': `Bearer ${token}` })
    };
  }

  private getAuthHeaderMultipart(): HeadersInit {
    const token = localStorage.getItem('auth_token');
    return {
      ...(token && { 'Authorization': `Bearer ${token}` })
    };
  }

  private async handleResponse<T>(response: Response): Promise<T> {
    if (response.status === 401) {
      // Token invalide ou expiré
      localStorage.removeItem('auth_token');
      window.location.href = '/';
      throw new Error('Non autorisé');
    }

    if (!response.ok) {
      const error = await response.text();
      throw new Error(error || 'Une erreur est survenue');
    }

    // Si la réponse est vide (204 No Content)
    if (response.status === 204) {
      return {} as T;
    }

    return response.json();
  }

  // Auth
  async login(credentials: LoginRequest): Promise<AuthResponse> {
    const response = await fetch(`${API_BASE_URL}/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(credentials)
    });
    return this.handleResponse<AuthResponse>(response);
  }

  async register(data: RegisterRequest): Promise<AuthResponse> {
    const response = await fetch(`${API_BASE_URL}/auth/register`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    });
    return this.handleResponse<AuthResponse>(response);
  }

  async getUserProfile(): Promise<UserProfile> {
    const response = await fetch(`${API_BASE_URL}/users/me`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<UserProfile>(response);
  }

  // Recipes
  async getRecommendations(
    page: number = 1,
    pageSize: number = 10,
    sortBy: string = 'rating'
  ): Promise<PaginatedResponse<Recipe>> {
    const response = await fetch(
      `${API_BASE_URL}/recommendations?page=${page}&page_size=${pageSize}&sort_by=${sortBy}`,
      {
        headers: this.getAuthHeader()
      }
    );
    const data = await this.handleResponse<PaginatedResponse<Recipe>>(response);

    // Charger les images pour chaque recette
    await this.loadRecipeImages(data.data);

    return data;
  }

  async getRecipe(id: number): Promise<Recipe> {
    const response = await fetch(`${API_BASE_URL}/recipes/${id}`, {
      headers: this.getAuthHeader()
    });
    const data = await this.handleResponse<Recipe>(response);
    const imageUrl = await this.getRecipeImage(data.recipe_id);
    if (imageUrl) {
      data.image_url = imageUrl;
    }

    return data;
  }

  async getAllRecipes(page: number = 1, pageSize: number = 10): Promise<PaginatedResponse<Recipe>> {
    const response = await fetch(
      `${API_BASE_URL}/recipes?page=${page}&page_size=${pageSize}`,
      {
        headers: this.getAuthHeader()
      }
    );
    const data = await this.handleResponse<PaginatedResponse<Recipe>>(response);

    // Charger les images pour chaque recette
    await this.loadRecipeImages(data.data);

    return data;
  }

  async getMyRecipes(page: number = 1, pageSize: number = 10): Promise<PaginatedResponse<Recipe>> {
    const response = await fetch(
      `${API_BASE_URL}/recipes/my-recipes?page=${page}&page_size=${pageSize}`,
      {
        headers: this.getAuthHeader()
      }
    );
    const data = await this.handleResponse<PaginatedResponse<Recipe>>(response);

    // Charger les images pour chaque recette
    await this.loadRecipeImages(data.data);

    return data;
  }

  // Fonction utilitaire pour charger les images
  private async loadRecipeImages(recipes: Recipe[]): Promise<void> {
    await Promise.all(
      recipes.map(async (recipe) => {
        const imageUrl = await this.getRecipeImage(recipe.recipe_id);
        if (imageUrl) {
          recipe.image_url = imageUrl;
        }
      })
    );
  }

  async getRecipeImage(id: number): Promise<string | null> {
    try {
      const response = await fetch(`${API_BASE_URL}/recipes/${id}/image`, {
        headers: this.getAuthHeader()
      });

      if (!response.ok) {
        // Ne pas logger les 404, c'est normal qu'une recette n'ait pas d'image
        if (response.status !== 404) {
          console.error(`Error fetching image for recipe ${id}: ${response.status}`);
        }
        return null;
      }

      const blob = await response.blob();
      return URL.createObjectURL(blob);
    } catch (error) {
      // Ne logger que les vraies erreurs (réseau, etc.), pas les 404
      console.error(`Network error fetching image for recipe ${id}:`, error);
      return null;
    }
  }

  async createRecipe(recipe: Partial<Recipe>): Promise<Recipe> {
    const response = await fetch(`${API_BASE_URL}/recipes`, {
      method: 'POST',
      headers: this.getAuthHeader(),
      body: JSON.stringify(recipe)
    });
    return this.handleResponse<Recipe>(response);
  }

  async updateRecipe(id: number, recipe: Partial<Recipe>): Promise<Recipe> {
    const response = await fetch(`${API_BASE_URL}/recipes/${id}`, {
      method: 'PUT',
      headers: this.getAuthHeader(),
      body: JSON.stringify(recipe)
    });
    return this.handleResponse<Recipe>(response);
  }

  async deleteRecipe(id: number): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/recipes/${id}`, {
      method: 'DELETE',
      headers: this.getAuthHeader()
    });
    return this.handleResponse<void>(response);
  }

  async uploadRecipeImage(recipeId: number, imageFile: File, isPrimary: boolean = true): Promise<void> {
    const formData = new FormData();
    formData.append('image', imageFile);
    formData.append('is_primary', isPrimary.toString());

    const response = await fetch(`${API_BASE_URL}/recipes/${recipeId}/image`, {
      method: 'POST',
      headers: this.getAuthHeaderMultipart(),
      body: formData
    });
    return this.handleResponse<void>(response);
  }

  // Recipe Steps
  async getRecipeSteps(recipeId: number): Promise<RecipeStep[]> {
    const response = await fetch(`${API_BASE_URL}/recipes/${recipeId}/steps`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<RecipeStep[]>(response);
  }

  async addRecipeStep(recipeId: number, step: Partial<RecipeStep>): Promise<RecipeStep> {
    const response = await fetch(`${API_BASE_URL}/recipes/${recipeId}/steps`, {
      method: 'POST',
      headers: this.getAuthHeader(),
      body: JSON.stringify(step)
    });
    return this.handleResponse<RecipeStep>(response);
  }

  async updateRecipeStep(recipeId: number, stepId: number, step: Partial<RecipeStep>): Promise<RecipeStep> {
    const response = await fetch(`${API_BASE_URL}/recipes/${recipeId}/steps/${stepId}`, {
      method: 'PUT',
      headers: this.getAuthHeader(),
      body: JSON.stringify(step)
    });
    return this.handleResponse<RecipeStep>(response);
  }

  async deleteRecipeStep(recipeId: number, stepId: number): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/recipes/${recipeId}/steps/${stepId}`, {
      method: 'DELETE',
      headers: this.getAuthHeader()
    });
    return this.handleResponse<void>(response);
  }

  // Recipe Ingredients
  async addRecipeIngredient(recipeId: number, ingredient: { ingredient_id: number; quantity: number; is_optional: boolean }): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/recipes/${recipeId}/ingredients`, {
      method: 'POST',
      headers: this.getAuthHeader(),
      body: JSON.stringify(ingredient)
    });
    return this.handleResponse<void>(response);
  }

  async removeRecipeIngredient(recipeId: number, ingredientId: number): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/recipes/${recipeId}/ingredients/${ingredientId}`, {
      method: 'DELETE',
      headers: this.getAuthHeader()
    });
    return this.handleResponse<void>(response);
  }

  // Ingredients
  async getAllIngredients(page: number = 1, pageSize: number = 100): Promise<PaginatedResponse<Ingredient>> {
    const response = await fetch(
      `${API_BASE_URL}/ingredients?page=${page}&page_size=${pageSize}`,
      {
        headers: this.getAuthHeader()
      }
    );
    return this.handleResponse<PaginatedResponse<Ingredient>>(response);
  }

  async createIngredient(ingredient: Partial<Ingredient>): Promise<Ingredient> {
    const response = await fetch(`${API_BASE_URL}/ingredients`, {
      method: 'POST',
      headers: this.getAuthHeader(),
      body: JSON.stringify(ingredient)
    });
    return this.handleResponse<Ingredient>(response);
  }

  async updateIngredient(ingredientId: number, ingredient: Partial<Ingredient>): Promise<Ingredient> {
    const response = await fetch(`${API_BASE_URL}/ingredients/${ingredientId}`, {
      method: 'PUT',
      headers: this.getAuthHeader(),
      body: JSON.stringify(ingredient)
    });
    return this.handleResponse<Ingredient>(response);
  }

  async deleteIngredient(ingredientId: number): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/ingredients/${ingredientId}`, {
      method: 'DELETE',
      headers: this.getAuthHeader()
    });
    return this.handleResponse<void>(response);
  }


  async completeRecipe(recipeId: number, rating?: number, comment?: string): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/recipes/${recipeId}/complete`, {
      method: 'POST',
      headers: this.getAuthHeader(),
      body: JSON.stringify({ rating, comment })
    });
    return this.handleResponse<void>(response);
  }

  // Allergies
  async getMyAllergies(): Promise<Allergy[]> {
    const response = await fetch(`${API_BASE_URL}/my-allergies`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<Allergy[]>(response);
  }

  async addUserAllergy(allergyId: number, severity: string): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/my-allergies/${allergyId}`, {
      method: 'PUT',
      headers: this.getAuthHeader(),
      body: JSON.stringify({ severity })
    });
    return this.handleResponse<void>(response);
  }

  async removeUserAllergy(allergyId: number): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/my-allergies/${allergyId}`, {
      method: 'DELETE',
      headers: this.getAuthHeader()
    });
    return this.handleResponse<void>(response);
  }

  async getAllAllergies(): Promise<Allergy[]> {
    const response = await fetch(`${API_BASE_URL}/allergies`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<Allergy[]>(response);
  }

  // Preferences (supposant que ces endpoints existent)
  async getMyIngredientPreferences(): Promise<any[]> {
    const response = await fetch(`${API_BASE_URL}/preferences/ingredients`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<any[]>(response);
  }

  async setIngredientPreference(ingredientId: number, preferenceType: 'preferred' | 'excluded'): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/preferences/ingredients/${ingredientId}`, {
      method: 'PUT',
      headers: this.getAuthHeader(),
      body: JSON.stringify({ preference_type: preferenceType })
    });
    return this.handleResponse<void>(response);
  }

  async removeIngredientPreference(ingredientId: number): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/preferences/ingredients/${ingredientId}`, {
      method: 'DELETE',
      headers: this.getAuthHeader()
    });
    return this.handleResponse<void>(response);
  }

  async getMyCategoryPreferences(): Promise<any[]> {
    const response = await fetch(`${API_BASE_URL}/preferences/categories`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<any[]>(response);
  }

  async setCategoryPreference(categoryId: number, preferenceType: 'preferred' | 'excluded'): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/preferences/categories`, {
      method: 'POST',
      headers: this.getAuthHeader(),
      body: JSON.stringify({ category_id: categoryId, preference_type: preferenceType })
    });
    return this.handleResponse<void>(response);
  }

  async removeCategoryPreference(categoryId: number): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/preferences/categories/${categoryId}`, {
      method: 'DELETE',
      headers: this.getAuthHeader()
    });
    return this.handleResponse<void>(response);
  }

  // Statistics (Admin only)
  async getGlobalStats(): Promise<GlobalStats> {
    const response = await fetch(`${API_BASE_URL}/stats/global`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<GlobalStats>(response);
  }

  async getTopCompletedRecipes(limit: number = 10): Promise<TopCompletedRecipe[]> {
    const response = await fetch(`${API_BASE_URL}/stats/recipes/top-completed?limit=${limit}`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<TopCompletedRecipe[]>(response);
  }

  async getTopRatedRecipes(limit: number = 10, minRatings: number = 1): Promise<TopRatedRecipe[]> {
    const response = await fetch(`${API_BASE_URL}/stats/recipes/top-rated?limit=${limit}&min_ratings=${minRatings}`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<TopRatedRecipe[]>(response);
  }

  async getTopIngredients(limit: number = 10): Promise<TopIngredient[]> {
    const response = await fetch(`${API_BASE_URL}/stats/ingredients/top?limit=${limit}`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<TopIngredient[]>(response);
  }

  async getCompletionsByPeriod(period: 'day' | 'week' | 'month' | 'year'): Promise<CompletionByPeriod[]> {
    const response = await fetch(`${API_BASE_URL}/stats/completions/by-period?period=${period}`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<CompletionByPeriod[]>(response);
  }

  async getAllergiesStats(): Promise<AllergyStats[]> {
    const response = await fetch(`${API_BASE_URL}/stats/allergies`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<AllergyStats[]>(response);
  }

  async getActiveUsers(limit: number = 10): Promise<ActiveUser[]> {
    const response = await fetch(`${API_BASE_URL}/stats/users/active?limit=${limit}`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<ActiveUser[]>(response);
  }

  async getCategoriesUsage(): Promise<CategoryUsage[]> {
    const response = await fetch(`${API_BASE_URL}/stats/categories/usage`, {
      headers: this.getAuthHeader()
    });
    return this.handleResponse<CategoryUsage[]>(response);
  }
}

export const api = new ApiService();
