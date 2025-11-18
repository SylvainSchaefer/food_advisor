use rust_decimal::Decimal;
use serde::{Deserialize, Serialize};

// Statistiques globales
#[derive(Debug, Serialize, Deserialize, sqlx::FromRow)]
pub struct GlobalStats {
    pub total_users: i64,
    pub total_admins: i64,
    pub total_recipes: i64,
    pub published_recipes: i64,
    pub unpublished_recipes: i64,
    pub total_ingredients: i64,
    pub total_categories: i64,
    pub total_allergies: i64,
    pub total_recipe_completions: i64,
    pub average_rating: Decimal,
}

// Top recettes complétées
#[derive(Debug, Serialize, Deserialize, sqlx::FromRow)]
pub struct TopCompletedRecipe {
    pub recipe_id: u32,
    pub title: String,
    pub difficulty: String,
    pub completion_count: i64,
    pub average_rating: Decimal,
}

// Top recettes notées
#[derive(Debug, Serialize, Deserialize, sqlx::FromRow)]
pub struct TopRatedRecipe {
    pub recipe_id: u32,
    pub title: String,
    pub difficulty: String,
    pub rating_count: i64,
    pub average_rating: Decimal,
}

// Top ingrédients
#[derive(Debug, Serialize, Deserialize, sqlx::FromRow)]
pub struct TopIngredient {
    pub ingredient_id: u32,
    pub name: String,
    pub measurement_unit: String,
    pub recipe_count: i64,
}

// Statistiques par période
#[derive(Debug, Serialize, Deserialize, sqlx::FromRow)]
pub struct CompletionStatsByPeriod {
    pub period: String,
    pub completion_count: i64,
    pub average_rating: Decimal,
}

// Statistiques des allergies
#[derive(Debug, Serialize, Deserialize, sqlx::FromRow)]
pub struct AllergyStats {
    pub allergy_id: u32,
    pub name: String,
    pub mild_count: i64,
    pub moderate_count: i64,
    pub severe_count: i64,
    pub life_threatening_count: i64,
    pub total_user_count: i64,
    pub percentage: Decimal,
}

// Statistiques des utilisateurs actifs
#[derive(Debug, Serialize, Deserialize, sqlx::FromRow)]
pub struct ActiveUserStats {
    pub user_id: u32,
    pub first_name: String,
    pub last_name: String,
    pub completed_recipes_count: i64,
    pub average_rating_given: Decimal,
}

// Statistiques des catégories
#[derive(Debug, Serialize, Deserialize, sqlx::FromRow)]
pub struct CategoryUsageStats {
    pub category_id: u32,
    pub name: String,
    pub ingredient_count: i64,
    pub recipe_count: i64,
}

// Paramètres pour les requêtes de statistiques
#[derive(Debug, Deserialize)]
pub struct StatsLimitParams {
    #[serde(default = "default_limit")]
    pub limit: i32,
}

fn default_limit() -> i32 {
    10
}

#[derive(Debug, Deserialize)]
pub struct TopRatedParams {
    #[serde(default = "default_limit")]
    pub limit: i32,
    #[serde(default = "default_min_ratings")]
    pub min_ratings: i32,
}

fn default_min_ratings() -> i32 {
    1
}

#[derive(Debug, Deserialize)]
pub struct CompletionStatsPeriodParams {
    #[serde(default = "default_period")]
    pub period: String, // 'day', 'week', 'month', 'year'
}

fn default_period() -> String {
    "day".to_string()
}
