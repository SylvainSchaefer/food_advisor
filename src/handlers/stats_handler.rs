use crate::models::{CompletionStatsPeriodParams, StatsLimitParams, TopRatedParams};
use crate::repositories::StatsRepository;
use actix_web::{web, HttpResponse};
use sqlx::MySqlPool;

// =====================================================
// HANDLERS - Statistiques (Admin uniquement)
// =====================================================

/// Récupérer les statistiques globales
pub async fn get_global_stats(pool: web::Data<MySqlPool>) -> HttpResponse {
    let stats_repo = StatsRepository::new(pool.get_ref().clone());

    match stats_repo.get_global_stats().await {
        Ok(stats) => HttpResponse::Ok().json(stats),
        Err(e) => {
            log::error!("Failed to retrieve global stats: {:?}", e);
            HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Failed to retrieve global statistics"
            }))
        }
    }
}

/// Récupérer le top des recettes complétées
pub async fn get_top_completed_recipes(
    pool: web::Data<MySqlPool>,
    query: web::Query<StatsLimitParams>,
) -> HttpResponse {
    let stats_repo = StatsRepository::new(pool.get_ref().clone());
    let params = query.into_inner();

    match stats_repo.get_top_completed_recipes(params.limit).await {
        Ok(recipes) => HttpResponse::Ok().json(recipes),
        Err(e) => {
            log::error!("Failed to retrieve top completed recipes: {:?}", e);
            HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Failed to retrieve top completed recipes"
            }))
        }
    }
}

/// Récupérer le top des recettes notées
pub async fn get_top_rated_recipes(
    pool: web::Data<MySqlPool>,
    query: web::Query<TopRatedParams>,
) -> HttpResponse {
    let stats_repo = StatsRepository::new(pool.get_ref().clone());
    let params = query.into_inner();

    match stats_repo
        .get_top_rated_recipes(params.limit, params.min_ratings)
        .await
    {
        Ok(recipes) => HttpResponse::Ok().json(recipes),
        Err(e) => {
            log::error!("Failed to retrieve top rated recipes: {:?}", e);
            HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Failed to retrieve top rated recipes"
            }))
        }
    }
}

/// Récupérer le top des ingrédients
pub async fn get_top_ingredients(
    pool: web::Data<MySqlPool>,
    query: web::Query<StatsLimitParams>,
) -> HttpResponse {
    let stats_repo = StatsRepository::new(pool.get_ref().clone());
    let params = query.into_inner();

    match stats_repo.get_top_ingredients(params.limit).await {
        Ok(ingredients) => HttpResponse::Ok().json(ingredients),
        Err(e) => {
            log::error!("Failed to retrieve top ingredients: {:?}", e);
            HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Failed to retrieve top ingredients"
            }))
        }
    }
}

/// Récupérer les statistiques de completion par période
pub async fn get_completion_stats_by_period(
    pool: web::Data<MySqlPool>,
    query: web::Query<CompletionStatsPeriodParams>,
) -> HttpResponse {
    let stats_repo = StatsRepository::new(pool.get_ref().clone());
    let params = query.into_inner();

    // Valider la période
    let valid_periods = vec!["day", "week", "month", "year"];
    let period = if valid_periods.contains(&params.period.as_str()) {
        params.period.as_str()
    } else {
        "day"
    };

    match stats_repo.get_completion_stats_by_period(period).await {
        Ok(stats) => HttpResponse::Ok().json(stats),
        Err(e) => {
            log::error!("Failed to retrieve completion stats by period: {:?}", e);
            HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Failed to retrieve completion statistics by period"
            }))
        }
    }
}

/// Récupérer les statistiques des allergies
pub async fn get_allergy_stats(pool: web::Data<MySqlPool>) -> HttpResponse {
    let stats_repo = StatsRepository::new(pool.get_ref().clone());

    match stats_repo.get_allergy_stats().await {
        Ok(stats) => HttpResponse::Ok().json(stats),
        Err(e) => {
            log::error!("Failed to retrieve allergy stats: {:?}", e);
            HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Failed to retrieve allergy statistics"
            }))
        }
    }
}

/// Récupérer les statistiques des utilisateurs actifs
pub async fn get_active_users_stats(
    pool: web::Data<MySqlPool>,
    query: web::Query<StatsLimitParams>,
) -> HttpResponse {
    let stats_repo = StatsRepository::new(pool.get_ref().clone());
    let params = query.into_inner();

    match stats_repo.get_active_users_stats(params.limit).await {
        Ok(stats) => HttpResponse::Ok().json(stats),
        Err(e) => {
            log::error!("Failed to retrieve active users stats: {:?}", e);
            HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Failed to retrieve active users statistics"
            }))
        }
    }
}

/// Récupérer les statistiques d'utilisation des catégories
pub async fn get_category_usage_stats(pool: web::Data<MySqlPool>) -> HttpResponse {
    let stats_repo = StatsRepository::new(pool.get_ref().clone());

    match stats_repo.get_category_usage_stats().await {
        Ok(stats) => HttpResponse::Ok().json(stats),
        Err(e) => {
            log::error!("Failed to retrieve category usage stats: {:?}", e);
            HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Failed to retrieve category usage statistics"
            }))
        }
    }
}
