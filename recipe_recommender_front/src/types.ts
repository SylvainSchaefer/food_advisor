export interface Recipe {
  recipe_id: number;
  title: string;
  description: string;
  servings: number;
  difficulty: 'Easy' | 'Medium' | 'Hard';
  image_url?: string;
  author_user_id: number;
  is_published: boolean;
  created_at: string;
  updated_at: string;
  author_first_name: string;
  author_last_name: string;
  rating?: number;
  total_time?: number;
  ingredients?: RecipeIngredient[];
  steps?: RecipeStep[];
}

export interface RecipeIngredient {
  ingredient_id: number;
  name: string;
  quantity: number;
  is_optional: boolean;
  measurement_unit: string;
}

export interface RecipeStep {
  recipe_step_id: number;
  step_order: number;
  description: string;
  duration_minutes: number;
  step_type: string;
}

export interface Ingredient {
  ingredient_id: number;
  name: string;
  carbohydrates: string;
  proteins: string;
  fats: string;
  fibers: string;
  calories: string;
  price: string;
  weight: string;
  measurement_unit: string;
}

export interface User {
  user_id: number;
  email: string;
  first_name: string;
  last_name: string;
  gender: string;
  birth_date: string;
  country: string;
}

export interface AuthResponse {
  token: string;
  user?: User;
}

export interface LoginRequest {
  email: string;
  password: string;
}

export interface RegisterRequest {
  email: string;
  password: string;
  first_name: string;
  last_name: string;
  gender: 'Male' | 'Female' | 'Other';
  birth_date: string;
  country: string;
}

export interface PaginatedResponse<T> {
  data: T[];
  pagination: {
    current_page: number;
    page_size: number;
    total_count: number;
    total_pages: number;
    has_next: boolean;
    has_previous: boolean;
  };
}
export interface Allergy {
  allergy_id: number;
  name: string;
  description: string;
  severity?: 'Mild' | 'Moderate' | 'Severe';
}


export interface IngredientPreference {
  ingredient_id: number;
  preference_type: 'preferred' | 'excluded';
}

export interface CategoryPreference {
  category_id: number;
  category_name: string;
  preference_type: 'preferred' | 'excluded';
}

export interface UserProfile {
  user_id: number;
  email: string;
  first_name: string;
  last_name: string;
  role: 'User' | 'Administrator';
}

// Stats types
export interface GlobalStats {
  total_users: number;
  total_recipes: number;
  total_recipe_completions: number;
  average_rating: number;
  total_ingredients: number;
  total_allergies: number;
}

export interface TopCompletedRecipe {
  recipe_id: number;
  title: string;
  completion_count: number;
  average_rating?: number;
}

export interface TopRatedRecipe {
  recipe_id: number;
  title: string;
  average_rating: number;
  rating_count: number;
}

export interface TopIngredient {
  ingredient_id: number;
  name: string;
  recipe_count: number;
}

export interface CompletionByPeriod {
  period: string;
  completion_count: number;
}

export interface AllergyStats {
  allergy_id: number;
  name: string;
  mild_count: number;
  moderate_count: number;
  severe_count: number;
  life_threatening_count: number;
  total_user_count: number;
  percentage: number;
}

export interface ActiveUser {
  user_id: number;
  first_name: string;
  last_name: string;
  email: string;
  completed_recipes_count: number;
  average_rating_given: number;
}

export interface CategoryUsage {
  category_id: number;
  name: string;
  recipe_count: number;
  ingredient_count: number;
}

