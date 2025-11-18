USE food_advisor_db;

DELIMITER $$

-- =====================================================
-- GESTION DES ALLERGIES
-- =====================================================

-- Récupérer toutes les allergies
DROP PROCEDURE IF EXISTS sp_get_all_allergies$$
CREATE PROCEDURE sp_get_all_allergies(
    OUT p_error_message VARCHAR(500)
)
BEGIN
    DECLARE v_sql_error TEXT;
    DECLARE v_sql_state CHAR(5) DEFAULT '00000';
    DECLARE v_mysql_errno INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_sql_state = RETURNED_SQLSTATE,
            v_mysql_errno = MYSQL_ERRNO,
            v_sql_error = MESSAGE_TEXT;
        
        SET p_error_message = COALESCE(v_sql_error, 'Unknown SQL error occurred');
        
        CALL sp_log_error(
            'SQL_EXCEPTION',
            p_error_message,
            JSON_OBJECT(
                'sql_state', v_sql_state,
                'mysql_errno', v_mysql_errno,
                'operation', 'GET_ALL_ALLERGIES'
            ),
            'sp_get_all_allergies',
            NULL
        );
        
        RESIGNAL;
    END;
    
    SET p_error_message = NULL;
    
    SELECT 
        allergy_id,
        name,
        description,
        created_at,
        updated_at
    FROM allergies
    ORDER BY name;
END$$

-- Récupérer une allergie par ID avec ses ingrédients
DROP PROCEDURE IF EXISTS sp_get_allergy_by_id$$
CREATE PROCEDURE sp_get_allergy_by_id(
    IN p_allergy_id INT,
    OUT p_error_message VARCHAR(500)
)
BEGIN
    DECLARE v_sql_error TEXT;
    DECLARE v_sql_state CHAR(5) DEFAULT '00000';
    DECLARE v_mysql_errno INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_sql_state = RETURNED_SQLSTATE,
            v_mysql_errno = MYSQL_ERRNO,
            v_sql_error = MESSAGE_TEXT;
        
        SET p_error_message = COALESCE(v_sql_error, 'Unknown SQL error occurred');
        
        CALL sp_log_error(
            'SQL_EXCEPTION',
            p_error_message,
            JSON_OBJECT(
                'sql_state', v_sql_state,
                'mysql_errno', v_mysql_errno,
                'allergy_id', p_allergy_id,
                'operation', 'GET_ALLERGY_BY_ID'
            ),
            'sp_get_allergy_by_id',
            NULL
        );
        
        RESIGNAL;
    END;
    
    SET p_error_message = NULL;
    
    -- Récupérer l'allergie
    SELECT 
        allergy_id,
        name,
        description,
        created_at,
        updated_at
    FROM allergies
    WHERE allergy_id = p_allergy_id;
    
    -- Récupérer les ingrédients associés à cette allergie
    SELECT 
        i.ingredient_id,
        i.name as ingredient_name,
        i.carbohydrates,
        i.proteins,
        i.fats,
        i.fibers,
        i.calories,
        i.price,
        i.weight,
        i.measurement_unit
    FROM ingredients i
    INNER JOIN ingredient_allergies ia ON i.ingredient_id = ia.ingredient_id
    WHERE ia.allergy_id = p_allergy_id
    ORDER BY i.name;
END$$

