use crate::models::{
    AddIngredientToAllergyRequest, AddUserAllergyRequest, CreateAllergyRequest, TokenClaims,
    UpdateAllergyRequest,
};
use crate::repositories::AllergyRepository;
use actix_web::{HttpResponse, web};
use sqlx::MySqlPool;

// Helper pour extraire user_id
fn extract_user_id(claims: &TokenClaims) -> Result<i32, HttpResponse> {
    match claims.sub.parse::<i32>() {
        Ok(id) => Ok(id),
        Err(_) => {
            log::error!("Invalid user_id in claims");
            Err(HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Invalid user identifier"
            })))
        }
    }
}

// =====================================================
// GESTION DES ALLERGIES
// =====================================================

/// Récupérer toutes les allergies (accessible à tous les utilisateurs authentifiés)
pub async fn get_all_allergies(pool: web::Data<MySqlPool>) -> HttpResponse {
    let repo = AllergyRepository::new(pool.get_ref().clone());

    match repo.get_all_allergies().await {
        Ok(allergies) => HttpResponse::Ok().json(allergies),
        Err(e) => {
            log::error!("Failed to retrieve allergies: {:?}", e);
            HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Failed to retrieve allergies"
            }))
        }
    }
}

/// Récupérer une allergie par ID avec ses ingrédients (accessible à tous)
pub async fn get_allergy(pool: web::Data<MySqlPool>, allergy_id: web::Path<i32>) -> HttpResponse {
    let repo = AllergyRepository::new(pool.get_ref().clone());

    match repo.find_allergy_by_id(*allergy_id).await {
        Ok(Some(allergy)) => HttpResponse::Ok().json(allergy),
        Ok(None) => HttpResponse::NotFound().json(serde_json::json!({
            "error": "Allergy not found"
        })),
        Err(e) => {
            log::error!("Failed to retrieve allergy: {:?}", e);
            HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Failed to retrieve allergy"
            }))
        }
    }
}

/// Créer une allergie (réservé aux administrateurs)
pub async fn create_allergy(
    pool: web::Data<MySqlPool>,
    req: web::Json<CreateAllergyRequest>,
    claims: web::ReqData<TokenClaims>,
) -> HttpResponse {
    let repo = AllergyRepository::new(pool.get_ref().clone());

    let user_id = match extract_user_id(&claims) {
        Ok(id) => id,
        Err(response) => return response,
    };

    match repo
        .create_allergy(&req.name, req.description.as_deref(), user_id)
        .await
    {
        Ok(allergy_id) => match repo.find_allergy_by_id(allergy_id).await {
            Ok(Some(allergy)) => HttpResponse::Created().json(allergy),
            Ok(None) => HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Allergy created but could not be retrieved"
            })),
            Err(e) => {
                log::error!("Failed to retrieve created allergy: {:?}", e);
                HttpResponse::InternalServerError().json(serde_json::json!({
                    "error": "Allergy created but failed to retrieve"
                }))
            }
        },
        Err(e) => {
            log::error!("Failed to create allergy: {:?}", e);

            let error_msg = format!("{:?}", e);
            if error_msg.contains("already exists") || error_msg.contains("DUPLICATE") {
                HttpResponse::Conflict().json(serde_json::json!({
                    "error": "Allergy with this name already exists"
                }))
            } else {
                HttpResponse::InternalServerError().json(serde_json::json!({
                    "error": "Failed to create allergy"
                }))
            }
        }
    }
}

