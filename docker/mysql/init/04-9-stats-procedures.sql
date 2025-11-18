USE food_advisor_db;

DELIMITER $$

-- =====================================================
-- STATISTICS PROCEDURES (Admin Only)
-- =====================================================

-- Statistiques globales (utilisateurs, recettes, ingrédients, etc.)
DROP PROCEDURE IF EXISTS sp_get_global_stats$$
CREATE PROCEDURE sp_get_global_stats()
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

        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;
            CALL sp_log_error(
                'SQL_EXCEPTION',
                COALESCE(v_sql_error, 'Unknown error in sp_get_global_stats'),
                JSON_OBJECT(
                    'sql_state', v_sql_state,
                    'mysql_errno', v_mysql_errno,
                    'operation', 'GET_GLOBAL_STATS'
                ),
                'sp_get_global_stats',
                NULL
            );
        END;
        RESIGNAL;
    END;

    -- Statistiques globales
    SELECT
        (SELECT COUNT(*) FROM users) as total_users,
        (SELECT COUNT(*) FROM users WHERE role = 'Administrator') as total_admins,
        (SELECT COUNT(*) FROM recipes) as total_recipes,
        (SELECT COUNT(*) FROM recipes WHERE is_published = TRUE) as published_recipes,
        (SELECT COUNT(*) FROM recipes WHERE is_published = FALSE) as unpublished_recipes,
        (SELECT COUNT(*) FROM ingredients) as total_ingredients,
        (SELECT COUNT(*) FROM ingredient_categories) as total_categories,
        (SELECT COUNT(*) FROM allergies) as total_allergies,
        (SELECT COUNT(*) FROM completed_recipes) as total_recipe_completions,
        (SELECT COALESCE(AVG(rating), 0) FROM completed_recipes WHERE rating IS NOT NULL) as average_rating;
END$$