-- Créer une allergie
DROP PROCEDURE IF EXISTS sp_create_allergy$$
CREATE PROCEDURE sp_create_allergy(
    IN p_name VARCHAR(100),
    IN p_description TEXT,
    IN p_created_by_user_id INT,
    OUT p_allergy_id INT,
    OUT p_error_message VARCHAR(500)
)
BEGIN
    DECLARE v_sql_error TEXT;
    DECLARE v_sql_state CHAR(5) DEFAULT '00000';
    DECLARE v_mysql_errno INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        
        GET DIAGNOSTICS CONDITION 1
            v_sql_state = RETURNED_SQLSTATE,
            v_mysql_errno = MYSQL_ERRNO,
            v_sql_error = MESSAGE_TEXT;
        
        SET p_error_message = COALESCE(v_sql_error, 'Unknown SQL error occurred');
        SET p_allergy_id = NULL;
        
        CALL sp_log_error(
            'SQL_EXCEPTION',
            p_error_message,
            JSON_OBJECT(
                'sql_state', v_sql_state,
                'mysql_errno', v_mysql_errno,
                'allergy_name', COALESCE(p_name, 'NULL'),
                'operation', 'CREATE_ALLERGY'
            ),
            'sp_create_allergy',
            p_created_by_user_id
        );
        
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Vérifier si l'allergie existe déjà
    IF EXISTS (SELECT 1 FROM allergies WHERE name = p_name) THEN
        SET p_error_message = 'Allergy with this name already exists';
        SET p_allergy_id = NULL;
        
        CALL sp_log_error(
            'DUPLICATE_ALLERGY',
            p_error_message,
            JSON_OBJECT('allergy_name', p_name, 'operation', 'CREATE_ALLERGY'),
            'sp_create_allergy',
            p_created_by_user_id
        );
        
        ROLLBACK;
    ELSE
        INSERT INTO allergies (name, description)
        VALUES (p_name, p_description);
        
        SET p_allergy_id = LAST_INSERT_ID();
        SET p_error_message = NULL;
        
        COMMIT;
    END IF;
END$$

-- Modifier une allergie
DROP PROCEDURE IF EXISTS sp_update_allergy$$
CREATE PROCEDURE sp_update_allergy(
    IN p_allergy_id INT,
    IN p_name VARCHAR(100),
    IN p_description TEXT,
    IN p_updated_by_user_id INT,
    OUT p_error_message VARCHAR(500)
)
BEGIN
    DECLARE v_sql_error TEXT;
    DECLARE v_sql_state CHAR(5) DEFAULT '00000';
    DECLARE v_mysql_errno INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        
        GET DIAGNOSTICS CONDITION 1
            v_sql_state = RETURNED_SQLSTATE,
            v_mysql_errno = MYSQL_ERRNO,
            v_sql_error = MESSAGE_TEXT;
        
        SET p_error_message = COALESCE(v_sql_error, 'Unknown SQL error occurred');
        
        CALL sp_log_error(
            'SQL_EXCEPTION',
            p_error_message,
            JSON_OBJECT(
                'sql_state', v_sql_state,
                'mysql_errno', v_mysql_errno,
                'allergy_id', p_allergy_id,
                'operation', 'UPDATE_ALLERGY'
            ),
            'sp_update_allergy',
            p_updated_by_user_id
        );
        
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Vérifier si l'allergie existe
    IF NOT EXISTS (SELECT 1 FROM allergies WHERE allergy_id = p_allergy_id) THEN
        SET p_error_message = 'Allergy not found';
        
        CALL sp_log_error(
            'ALLERGY_NOT_FOUND',
            p_error_message,
            JSON_OBJECT('allergy_id', p_allergy_id, 'operation', 'UPDATE_ALLERGY'),
            'sp_update_allergy',
            p_updated_by_user_id
        );
        
        ROLLBACK;
    -- Vérifier si le nouveau nom existe déjà (pour une autre allergie)
    ELSEIF EXISTS (SELECT 1 FROM allergies WHERE name = p_name AND allergy_id != p_allergy_id) THEN
        SET p_error_message = 'Allergy with this name already exists';
        
        CALL sp_log_error(
            'DUPLICATE_ALLERGY',
            p_error_message,
            JSON_OBJECT('allergy_name', p_name, 'operation', 'UPDATE_ALLERGY'),
            'sp_update_allergy',
            p_updated_by_user_id
        );
        
        ROLLBACK;
    ELSE
        UPDATE allergies SET
            name = p_name,
            description = p_description,
            updated_at = NOW()
        WHERE allergy_id = p_allergy_id;
        
        SET p_error_message = NULL;
        
        COMMIT;
    END IF;
END$$