/// Modifier une allergie (réservé aux administrateurs)
pub async fn update_allergy(
    pool: web::Data<MySqlPool>,
    allergy_id: web::Path<i32>,
    req: web::Json<UpdateAllergyRequest>,
    claims: web::ReqData<TokenClaims>,
) -> HttpResponse {
    let repo = AllergyRepository::new(pool.get_ref().clone());

    let user_id = match extract_user_id(&claims) {
        Ok(id) => id,
        Err(response) => return response,
    };

    match repo
        .update_allergy(*allergy_id, &req.name, req.description.as_deref(), user_id)
        .await
    {
        Ok(()) => match repo.find_allergy_by_id(*allergy_id).await {
            Ok(Some(allergy)) => HttpResponse::Ok().json(allergy),
            Ok(None) => HttpResponse::NotFound().json(serde_json::json!({
                "error": "Allergy not found"
            })),
            Err(e) => {
                log::error!("Failed to retrieve updated allergy: {:?}", e);
                HttpResponse::InternalServerError().json(serde_json::json!({
                    "error": "Allergy updated but failed to retrieve"
                }))
            }
        },
        Err(e) => {
            log::error!("Failed to update allergy: {:?}", e);

            let error_msg = format!("{:?}", e);
            if error_msg.contains("not found") {
                HttpResponse::NotFound().json(serde_json::json!({
                    "error": "Allergy not found"
                }))
            } else if error_msg.contains("already exists") || error_msg.contains("DUPLICATE") {
                HttpResponse::Conflict().json(serde_json::json!({
                    "error": "Allergy with this name already exists"
                }))
            } else {
                HttpResponse::InternalServerError().json(serde_json::json!({
                    "error": "Failed to update allergy"
                }))
            }
        }
    }
}

/// Supprimer une allergie (réservé aux administrateurs)
pub async fn delete_allergy(
    pool: web::Data<MySqlPool>,
    allergy_id: web::Path<i32>,
    claims: web::ReqData<TokenClaims>,
) -> HttpResponse {
    let repo = AllergyRepository::new(pool.get_ref().clone());

    let user_id = match extract_user_id(&claims) {
        Ok(id) => id,
        Err(response) => return response,
    };

    match repo.delete_allergy(*allergy_id, user_id).await {
        Ok(()) => HttpResponse::NoContent().finish(),
        Err(e) => {
            log::error!("Failed to delete allergy: {:?}", e);

            let error_msg = format!("{:?}", e);
            if error_msg.contains("not found") {
                HttpResponse::NotFound().json(serde_json::json!({
                    "error": "Allergy not found"
                }))
            } else {
                HttpResponse::InternalServerError().json(serde_json::json!({
                    "error": "Failed to delete allergy"
                }))
            }
        }
    }
}

// =====================================================
// GESTION DES ASSOCIATIONS INGRÉDIENT-ALLERGIE
// =====================================================

/// Ajouter un ingrédient à une allergie (réservé aux administrateurs)
pub async fn add_ingredient_to_allergy(
    pool: web::Data<MySqlPool>,
    allergy_id: web::Path<i32>,
    req: web::Json<AddIngredientToAllergyRequest>,
    claims: web::ReqData<TokenClaims>,
) -> HttpResponse {
    let repo = AllergyRepository::new(pool.get_ref().clone());

    let user_id = match extract_user_id(&claims) {
        Ok(id) => id,
        Err(response) => return response,
    };

    match repo
        .add_ingredient_to_allergy(*allergy_id, req.ingredient_id, user_id)
        .await
    {
        Ok(()) => HttpResponse::Ok().json(serde_json::json!({
            "message": "Ingredient added to allergy successfully"
        })),
        Err(e) => {
            log::error!("Failed to add ingredient to allergy: {:?}", e);

            let error_msg = format!("{:?}", e);
            if error_msg.contains("Allergy not found") {
                HttpResponse::NotFound().json(serde_json::json!({
                    "error": "Allergy not found"
                }))
            } else if error_msg.contains("Ingredient not found") {
                HttpResponse::NotFound().json(serde_json::json!({
                    "error": "Ingredient not found"
                }))
            } else if error_msg.contains("already associated") {
                HttpResponse::Conflict().json(serde_json::json!({
                    "error": "Ingredient already associated with this allergy"
                }))
            } else {
                HttpResponse::InternalServerError().json(serde_json::json!({
                    "error": "Failed to add ingredient to allergy"
                }))
            }
        }
    }
}

