use crate::{
    models::{Allergy, AllergyWithIngredients, Ingredient, UserAllergy},
    repositories::IngredientRepository,
};
use chrono::Utc;
use sqlx::{Error, MySqlPool, Row, mysql::MySqlRow};

pub struct AllergyRepository {
    pool: MySqlPool,
}

impl AllergyRepository {
    pub fn new(pool: MySqlPool) -> Self {
        Self { pool }
    }

    fn get_allergy(row: &MySqlRow) -> Allergy {
        // Convertir TIMESTAMP en NaiveDateTime
        let created_at: chrono::DateTime<Utc> = row.get(3);
        let updated_at: chrono::DateTime<Utc> = row.get(4);

        Allergy {
            allergy_id: row.get(0),
            name: row.get(1),
            description: row.get(2),
            created_at: created_at.naive_utc(),
            updated_at: updated_at.naive_utc(),
        }
    }

    fn get_user_allergy(row: &MySqlRow) -> UserAllergy {
        // Convertir TIMESTAMP en NaiveDateTime
        let created_at: chrono::DateTime<Utc> = row.get(5);
        let updated_at: chrono::DateTime<Utc> = row.get(6);

        UserAllergy {
            user_id: row.get(0),
            allergy_id: row.get(1),
            name: row.get(2),
            description: row.get(3),
            severity: row.get(4),
            created_at: created_at.naive_utc(),
            updated_at: updated_at.naive_utc(),
        }
    }

    // =====================================================
    // GESTION DES ALLERGIES
    // =====================================================

    pub async fn get_all_allergies(&self) -> Result<Vec<Allergy>, Error> {
        let allergies = sqlx::query("CALL sp_get_all_allergies(@p_error_message)")
            .map(|row: MySqlRow| Self::get_allergy(&row))
            .fetch_all(&self.pool)
            .await?;

        Ok(allergies)
    }

    pub async fn find_allergy_by_id(
        &self,
        allergy_id: i32,
    ) -> Result<Option<AllergyWithIngredients>, Error> {
        let mut results = sqlx::query("CALL sp_get_allergy_by_id(?, @p_error_message)")
            .bind(allergy_id)
            .fetch_all(&self.pool)
            .await?;

        if results.is_empty() {
            return Ok(None);
        }

        let allergy = Self::get_allergy(&results[0]);
        let ingredients: Vec<Ingredient> = results
            .iter()
            .skip(1)
            .map(|row| IngredientRepository::get_ingredient(row))
            .collect();

        Ok(Some(AllergyWithIngredients {
            allergy,
            ingredients,
        }))
    }

    pub async fn create_allergy(
        &self,
        name: &str,
        description: Option<&str>,
        created_by_user_id: i32,
    ) -> Result<i32, Error> {
        let mut conn = self.pool.acquire().await?;

        sqlx::query("CALL sp_create_allergy(?, ?, ?, @p_allergy_id, @p_error_message)")
            .bind(name)
            .bind(description)
            .bind(created_by_user_id)
            .execute(&mut *conn)
            .await?;

        let result: (Option<i32>, Option<String>) =
            sqlx::query("SELECT @p_allergy_id, @p_error_message")
                .map(|row: MySqlRow| (row.get(0), row.get(1)))
                .fetch_one(&mut *conn)
                .await?;

        match result {
            (Some(allergy_id), None) => Ok(allergy_id),
            (None, Some(error_msg)) => Err(Error::Protocol(error_msg)),
            (Some(_), Some(error_msg)) => Err(Error::Protocol(error_msg)),
            (None, None) => Err(Error::Protocol(
                "Unknown error during allergy creation".to_string(),
            )),
        }
    }

    pub async fn update_allergy(
        &self,
        allergy_id: i32,
        name: &str,
        description: Option<&str>,
        updated_by_user_id: i32,
    ) -> Result<(), Error> {
        let mut conn = self.pool.acquire().await?;

        sqlx::query("CALL sp_update_allergy(?, ?, ?, ?, @p_error_message)")
            .bind(allergy_id)
            .bind(name)
            .bind(description)
            .bind(updated_by_user_id)
            .execute(&mut *conn)
            .await?;

        let error_message: Option<String> = sqlx::query("SELECT @p_error_message")
            .map(|row: MySqlRow| row.get(0))
            .fetch_one(&mut *conn)
            .await?;

        match error_message {
            None => Ok(()),
            Some(error_msg) => Err(Error::Protocol(error_msg)),
        }
    }