-- Top 10 des recettes les plus complétées
DROP PROCEDURE IF EXISTS sp_get_top_completed_recipes$$
CREATE PROCEDURE sp_get_top_completed_recipes(
    IN p_limit INT
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

        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;
            CALL sp_log_error(
                'SQL_EXCEPTION',
                COALESCE(v_sql_error, 'Unknown error in sp_get_top_completed_recipes'),
                JSON_OBJECT(
                    'sql_state', v_sql_state,
                    'mysql_errno', v_mysql_errno,
                    'operation', 'GET_TOP_COMPLETED_RECIPES'
                ),
                'sp_get_top_completed_recipes',
                NULL
            );
        END;
        RESIGNAL;
    END;

    SET p_limit = COALESCE(p_limit, 10);

    SELECT
        r.recipe_id,
        r.title,
        r.difficulty,
        COUNT(cr.completion_id) as completion_count,
        COALESCE(AVG(cr.rating), 0) as average_rating
    FROM recipes r
    INNER JOIN completed_recipes cr ON r.recipe_id = cr.recipe_id
    GROUP BY r.recipe_id, r.title, r.difficulty
    ORDER BY completion_count DESC, average_rating DESC
    LIMIT p_limit;
END$$


-- Top 10 des recettes les mieux notées
DROP PROCEDURE IF EXISTS sp_get_top_rated_recipes$$
CREATE PROCEDURE sp_get_top_rated_recipes(
    IN p_limit INT,
    IN p_min_ratings INT
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

        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;
            CALL sp_log_error(
                'SQL_EXCEPTION',
                COALESCE(v_sql_error, 'Unknown error in sp_get_top_rated_recipes'),
                JSON_OBJECT(
                    'sql_state', v_sql_state,
                    'mysql_errno', v_mysql_errno,
                    'operation', 'GET_TOP_RATED_RECIPES'
                ),
                'sp_get_top_rated_recipes',
                NULL
            );
        END;
        RESIGNAL;
    END;

    SET p_limit = COALESCE(p_limit, 10);
    SET p_min_ratings = COALESCE(p_min_ratings, 1);

    SELECT
        r.recipe_id,
        r.title,
        r.difficulty,
        COUNT(cr.rating) as rating_count,
        AVG(cr.rating) as average_rating
    FROM recipes r
    INNER JOIN completed_recipes cr ON r.recipe_id = cr.recipe_id
    WHERE cr.rating IS NOT NULL
    GROUP BY r.recipe_id, r.title, r.difficulty
    HAVING rating_count >= p_min_ratings
    ORDER BY average_rating DESC, rating_count DESC
    LIMIT p_limit;
END$$


-- Top 10 des ingrédients les plus utilisés dans les recettes
DROP PROCEDURE IF EXISTS sp_get_top_ingredients$$
CREATE PROCEDURE sp_get_top_ingredients(
    IN p_limit INT
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

        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;
            CALL sp_log_error(
                'SQL_EXCEPTION',
                COALESCE(v_sql_error, 'Unknown error in sp_get_top_ingredients'),
                JSON_OBJECT(
                    'sql_state', v_sql_state,
                    'mysql_errno', v_mysql_errno,
                    'operation', 'GET_TOP_INGREDIENTS'
                ),
                'sp_get_top_ingredients',
                NULL
            );
        END;
        RESIGNAL;
    END;

    SET p_limit = COALESCE(p_limit, 10);

    SELECT
        i.ingredient_id,
        i.name,
        i.measurement_unit,
        COUNT(ri.recipe_id) as recipe_count
    FROM ingredients i
    INNER JOIN recipe_ingredients ri ON i.ingredient_id = ri.ingredient_id
    GROUP BY i.ingredient_id, i.name, i.measurement_unit
    ORDER BY recipe_count DESC
    LIMIT p_limit;
END$$


-- Statistiques des recettes complétées par période
DROP PROCEDURE IF EXISTS sp_get_completion_stats_by_period$$
CREATE PROCEDURE sp_get_completion_stats_by_period(
    IN p_period VARCHAR(20)  -- 'day', 'week', 'month', 'year'
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

        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;
            CALL sp_log_error(
                'SQL_EXCEPTION',
                COALESCE(v_sql_error, 'Unknown error in sp_get_completion_stats_by_period'),
                JSON_OBJECT(
                    'sql_state', v_sql_state,
                    'mysql_errno', v_mysql_errno,
                    'operation', 'GET_COMPLETION_STATS_BY_PERIOD',
                    'period', p_period
                ),
                'sp_get_completion_stats_by_period',
                NULL
            );
        END;
        RESIGNAL;
    END;

    CASE p_period
        WHEN 'day' THEN
            SELECT
                CAST(period_date AS CHAR) as period,
                completion_count,
                average_rating
            FROM (
                SELECT
                    DATE(completion_date) as period_date,
                    COUNT(*) as completion_count,
                    COALESCE(AVG(rating), 0) as average_rating
                FROM completed_recipes
                GROUP BY DATE(completion_date)
            ) AS daily_stats
            ORDER BY period_date DESC
            LIMIT 30;
            
        WHEN 'week' THEN
            SELECT
                CAST(period_week AS CHAR) as period,
                completion_count,
                average_rating
            FROM (
                SELECT
                    YEARWEEK(completion_date, 1) as period_week,
                    COUNT(*) as completion_count,
                    COALESCE(AVG(rating), 0) as average_rating
                FROM completed_recipes
                GROUP BY YEARWEEK(completion_date, 1)
            ) AS weekly_stats
            ORDER BY period_week DESC
            LIMIT 12;
            
        WHEN 'month' THEN
            SELECT
                period_month as period,
                completion_count,
                average_rating
            FROM (
                SELECT
                    DATE_FORMAT(completion_date, '%Y-%m') as period_month,
                    COUNT(*) as completion_count,
                    COALESCE(AVG(rating), 0) as average_rating
                FROM completed_recipes
                GROUP BY DATE_FORMAT(completion_date, '%Y-%m')
            ) AS monthly_stats
            ORDER BY period_month DESC
            LIMIT 12;
            
        WHEN 'year' THEN
            SELECT
                CAST(period_year AS CHAR) as period,
                completion_count,
                average_rating
            FROM (
                SELECT
                    YEAR(completion_date) as period_year,
                    COUNT(*) as completion_count,
                    COALESCE(AVG(rating), 0) as average_rating
                FROM completed_recipes
                GROUP BY YEAR(completion_date)
            ) AS yearly_stats
            ORDER BY period_year DESC;
            
        ELSE
            -- Par défaut, grouper par jour
            SELECT
                CAST(period_date AS CHAR) as period,
                completion_count,
                average_rating
            FROM (
                SELECT
                    DATE(completion_date) as period_date,
                    COUNT(*) as completion_count,
                    COALESCE(AVG(rating), 0) as average_rating
                FROM completed_recipes
                GROUP BY DATE(completion_date)
            ) AS default_stats
            ORDER BY period_date DESC
            LIMIT 30;
    END CASE;
END$$

-- Statistiques des allergies des utilisateurs
DROP PROCEDURE IF EXISTS sp_get_allergy_stats$$
CREATE PROCEDURE sp_get_allergy_stats()
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

        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;
            CALL sp_log_error(
                'SQL_EXCEPTION',
                COALESCE(v_sql_error, 'Unknown error in sp_get_allergy_stats'),
                JSON_OBJECT(
                    'sql_state', v_sql_state,
                    'mysql_errno', v_mysql_errno,
                    'operation', 'GET_ALLERGY_STATS'
                ),
                'sp_get_allergy_stats',
                NULL
            );
        END;
        RESIGNAL;
    END;

    SELECT
        a.allergy_id,
        a.name,
        -- Compteurs par severity
        COUNT(CASE WHEN ua.severity = 'Mild' THEN ua.user_id END) as mild_count,
        COUNT(CASE WHEN ua.severity = 'Moderate' THEN ua.user_id END) as moderate_count,
        COUNT(CASE WHEN ua.severity = 'Severe' THEN ua.user_id END) as severe_count,
        COUNT(CASE WHEN ua.severity = 'Life-threatening' THEN ua.user_id END) as life_threatening_count,
        -- Total
        COUNT(ua.user_id) as total_user_count,
        ROUND((COUNT(ua.user_id) * 100.0) / (SELECT COUNT(*) FROM users), 2) as percentage
    FROM allergies a
    LEFT JOIN user_allergies ua ON a.allergy_id = ua.allergy_id
    GROUP BY a.allergy_id, a.name
    ORDER BY total_user_count DESC;
END$$


-- Statistiques des utilisateurs actifs (par nombre de recettes complétées)
DROP PROCEDURE IF EXISTS sp_get_active_users_stats$$
CREATE PROCEDURE sp_get_active_users_stats(
    IN p_limit INT
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

        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;
            CALL sp_log_error(
                'SQL_EXCEPTION',
                COALESCE(v_sql_error, 'Unknown error in sp_get_active_users_stats'),
                JSON_OBJECT(
                    'sql_state', v_sql_state,
                    'mysql_errno', v_mysql_errno,
                    'operation', 'GET_ACTIVE_USERS_STATS'
                ),
                'sp_get_active_users_stats',
                NULL
            );
        END;
        RESIGNAL;
    END;

    SET p_limit = COALESCE(p_limit, 10);

    SELECT
        u.user_id,
        u.first_name,
        u.last_name,
        COUNT(cr.completion_id) as completed_recipes_count,
        COALESCE(AVG(cr.rating), 0) as average_rating_given
    FROM users u
    INNER JOIN completed_recipes cr ON u.user_id = cr.user_id
    GROUP BY u.user_id, u.first_name, u.last_name
    ORDER BY completed_recipes_count DESC
    LIMIT p_limit;
END$$


-- Statistiques des catégories d'ingrédients les plus utilisées
DROP PROCEDURE IF EXISTS sp_get_category_usage_stats$$
CREATE PROCEDURE sp_get_category_usage_stats()
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

        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;
            CALL sp_log_error(
                'SQL_EXCEPTION',
                COALESCE(v_sql_error, 'Unknown error in sp_get_category_usage_stats'),
                JSON_OBJECT(
                    'sql_state', v_sql_state,
                    'mysql_errno', v_mysql_errno,
                    'operation', 'GET_CATEGORY_USAGE_STATS'
                ),
                'sp_get_category_usage_stats',
                NULL
            );
        END;
        RESIGNAL;
    END;

    SELECT
        ic.category_id,
        ic.name,
        COUNT(DISTINCT ica.ingredient_id) as ingredient_count,
        COUNT(DISTINCT ri.recipe_id) as recipe_count
    FROM ingredient_categories ic
    LEFT JOIN ingredient_category_assignments ica ON ic.category_id = ica.category_id
    LEFT JOIN recipe_ingredients ri ON ica.ingredient_id = ri.ingredient_id
    GROUP BY ic.category_id, ic.name
    ORDER BY recipe_count DESC, ingredient_count DESC;
END$$


DELIMITER ;