/// Supprimer un ingrédient d'une allergie (réservé aux administrateurs)
pub async fn remove_ingredient_from_allergy(
    pool: web::Data<MySqlPool>,
    path: web::Path<(i32, i32)>,
    claims: web::ReqData<TokenClaims>,
) -> HttpResponse {
    let (allergy_id, ingredient_id) = path.into_inner();
    let repo = AllergyRepository::new(pool.get_ref().clone());

    let user_id = match extract_user_id(&claims) {
        Ok(id) => id,
        Err(response) => return response,
    };

    match repo
        .remove_ingredient_from_allergy(allergy_id, ingredient_id, user_id)
        .await
    {
        Ok(()) => HttpResponse::NoContent().finish(),
        Err(e) => {
            log::error!("Failed to remove ingredient from allergy: {:?}", e);

            let error_msg = format!("{:?}", e);
            if error_msg.contains("not found") {
                HttpResponse::NotFound().json(serde_json::json!({
                    "error": "Association not found"
                }))
            } else {
                HttpResponse::InternalServerError().json(serde_json::json!({
                    "error": "Failed to remove ingredient from allergy"
                }))
            }
        }
    }
}

// =====================================================
// GESTION DES ALLERGIES UTILISATEUR
// =====================================================

/// Ajouter une allergie à l'utilisateur connecté
pub async fn add_user_allergy(
    pool: web::Data<MySqlPool>,
    allergy_id: web::Path<i32>,
    req: web::Json<AddUserAllergyRequest>,
    claims: web::ReqData<TokenClaims>,
) -> HttpResponse {
    let repo = AllergyRepository::new(pool.get_ref().clone());

    let user_id = match extract_user_id(&claims) {
        Ok(id) => id,
        Err(response) => return response,
    };

    match repo
        .add_user_allergy(user_id, *allergy_id, &req.severity)
        .await
    {
        Ok(()) => HttpResponse::Ok().json(serde_json::json!({
            "message": "Allergy added successfully"
        })),
        Err(e) => {
            log::error!("Failed to add user allergy: {:?}", e);

            let error_msg = format!("{:?}", e);
            if error_msg.contains("not found") {
                HttpResponse::NotFound().json(serde_json::json!({
                    "error": "Allergy not found"
                }))
            } else if error_msg.contains("Invalid severity") {
                HttpResponse::BadRequest().json(serde_json::json!({
                    "error": "Invalid severity. Must be Mild, Moderate, Severe or Life-threatening"
                }))
            } else {
                HttpResponse::InternalServerError().json(serde_json::json!({
                    "error": "Failed to add allergy"
                }))
            }
        }
    }
}

/// Supprimer une allergie de l'utilisateur connecté
pub async fn remove_user_allergy(
    pool: web::Data<MySqlPool>,
    allergy_id: web::Path<i32>,
    claims: web::ReqData<TokenClaims>,
) -> HttpResponse {
    let repo = AllergyRepository::new(pool.get_ref().clone());

    let user_id = match extract_user_id(&claims) {
        Ok(id) => id,
        Err(response) => return response,
    };

    match repo.remove_user_allergy(user_id, *allergy_id).await {
        Ok(()) => HttpResponse::NoContent().finish(),
        Err(e) => {
            log::error!("Failed to remove user allergy: {:?}", e);
            HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Failed to remove allergy"
            }))
        }
    }
}

/// Récupérer toutes les allergies de l'utilisateur connecté
pub async fn get_user_allergies(
    pool: web::Data<MySqlPool>,
    claims: web::ReqData<TokenClaims>,
) -> HttpResponse {
    let repo = AllergyRepository::new(pool.get_ref().clone());

    let user_id = match extract_user_id(&claims) {
        Ok(id) => id,
        Err(response) => return response,
    };

    match repo.get_user_allergies(user_id).await {
        Ok(allergies) => HttpResponse::Ok().json(allergies),
        Err(e) => {
            log::error!("Failed to retrieve user allergies: {:?}", e);
            HttpResponse::InternalServerError().json(serde_json::json!({
                "error": "Failed to retrieve allergies"
            }))
        }
    }
}
