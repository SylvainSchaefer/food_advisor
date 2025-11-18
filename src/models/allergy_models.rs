use chrono::NaiveDateTime;
use serde::{Deserialize, Serialize};

use crate::models::Ingredient;

#[derive(Debug, Serialize, Deserialize, sqlx::FromRow)]
pub struct Allergy {
    pub allergy_id: u32,
    pub name: String,
    pub description: Option<String>,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct AllergyWithIngredients {
    #[serde(flatten)]
    pub allergy: Allergy,
    pub ingredients: Vec<Ingredient>,
}

#[derive(Debug, Serialize, Deserialize, sqlx::FromRow)]
pub struct UserAllergy {
    pub user_id: u32,
    pub allergy_id: u32,
    pub name: String,
    pub description: Option<String>,
    pub severity: String,
    pub created_at: NaiveDateTime,
    pub updated_at: NaiveDateTime,
}

#[derive(Debug, Deserialize)]
pub struct CreateAllergyRequest {
    pub name: String,
    pub description: Option<String>,
}

#[derive(Debug, Deserialize)]
pub struct UpdateAllergyRequest {
    pub name: String,
    pub description: Option<String>,
}

#[derive(Debug, Deserialize)]
pub struct AddIngredientToAllergyRequest {
    pub ingredient_id: u32,
}

#[derive(Debug, Deserialize)]
pub struct AddUserAllergyRequest {
    pub severity: String, // "Mild", "Moderate", "Severe", "Life-threatening"
}