-- Supprimer une allergie
DROP PROCEDURE IF EXISTS sp_delete_allergy$$
CREATE PROCEDURE sp_delete_allergy(
    IN p_allergy_id INT,
    IN p_deleted_by_user_id INT,
    OUT p_error_message VARCHAR(500)
)
BEGIN
    DECLARE v_sql_error TEXT;
    DECLARE v_sql_state CHAR(5) DEFAULT '00000';
    DECLARE v_mysql_errno INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        
        GET DIAGNOSTICS CONDITION 1
            v_sql_state = RETURNED_SQLSTATE,
            v_mysql_errno = MYSQL_ERRNO,
            v_sql_error = MESSAGE_TEXT;
        
        SET p_error_message = COALESCE(v_sql_error, 'Unknown SQL error occurred');
        
        CALL sp_log_error(
            'SQL_EXCEPTION',
            p_error_message,
            JSON_OBJECT(
                'sql_state', v_sql_state,
                'mysql_errno', v_mysql_errno,
                'allergy_id', p_allergy_id,
                'operation', 'DELETE_ALLERGY'
            ),
            'sp_delete_allergy',
            p_deleted_by_user_id
        );
        
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Vérifier si l'allergie existe
    IF NOT EXISTS (SELECT 1 FROM allergies WHERE allergy_id = p_allergy_id) THEN
        SET p_error_message = 'Allergy not found';
        
        CALL sp_log_error(
            'ALLERGY_NOT_FOUND',
            p_error_message,
            JSON_OBJECT('allergy_id', p_allergy_id, 'operation', 'DELETE_ALLERGY'),
            'sp_delete_allergy',
            p_deleted_by_user_id
        );
        
        ROLLBACK;
    ELSE
        -- Les associations seront supprimées automatiquement grâce à ON DELETE CASCADE
        DELETE FROM allergies WHERE allergy_id = p_allergy_id;
        
        SET p_error_message = NULL;
        
        COMMIT;
    END IF;
END$$

-- =====================================================
-- GESTION DES ALLERGIES D'INGRÉDIENTS
-- =====================================================

-- Ajouter un ingrédient à une allergie
DROP PROCEDURE IF EXISTS sp_add_ingredient_to_allergy$$
CREATE PROCEDURE sp_add_ingredient_to_allergy(
    IN p_allergy_id INT,
    IN p_ingredient_id INT,
    IN p_user_id INT,
    OUT p_error_message VARCHAR(500)
)
BEGIN
    DECLARE v_sql_error TEXT;
    DECLARE v_sql_state CHAR(5) DEFAULT '00000';
    DECLARE v_mysql_errno INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        
        GET DIAGNOSTICS CONDITION 1
            v_sql_state = RETURNED_SQLSTATE,
            v_mysql_errno = MYSQL_ERRNO,
            v_sql_error = MESSAGE_TEXT;
        
        SET p_error_message = COALESCE(v_sql_error, 'Unknown SQL error occurred');
        
        CALL sp_log_error(
            'SQL_EXCEPTION',
            p_error_message,
            JSON_OBJECT(
                'sql_state', v_sql_state,
                'mysql_errno', v_mysql_errno,
                'allergy_id', p_allergy_id,
                'ingredient_id', p_ingredient_id,
                'operation', 'ADD_INGREDIENT_TO_ALLERGY'
            ),
            'sp_add_ingredient_to_allergy',
            p_user_id
        );
        
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Vérifier si l'allergie existe
    IF NOT EXISTS (SELECT 1 FROM allergies WHERE allergy_id = p_allergy_id) THEN
        SET p_error_message = 'Allergy not found';
        
        CALL sp_log_error(
            'ALLERGY_NOT_FOUND',
            p_error_message,
            JSON_OBJECT('allergy_id', p_allergy_id, 'operation', 'ADD_INGREDIENT_TO_ALLERGY'),
            'sp_add_ingredient_to_allergy',
            p_user_id
        );
        
        ROLLBACK;
    -- Vérifier si l'ingrédient existe
    ELSEIF NOT EXISTS (SELECT 1 FROM ingredients WHERE ingredient_id = p_ingredient_id) THEN
        SET p_error_message = 'Ingredient not found';
        
        CALL sp_log_error(
            'INGREDIENT_NOT_FOUND',
            p_error_message,
            JSON_OBJECT('ingredient_id', p_ingredient_id, 'operation', 'ADD_INGREDIENT_TO_ALLERGY'),
            'sp_add_ingredient_to_allergy',
            p_user_id
        );
        
        ROLLBACK;
    -- Vérifier si l'association existe déjà
    ELSEIF EXISTS (
        SELECT 1 FROM ingredient_allergies 
        WHERE allergy_id = p_allergy_id AND ingredient_id = p_ingredient_id
    ) THEN
        SET p_error_message = 'Ingredient already associated with this allergy';
        
        CALL sp_log_error(
            'DUPLICATE_ASSOCIATION',
            p_error_message,
            JSON_OBJECT(
                'allergy_id', p_allergy_id,
                'ingredient_id', p_ingredient_id,
                'operation', 'ADD_INGREDIENT_TO_ALLERGY'
            ),
            'sp_add_ingredient_to_allergy',
            p_user_id
        );
        
        ROLLBACK;
    ELSE
        INSERT INTO ingredient_allergies (ingredient_id, allergy_id)
        VALUES (p_ingredient_id, p_allergy_id);
        
        SET p_error_message = NULL;
        
        COMMIT;
    END IF;