    pub async fn delete_allergy(
        &self,
        allergy_id: i32,
        deleted_by_user_id: i32,
    ) -> Result<(), Error> {
        let mut conn = self.pool.acquire().await?;

        sqlx::query("CALL sp_delete_allergy(?, ?, @p_error_message)")
            .bind(allergy_id)
            .bind(deleted_by_user_id)
            .execute(&mut *conn)
            .await?;

        let error_message: Option<String> = sqlx::query("SELECT @p_error_message")
            .map(|row: MySqlRow| row.get(0))
            .fetch_one(&mut *conn)
            .await?;

        match error_message {
            None => Ok(()),
            Some(error_msg) => Err(Error::Protocol(error_msg)),
        }
    }

    // =====================================================
    // GESTION DES ASSOCIATIONS INGRÉDIENT-ALLERGIE
    // =====================================================

    pub async fn add_ingredient_to_allergy(
        &self,
        allergy_id: i32,
        ingredient_id: u32,
        user_id: i32,
    ) -> Result<(), Error> {
        let mut conn = self.pool.acquire().await?;

        sqlx::query("CALL sp_add_ingredient_to_allergy(?, ?, ?, @p_error_message)")
            .bind(allergy_id)
            .bind(ingredient_id)
            .bind(user_id)
            .execute(&mut *conn)
            .await?;

        let error_message: Option<String> = sqlx::query("SELECT @p_error_message")
            .map(|row: MySqlRow| row.get(0))
            .fetch_one(&mut *conn)
            .await?;

        match error_message {
            None => Ok(()),
            Some(error_msg) => Err(Error::Protocol(error_msg)),
        }
    }

    pub async fn remove_ingredient_from_allergy(
        &self,
        allergy_id: i32,
        ingredient_id: i32,
        user_id: i32,
    ) -> Result<(), Error> {
        let mut conn = self.pool.acquire().await?;

        sqlx::query("CALL sp_remove_ingredient_from_allergy(?, ?, ?, @p_error_message)")
            .bind(allergy_id)
            .bind(ingredient_id)
            .bind(user_id)
            .execute(&mut *conn)
            .await?;

        let error_message: Option<String> = sqlx::query("SELECT @p_error_message")
            .map(|row: MySqlRow| row.get(0))
            .fetch_one(&mut *conn)
            .await?;

        match error_message {
            None => Ok(()),
            Some(error_msg) => Err(Error::Protocol(error_msg)),
        }
    }

    // =====================================================
    // GESTION DES ALLERGIES UTILISATEUR
    // =====================================================

    pub async fn add_user_allergy(
        &self,
        user_id: i32,
        allergy_id: i32,
        severity: &str,
    ) -> Result<(), Error> {
        let mut conn = self.pool.acquire().await?;

        sqlx::query("CALL sp_add_user_allergy(?, ?, ?, @p_error_message)")
            .bind(user_id)
            .bind(allergy_id)
            .bind(severity)
            .execute(&mut *conn)
            .await?;

        let error_message: Option<String> = sqlx::query("SELECT @p_error_message")
            .map(|row: MySqlRow| row.get(0))
            .fetch_one(&mut *conn)
            .await?;

        match error_message {
            None => Ok(()),
            Some(error_msg) => Err(Error::Protocol(error_msg)),
        }
    }

    pub async fn remove_user_allergy(&self, user_id: i32, allergy_id: i32) -> Result<(), Error> {
        let mut conn = self.pool.acquire().await?;

        sqlx::query("CALL sp_remove_user_allergy(?, ?, @p_error_message)")
            .bind(user_id)
            .bind(allergy_id)
            .execute(&mut *conn)
            .await?;

        let error_message: Option<String> = sqlx::query("SELECT @p_error_message")
            .map(|row: MySqlRow| row.get(0))
            .fetch_one(&mut *conn)
            .await?;

        match error_message {
            None => Ok(()),
            Some(error_msg) => Err(Error::Protocol(error_msg)),
        }
    }

    pub async fn get_user_allergies(&self, user_id: i32) -> Result<Vec<UserAllergy>, Error> {
        let allergies = sqlx::query("CALL sp_get_user_allergies(?, @p_error_message)")
            .bind(user_id)
            .map(|row: MySqlRow| Self::get_user_allergy(&row))
            .fetch_all(&self.pool)
            .await?;

        Ok(allergies)
    }
}
