pub mod admin_handler;
pub mod allergy_handler;
pub mod image_handler;
pub mod ingredient_categories_handler;
pub mod ingredient_handler;
pub mod recipe_handler;
pub mod stats_handler;
pub mod user_handler;
pub mod user_preferences_handler;

// Ré-exports optionnels pour simplifier les imports
pub use admin_handler::{create_admin, get_all_users};
pub use allergy_handler::*;
pub use image_handler::*;
pub use ingredient_categories_handler::*;
pub use ingredient_handler::{
    create_ingredient, delete_ingredient, get_all_ingredients, get_ingredient, update_ingredient,
};
pub use recipe_handler::*;
pub use stats_handler::*;
pub use user_handler::*;
pub use user_preferences_handler::*;