END$$

-- Supprimer un ingrédient d'une allergie
DROP PROCEDURE IF EXISTS sp_remove_ingredient_from_allergy$$
CREATE PROCEDURE sp_remove_ingredient_from_allergy(
    IN p_allergy_id INT,
    IN p_ingredient_id INT,
    IN p_user_id INT,
    OUT p_error_message VARCHAR(500)
)
BEGIN
    DECLARE v_sql_error TEXT;
    DECLARE v_sql_state CHAR(5) DEFAULT '00000';
    DECLARE v_mysql_errno INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        
        GET DIAGNOSTICS CONDITION 1
            v_sql_state = RETURNED_SQLSTATE,
            v_mysql_errno = MYSQL_ERRNO,
            v_sql_error = MESSAGE_TEXT;
        
        SET p_error_message = COALESCE(v_sql_error, 'Unknown SQL error occurred');
        
        CALL sp_log_error(
            'SQL_EXCEPTION',
            p_error_message,
            JSON_OBJECT(
                'sql_state', v_sql_state,
                'mysql_errno', v_mysql_errno,
                'allergy_id', p_allergy_id,
                'ingredient_id', p_ingredient_id,
                'operation', 'REMOVE_INGREDIENT_FROM_ALLERGY'
            ),
            'sp_remove_ingredient_from_allergy',
            p_user_id
        );
        
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Vérifier si l'association existe
    IF NOT EXISTS (
        SELECT 1 FROM ingredient_allergies 
        WHERE allergy_id = p_allergy_id AND ingredient_id = p_ingredient_id
    ) THEN
        SET p_error_message = 'Association not found';
        
        CALL sp_log_error(
            'ASSOCIATION_NOT_FOUND',
            p_error_message,
            JSON_OBJECT(
                'allergy_id', p_allergy_id,
                'ingredient_id', p_ingredient_id,
                'operation', 'REMOVE_INGREDIENT_FROM_ALLERGY'
            ),
            'sp_remove_ingredient_from_allergy',
            p_user_id
        );
        
        ROLLBACK;
    ELSE
        DELETE FROM ingredient_allergies 
        WHERE allergy_id = p_allergy_id AND ingredient_id = p_ingredient_id;
        
        SET p_error_message = NULL;
        
        COMMIT;
    END IF;
END$$

-- =====================================================
-- GESTION DES ALLERGIES UTILISATEUR
-- =====================================================

-- Ajouter une allergie à un utilisateur
DROP PROCEDURE IF EXISTS sp_add_user_allergy$$
CREATE PROCEDURE sp_add_user_allergy(
    IN p_user_id INT,
    IN p_allergy_id INT,
    IN p_severity VARCHAR(20),
    OUT p_error_message VARCHAR(500)
)
BEGIN
    DECLARE v_sql_error TEXT;
    DECLARE v_sql_state CHAR(5) DEFAULT '00000';
    DECLARE v_mysql_errno INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        
        GET DIAGNOSTICS CONDITION 1
            v_sql_state = RETURNED_SQLSTATE,
            v_mysql_errno = MYSQL_ERRNO,
            v_sql_error = MESSAGE_TEXT;
        
        SET p_error_message = COALESCE(v_sql_error, 'Unknown SQL error occurred');
        
        CALL sp_log_error(
            'SQL_EXCEPTION',
            p_error_message,
            JSON_OBJECT(
                'sql_state', v_sql_state,
                'mysql_errno', v_mysql_errno,
                'user_id', p_user_id,
                'allergy_id', p_allergy_id,
                'operation', 'ADD_USER_ALLERGY'
            ),
            'sp_add_user_allergy',
            p_user_id
        );
        
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Vérifier si l'allergie existe
    IF NOT EXISTS (SELECT 1 FROM allergies WHERE allergy_id = p_allergy_id) THEN
        SET p_error_message = 'Allergy not found';
        
        CALL sp_log_error(
            'ALLERGY_NOT_FOUND',
            p_error_message,
            JSON_OBJECT('allergy_id', p_allergy_id, 'operation', 'ADD_USER_ALLERGY'),
            'sp_add_user_allergy',
            p_user_id
        );
        
        ROLLBACK;
    ELSEIF p_severity NOT IN ('Mild', 'Moderate', 'Severe', 'Life-threatening') THEN
        SET p_error_message = 'Invalid severity. Must be Mild, Moderate, Severe or Life-threatening';
        
        CALL sp_log_error(
            'INVALID_SEVERITY',
            p_error_message,
            JSON_OBJECT('severity', p_severity, 'operation', 'ADD_USER_ALLERGY'),
            'sp_add_user_allergy',
            p_user_id
        );
        
        ROLLBACK;
    ELSE
        -- Insérer ou mettre à jour l'allergie utilisateur
        INSERT INTO user_allergies (user_id, allergy_id, severity)
        VALUES (p_user_id, p_allergy_id, p_severity)
        ON DUPLICATE KEY UPDATE severity = p_severity, updated_at = NOW();
        
        SET p_error_message = NULL;
        
        COMMIT;
    END IF;
