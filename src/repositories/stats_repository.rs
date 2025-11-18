use crate::models::{
    ActiveUserStats, AllergyStats, CategoryUsageStats, CompletionStatsByPeriod, GlobalStats,
    TopCompletedRecipe, TopIngredient, TopRatedRecipe,
};
use chrono::NaiveDate;
use sqlx::{Error, MySqlPool, Row, mysql::MySqlRow};

pub struct StatsRepository {
    pool: MySqlPool,
}

impl StatsRepository {
    pub fn new(pool: MySqlPool) -> Self {
        Self { pool }
    }

    // Récupérer les statistiques globales
    pub async fn get_global_stats(&self) -> Result<GlobalStats, Error> {
        let result = sqlx::query("CALL sp_get_global_stats()")
            .fetch_one(&self.pool)
            .await?;

        Ok(GlobalStats {
            total_users: result.get(0),
            total_admins: result.get(1),
            total_recipes: result.get(2),
            published_recipes: result.get(3),
            unpublished_recipes: result.get(4),
            total_ingredients: result.get(5),
            total_categories: result.get(6),
            total_allergies: result.get(7),
            total_recipe_completions: result.get(8),
            average_rating: result.get(9),
        })
    }

    // Récupérer le top des recettes complétées
    pub async fn get_top_completed_recipes(
        &self,
        limit: i32,
    ) -> Result<Vec<TopCompletedRecipe>, Error> {
        let results = sqlx::query("CALL sp_get_top_completed_recipes(?)")
            .bind(limit)
            .fetch_all(&self.pool)
            .await?;

        let recipes = results
            .iter()
            .map(|row| TopCompletedRecipe {
                recipe_id: row.get(0),
                title: row.get(1),
                difficulty: row.get(2),
                completion_count: row.get(3),
                average_rating: row.get(4),
            })
            .collect();

        Ok(recipes)
    }

    // Récupérer le top des recettes notées
    pub async fn get_top_rated_recipes(
        &self,
        limit: i32,
        min_ratings: i32,
    ) -> Result<Vec<TopRatedRecipe>, Error> {
        let results = sqlx::query("CALL sp_get_top_rated_recipes(?, ?)")
            .bind(limit)
            .bind(min_ratings)
            .fetch_all(&self.pool)
            .await?;

        let recipes = results
            .iter()
            .map(|row| TopRatedRecipe {
                recipe_id: row.get(0),
                title: row.get(1),
                difficulty: row.get(2),
                rating_count: row.get(3),
                average_rating: row.get(4),
            })
            .collect();

        Ok(recipes)
    }

    // Récupérer le top des ingrédients
    pub async fn get_top_ingredients(&self, limit: i32) -> Result<Vec<TopIngredient>, Error> {
        let results = sqlx::query("CALL sp_get_top_ingredients(?)")
            .bind(limit)
            .fetch_all(&self.pool)
            .await?;

        let ingredients = results
            .iter()
            .map(|row| TopIngredient {
                ingredient_id: row.get(0),
                name: row.get(1),
                measurement_unit: row.get(2),
                recipe_count: row.get(3),
            })
            .collect();

        Ok(ingredients)
    }

    // Récupérer les statistiques de completion par période
    pub async fn get_completion_stats_by_period(
        &self,
        period: &str,
    ) -> Result<Vec<CompletionStatsByPeriod>, Error> {
        let results = sqlx::query("CALL sp_get_completion_stats_by_period(?)")
            .bind(period)
            .fetch_all(&self.pool)
            .await?;

        let stats = results
            .iter()
            .map(|row| CompletionStatsByPeriod {
                period: row.get::<NaiveDate, _>(0).to_string(), // Convertir en String si nécessaire
                completion_count: row.get(1),
                average_rating: row.get(2),
            })
            .collect();

        Ok(stats)
    }

    // Récupérer les statistiques des allergies
    pub async fn get_allergy_stats(&self) -> Result<Vec<AllergyStats>, Error> {
        let results = sqlx::query("CALL sp_get_allergy_stats()")
            .fetch_all(&self.pool)
            .await?;

        let stats = results
            .iter()
            .map(|row| AllergyStats {
                allergy_id: row.get(0),
                name: row.get(1),
                mild_count: row.get(2),
                moderate_count: row.get(3),
                severe_count: row.get(4),
                life_threatening_count: row.get(5),
                total_user_count: row.get(6),
                percentage: row.get(7),
            })
            .collect();

        Ok(stats)
    }
    // Récupérer les statistiques des utilisateurs actifs
    pub async fn get_active_users_stats(&self, limit: i32) -> Result<Vec<ActiveUserStats>, Error> {
        let results = sqlx::query("CALL sp_get_active_users_stats(?)")
            .bind(limit)
            .fetch_all(&self.pool)
            .await?;

        let stats = results
            .iter()
            .map(|row| ActiveUserStats {
                user_id: row.get(0),
                first_name: row.get(1),
                last_name: row.get(2),
                completed_recipes_count: row.get(3),
                average_rating_given: row.get(4),
            })
            .collect();

        Ok(stats)
    }

    // Récupérer les statistiques d'utilisation des catégories
    pub async fn get_category_usage_stats(&self) -> Result<Vec<CategoryUsageStats>, Error> {
        let results = sqlx::query("CALL sp_get_category_usage_stats()")
            .fetch_all(&self.pool)
            .await?;

        let stats = results
            .iter()
            .map(|row| CategoryUsageStats {
                category_id: row.get(0),
                name: row.get(1),
                ingredient_count: row.get(2),
                recipe_count: row.get(3),
            })
            .collect();

        Ok(stats)
    }
}