END$$

-- Supprimer une allergie d'un utilisateur
DROP PROCEDURE IF EXISTS sp_remove_user_allergy$$
CREATE PROCEDURE sp_remove_user_allergy(
    IN p_user_id INT,
    IN p_allergy_id INT,
    OUT p_error_message VARCHAR(500)
)
BEGIN
    DECLARE v_sql_error TEXT;
    DECLARE v_sql_state CHAR(5) DEFAULT '00000';
    DECLARE v_mysql_errno INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        
        GET DIAGNOSTICS CONDITION 1
            v_sql_state = RETURNED_SQLSTATE,
            v_mysql_errno = MYSQL_ERRNO,
            v_sql_error = MESSAGE_TEXT;
        
        SET p_error_message = COALESCE(v_sql_error, 'Unknown SQL error occurred');
        
        CALL sp_log_error(
            'SQL_EXCEPTION',
            p_error_message,
            JSON_OBJECT(
                'sql_state', v_sql_state,
                'mysql_errno', v_mysql_errno,
                'user_id', p_user_id,
                'allergy_id', p_allergy_id,
                'operation', 'REMOVE_USER_ALLERGY'
            ),
            'sp_remove_user_allergy',
            p_user_id
        );
        
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    DELETE FROM user_allergies 
    WHERE user_id = p_user_id AND allergy_id = p_allergy_id;
    
    SET p_error_message = NULL;
    
    COMMIT;
END$$

-- Récupérer toutes les allergies d'un utilisateur
DROP PROCEDURE IF EXISTS sp_get_user_allergies$$
CREATE PROCEDURE sp_get_user_allergies(
    IN p_user_id INT,
    OUT p_error_message VARCHAR(500)
)
BEGIN
    DECLARE v_sql_error TEXT;
    DECLARE v_sql_state CHAR(5) DEFAULT '00000';
    DECLARE v_mysql_errno INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_sql_state = RETURNED_SQLSTATE,
            v_mysql_errno = MYSQL_ERRNO,
            v_sql_error = MESSAGE_TEXT;
        
        SET p_error_message = COALESCE(v_sql_error, 'Unknown SQL error occurred');
        
        CALL sp_log_error(
            'SQL_EXCEPTION',
            p_error_message,
            JSON_OBJECT(
                'sql_state', v_sql_state,
                'mysql_errno', v_mysql_errno,
                'user_id', p_user_id,
                'operation', 'GET_USER_ALLERGIES'
            ),
            'sp_get_user_allergies',
            p_user_id
        );
        
        RESIGNAL;
    END;
    
    SET p_error_message = NULL;
    
    SELECT 
        ua.user_id,
        ua.allergy_id,
        a.name as allergy_name,
        a.description as allergy_description,
        ua.severity,
        ua.created_at,
        ua.updated_at
    FROM user_allergies ua
    INNER JOIN allergies a ON ua.allergy_id = a.allergy_id
    WHERE ua.user_id = p_user_id
    ORDER BY a.name;
END$$

DELIMITER ;