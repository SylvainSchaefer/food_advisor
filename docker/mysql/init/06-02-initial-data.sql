USE food_advisor_db;

SET FOREIGN_KEY_CHECKS = 0;

-- =====================================================
-- ADDITIONAL USERS DATA
-- =====================================================

INSERT INTO users (user_id, first_name, last_name, gender, password_hash, email, role, country, city, is_active, birth_date) VALUES
(11, 'Yuki', 'Tanaka', 'Female', '', 'yuki.tanaka@email.com', 'Regular', 'Japan', 'Tokyo', TRUE, '1995-01-12'),
(12, 'Mohammed', 'Al-Rashid', 'Male', '', 'mohammed.rashid@email.com', 'Regular', 'UAE', 'Dubai', TRUE, '1984-09-05'),
(13, 'Olivia', 'Anderson', 'Female', '', 'olivia.anderson@email.com', 'Administrator', 'Australia', 'Sydney', TRUE, '1990-03-28'),
(14, 'Diego', 'Rodriguez', 'Male', '', 'diego.rodriguez@email.com', 'Regular', 'Mexico', 'Mexico City', TRUE, '1992-11-17'),
(15, 'Fatima', 'Hassan', 'Female', '', 'fatima.hassan@email.com', 'Regular', 'Morocco', 'Casablanca', TRUE, '1988-07-03'),
(16, 'Lars', 'Eriksson', 'Male', '', 'lars.eriksson@email.com', 'Regular', 'Sweden', 'Stockholm', TRUE, '1991-05-22'),
(17, 'Priya', 'Sharma', 'Female', '', 'priya.sharma@email.com', 'Regular', 'India', 'Mumbai', TRUE, '1993-12-08'),
(18, 'Michael', 'Chen', 'Male', '', 'michael.chen@email.com', 'Regular', 'China', 'Shanghai', TRUE, '1987-04-15'),
(19, 'Isabella', 'Costa', 'Female', '', 'isabella.costa@email.com', 'Regular', 'Portugal', 'Lisbon', TRUE, '1994-08-30'),
(20, 'Alexander', 'Petrov', 'Male', '', 'alexander.petrov@email.com', 'Regular', 'Russia', 'Moscow', TRUE, '1989-10-11');

-- =====================================================
-- ADDITIONAL ALLERGIES DATA
-- =====================================================

INSERT INTO allergies (allergy_id, name, description) VALUES
(11, 'Sulfites', 'Sensitivity to sulfites found in dried fruits and wine'),
(12, 'Celery', 'Allergy to celery and celeriac'),
(13, 'Lupin', 'Allergy to lupin flour and seeds'),
(14, 'Molluscs', 'Allergy to squid, octopus, snails'),
(15, 'Corn', 'Allergy to corn and corn-derived products');

-- =====================================================
-- ADDITIONAL USER ALLERGIES DATA
-- =====================================================

INSERT INTO user_allergies (user_id, allergy_id, severity) VALUES
(11, 7, 'Moderate'),
(12, 1, 'Severe'),
(13, 8, 'Life-threatening'),
(14, 15, 'Mild'),
(15, 5, 'Moderate'),
(16, 3, 'Mild'),
(17, 2, 'Moderate'),
(18, 6, 'Mild'),
(19, 4, 'Severe'),
(20, 1, 'Life-threatening');

-- =====================================================
-- ADDITIONAL INGREDIENTS DATA
-- =====================================================

INSERT INTO ingredients (ingredient_id, name, carbohydrates, proteins, fats, fibers, calories, price, weight, measurement_unit) VALUES
-- More Vegetables
(66, 'Cucumber', 3.63, 0.65, 0.11, 0.50, 15.00, 2.00, 100, 'grams'),
(67, 'Lettuce', 2.87, 1.36, 0.15, 1.30, 15.00, 2.20, 100, 'grams'),
(68, 'Eggplant', 5.88, 0.98, 0.18, 3.00, 25.00, 2.80, 100, 'grams'),
(69, 'Cauliflower', 4.97, 1.92, 0.28, 2.00, 25.00, 3.00, 100, 'grams'),
(70, 'Celery', 2.97, 0.69, 0.17, 1.60, 14.00, 2.50, 100, 'grams'),
(71, 'Asparagus', 3.88, 2.20, 0.12, 2.10, 20.00, 5.00, 100, 'grams'),
(72, 'Green Beans', 6.97, 1.83, 0.22, 2.70, 31.00, 3.50, 100, 'grams'),
(73, 'Peas', 14.45, 5.42, 0.40, 5.70, 81.00, 3.00, 100, 'grams'),
(74, 'Corn', 18.70, 3.27, 1.35, 2.00, 86.00, 2.50, 100, 'grams'),
(75, 'Sweet Potato', 20.12, 1.57, 0.05, 3.00, 86.00, 2.00, 100, 'grams'),
(76, 'Beets', 9.56, 1.61, 0.17, 2.80, 43.00, 2.30, 100, 'grams'),
(77, 'Radish', 3.40, 0.68, 0.10, 1.60, 16.00, 2.80, 100, 'grams'),
(78, 'Cabbage', 5.80, 1.28, 0.10, 2.50, 25.00, 1.50, 100, 'grams'),
(79, 'Kale', 8.75, 4.28, 0.93, 3.60, 49.00, 3.50, 100, 'grams'),
(80, 'Leek', 14.15, 1.50, 0.30, 1.80, 61.00, 3.00, 100, 'grams'),

-- More Fruits
(81, 'Mango', 14.98, 0.82, 0.38, 1.60, 60.00, 3.50, 100, 'grams'),
(82, 'Pineapple', 13.12, 0.54, 0.12, 1.40, 50.00, 3.00, 100, 'grams'),
(83, 'Watermelon', 7.55, 0.61, 0.15, 0.40, 30.00, 1.50, 100, 'grams'),
(84, 'Grapes', 18.10, 0.72, 0.16, 0.90, 69.00, 4.00, 100, 'grams'),
(85, 'Pear', 15.23, 0.36, 0.14, 3.10, 57.00, 2.50, 100, 'grams'),
(86, 'Peach', 9.54, 0.91, 0.25, 1.50, 39.00, 3.20, 100, 'grams'),
(87, 'Cherries', 16.01, 1.06, 0.20, 2.10, 63.00, 6.00, 100, 'grams'),
(88, 'Blueberries', 14.49, 0.74, 0.33, 2.40, 57.00, 5.50, 100, 'grams'),
(89, 'Raspberries', 11.94, 1.20, 0.65, 6.50, 52.00, 6.00, 100, 'grams'),
(90, 'Kiwi', 14.66, 1.14, 0.52, 3.00, 61.00, 3.80, 100, 'grams'),
(91, 'Avocado', 8.53, 2.00, 14.66, 6.70, 160.00, 4.50, 100, 'grams'),
(92, 'Coconut', 15.23, 3.33, 33.49, 9.00, 354.00, 5.00, 100, 'grams'),

-- More Meat & Poultry
(93, 'Lamb Chops', 0.00, 25.60, 18.10, 0.00, 282.00, 15.00, 100, 'grams'),
(94, 'Duck Breast', 0.00, 23.48, 4.25, 0.00, 132.00, 14.00, 100, 'grams'),
(95, 'Beef Steak', 0.00, 25.93, 11.84, 0.00, 217.00, 18.00, 100, 'grams'),
(96, 'Veal', 0.00, 24.40, 2.84, 0.00, 128.00, 16.00, 100, 'grams'),
(97, 'Chicken Thighs', 0.00, 24.82, 6.90, 0.00, 165.00, 6.50, 100, 'grams'),
(98, 'Chicken Wings', 0.00, 30.50, 11.40, 0.00, 222.00, 7.00, 100, 'grams'),
(99, 'Ground Turkey', 0.00, 27.37, 1.97, 0.00, 130.00, 8.50, 100, 'grams'),
(100, 'Sausage', 3.05, 13.00, 29.30, 0.00, 325.00, 9.00, 100, 'grams'),

-- More Fish & Seafood
(101, 'Mackerel', 0.00, 18.60, 13.89, 0.00, 205.00, 10.00, 100, 'grams'),
(102, 'Sardines', 0.00, 24.62, 11.45, 0.00, 208.00, 8.00, 100, 'grams'),
(103, 'Trout', 0.00, 19.94, 2.85, 0.00, 119.00, 13.00, 100, 'grams'),
(104, 'Halibut', 0.00, 20.81, 2.29, 0.00, 111.00, 20.00, 100, 'grams'),
(105, 'Sea Bass', 0.00, 18.43, 2.00, 0.00, 97.00, 17.00, 100, 'grams'),
(106, 'Lobster', 0.00, 19.00, 0.90, 0.00, 89.00, 35.00, 100, 'grams'),
(107, 'Crab', 0.00, 18.06, 1.08, 0.00, 87.00, 25.00, 100, 'grams'),
(108, 'Mussels', 3.69, 11.90, 2.24, 0.00, 86.00, 8.00, 100, 'grams'),
(109, 'Oysters', 4.95, 9.45, 2.30, 0.00, 81.00, 22.00, 100, 'grams'),
(110, 'Scallops', 3.18, 20.54, 0.76, 0.00, 111.00, 28.00, 100, 'grams'),
(111, 'Squid', 3.08, 15.58, 1.38, 0.00, 92.00, 12.00, 100, 'grams'),
(112, 'Anchovies', 0.00, 20.35, 4.84, 0.00, 131.00, 9.00, 100, 'grams'),

-- More Dairy & Alternatives
(113, 'Feta Cheese', 4.09, 14.21, 21.28, 0.00, 264.00, 11.00, 100, 'grams'),
(114, 'Parmesan', 3.22, 35.75, 25.83, 0.00, 392.00, 18.00, 100, 'grams'),
(115, 'Goat Cheese', 2.64, 21.58, 21.08, 0.00, 268.00, 13.00, 100, 'grams'),
(116, 'Blue Cheese', 2.34, 21.40, 28.74, 0.00, 353.00, 14.00, 100, 'grams'),
(117, 'Ricotta', 3.04, 11.26, 13.00, 0.00, 174.00, 9.00, 100, 'grams'),
(118, 'Sour Cream', 4.63, 2.44, 19.35, 0.00, 198.00, 5.50, 100, 'grams'),
(119, 'Cottage Cheese', 3.38, 11.12, 4.30, 0.00, 98.00, 4.50, 100, 'grams'),
(120, 'Almond Milk', 1.30, 0.40, 1.10, 0.30, 17.00, 4.00, 1000, 'milliliters'),
(121, 'Coconut Milk', 5.54, 2.29, 23.84, 2.20, 230.00, 5.00, 100, 'milliliters'),
(122, 'Heavy Cream', 2.79, 2.05, 37.00, 0.00, 340.00, 7.00, 100, 'milliliters'),

-- More Grains & Cereals
(123, 'Couscous', 77.43, 3.79, 0.16, 1.40, 376.00, 3.50, 100, 'grams'),
(124, 'Bulgur', 75.87, 12.29, 1.33, 12.50, 342.00, 4.00, 100, 'grams'),
(125, 'Barley', 73.48, 12.48, 2.30, 17.30, 354.00, 3.00, 100, 'grams'),
(126, 'Wild Rice', 74.90, 14.73, 1.08, 6.20, 357.00, 8.00, 100, 'grams'),
(127, 'Millet', 72.85, 11.02, 4.22, 8.50, 378.00, 5.00, 100, 'grams'),
(128, 'Cornmeal', 76.89, 8.12, 3.59, 7.30, 362.00, 2.50, 100, 'grams'),
(129, 'Buckwheat', 71.50, 13.25, 3.40, 10.00, 343.00, 5.50, 100, 'grams'),
(130, 'Rye Flour', 75.86, 10.34, 1.63, 15.10, 338.00, 4.00, 100, 'grams'),

-- More Pasta & Noodles
(131, 'Lasagna Sheets', 75.00, 13.00, 1.50, 3.00, 371.00, 3.50, 100, 'grams'),
(132, 'Fettuccine', 74.67, 13.04, 1.51, 3.20, 371.00, 3.00, 100, 'grams'),
(133, 'Penne', 74.67, 13.04, 1.51, 3.20, 371.00, 2.80, 100, 'grams'),
(134, 'Ravioli', 30.00, 12.00, 5.00, 2.00, 220.00, 5.00, 100, 'grams'),
(135, 'Tortellini', 31.00, 13.00, 7.00, 2.50, 250.00, 5.50, 100, 'grams'),
(136, 'Rice Noodles', 83.20, 1.60, 0.20, 1.80, 364.00, 4.00, 100, 'grams'),
(137, 'Soba Noodles', 74.62, 14.16, 0.71, 4.00, 336.00, 6.00, 100, 'grams'),
(138, 'Udon Noodles', 21.00, 2.60, 0.50, 1.20, 99.00, 4.50, 100, 'grams'),
(139, 'Egg Noodles', 74.19, 14.16, 2.07, 3.30, 384.00, 3.50, 100, 'grams'),

-- More Legumes & Beans
(140, 'Kidney Beans', 60.01, 23.58, 0.83, 15.20, 333.00, 2.80, 100, 'grams'),
(141, 'Pinto Beans', 62.55, 21.42, 1.23, 15.50, 347.00, 2.50, 100, 'grams'),
(142, 'Navy Beans', 60.75, 22.33, 1.50, 15.30, 337.00, 3.00, 100, 'grams'),
(143, 'Lima Beans', 63.38, 21.46, 0.69, 19.00, 338.00, 3.50, 100, 'grams'),
(144, 'Green Lentils', 60.08, 25.80, 1.06, 10.70, 352.00, 3.20, 100, 'grams'),
(145, 'Red Lentils', 63.35, 23.91, 1.06, 10.80, 358.00, 3.80, 100, 'grams'),
(146, 'Split Peas', 60.40, 24.55, 1.16, 25.50, 341.00, 2.50, 100, 'grams'),
(147, 'Edamame', 8.91, 11.91, 5.20, 5.20, 122.00, 4.50, 100, 'grams'),
(148, 'White Beans', 60.27, 21.11, 0.85, 15.70, 333.00, 2.80, 100, 'grams'),

-- More Nuts & Seeds
(149, 'Cashews', 30.19, 18.22, 43.85, 3.30, 553.00, 16.00, 100, 'grams'),
(150, 'Pistachios', 27.17, 20.16, 45.32, 10.60, 560.00, 20.00, 100, 'grams'),
(151, 'Pecans', 13.86, 9.17, 71.97, 9.60, 691.00, 22.00, 100, 'grams'),
(152, 'Hazelnuts', 16.70, 14.95, 60.75, 9.70, 628.00, 17.00, 100, 'grams'),
(153, 'Macadamia', 13.82, 7.91, 75.77, 8.60, 718.00, 25.00, 100, 'grams'),
(154, 'Brazil Nuts', 12.27, 14.32, 66.43, 7.50, 656.00, 20.00, 100, 'grams'),
(155, 'Pine Nuts', 13.08, 13.69, 68.37, 3.70, 673.00, 30.00, 100, 'grams'),
(156, 'Sunflower Seeds', 20.00, 20.78, 51.46, 8.60, 584.00, 8.00, 100, 'grams'),
(157, 'Pumpkin Seeds', 10.71, 30.23, 49.05, 6.00, 559.00, 10.00, 100, 'grams'),
(158, 'Chia Seeds', 42.12, 16.54, 30.74, 34.40, 486.00, 12.00, 100, 'grams'),
(159, 'Flax Seeds', 28.88, 18.29, 42.16, 27.30, 534.00, 8.00, 100, 'grams'),
(160, 'Sesame Seeds', 23.45, 17.73, 49.67, 11.80, 573.00, 9.00, 100, 'grams'),

-- More Herbs & Spices
(161, 'Parsley', 6.33, 2.97, 0.79, 3.30, 36.00, 4.00, 100, 'grams'),
(162, 'Cilantro', 3.67, 2.13, 0.52, 2.80, 23.00, 3.50, 100, 'grams'),
(163, 'Dill', 7.02, 3.46, 1.12, 2.10, 43.00, 5.00, 100, 'grams'),
(164, 'Mint', 14.89, 3.75, 0.94, 8.00, 70.00, 4.50, 100, 'grams'),
(165, 'Sage', 60.73, 10.63, 12.75, 40.30, 315.00, 7.00, 100, 'grams'),
(166, 'Turmeric', 67.14, 9.68, 3.25, 22.70, 312.00, 8.00, 100, 'grams'),
(167, 'Cumin', 44.24, 17.81, 22.27, 10.50, 375.00, 7.50, 100, 'grams'),
(168, 'Coriander', 54.99, 12.37, 17.77, 41.90, 298.00, 6.00, 100, 'grams'),
(169, 'Ginger', 17.77, 1.82, 0.75, 2.00, 80.00, 6.00, 100, 'grams'),
(170, 'Chili Powder', 49.70, 13.46, 14.28, 34.80, 282.00, 7.00, 100, 'grams'),
(171, 'Cayenne Pepper', 56.63, 12.01, 17.27, 27.20, 318.00, 8.50, 100, 'grams'),
(172, 'Nutmeg', 49.29, 5.84, 36.31, 20.80, 525.00, 15.00, 100, 'grams'),
(173, 'Cardamom', 68.47, 10.76, 6.70, 28.00, 311.00, 25.00, 100, 'grams'),
(174, 'Cloves', 65.53, 5.97, 13.00, 33.90, 274.00, 18.00, 100, 'grams'),
(175, 'Bay Leaves', 74.97, 7.61, 8.36, 26.30, 313.00, 6.00, 100, 'grams'),
(176, 'Chives', 4.35, 3.27, 0.73, 2.50, 30.00, 5.00, 100, 'grams'),
(177, 'Tarragon', 50.22, 22.77, 7.24, 7.40, 295.00, 9.00, 100, 'grams'),

-- More Condiments & Sauces
(178, 'Worcestershire Sauce', 18.00, 0.00, 0.00, 0.00, 78.00, 5.00, 100, 'milliliters'),
(179, 'Hoisin Sauce', 35.00, 2.00, 1.00, 1.00, 220.00, 6.00, 100, 'grams'),
(180, 'Fish Sauce', 6.00, 6.00, 0.00, 0.00, 35.00, 5.50, 100, 'milliliters'),
(181, 'Oyster Sauce', 18.00, 1.40, 0.20, 0.00, 51.00, 5.00, 100, 'grams'),
(182, 'Tahini', 21.19, 17.00, 53.76, 9.30, 595.00, 10.00, 100, 'grams'),
(183, 'Sriracha', 17.00, 1.80, 1.00, 2.00, 93.00, 4.50, 100, 'milliliters'),
(184, 'Mayonnaise', 0.60, 1.00, 75.00, 0.00, 680.00, 4.00, 100, 'grams'),
(185, 'BBQ Sauce', 40.77, 0.98, 0.48, 0.90, 172.00, 4.50, 100, 'grams'),
(186, 'Hot Sauce', 1.00, 0.90, 0.60, 0.50, 12.00, 4.00, 100, 'milliliters'),
(187, 'Tomato Paste', 18.91, 4.32, 0.47, 4.10, 82.00, 2.50, 100, 'grams'),
(188, 'Pesto', 5.00, 5.00, 50.00, 2.00, 420.00, 8.00, 100, 'grams'),
(189, 'Salsa', 7.00, 1.00, 0.20, 1.50, 36.00, 3.50, 100, 'grams'),
(190, 'Teriyaki Sauce', 15.66, 5.93, 0.00, 0.10, 89.00, 5.00, 100, 'milliliters'),

-- More Sweeteners & Baking
(191, 'Brown Sugar', 97.33, 0.12, 0.00, 0.00, 380.00, 2.50, 100, 'grams'),
(192, 'Powdered Sugar', 99.77, 0.00, 0.00, 0.00, 389.00, 3.00, 100, 'grams'),
(193, 'Molasses', 74.73, 0.00, 0.10, 0.00, 290.00, 6.00, 100, 'milliliters'),
(194, 'Agave Nectar', 76.37, 0.09, 0.45, 0.20, 310.00, 10.00, 100, 'milliliters'),
(195, 'Cocoa Powder', 57.90, 19.60, 13.70, 33.20, 228.00, 8.00, 100, 'grams'),
(196, 'Dark Chocolate', 45.90, 7.79, 42.63, 10.90, 598.00, 12.00, 100, 'grams'),
(197, 'Milk Chocolate', 59.40, 7.65, 30.70, 3.40, 535.00, 10.00, 100, 'grams'),
(198, 'White Chocolate', 59.24, 5.87, 32.09, 0.20, 539.00, 11.00, 100, 'grams'),
(199, 'Yeast', 41.22, 40.44, 7.61, 26.90, 325.00, 5.00, 100, 'grams'),
(200, 'Cornstarch', 91.27, 0.26, 0.05, 0.90, 381.00, 3.00, 100, 'grams');

-- =====================================================
-- INGREDIENT CATEGORY ASSIGNMENTS (ADDITIONAL)
-- =====================================================

INSERT INTO ingredient_category_assignments (ingredient_id, category_id) VALUES
-- Vegetables
(66, 1), (67, 1), (68, 1), (69, 1), (70, 1), (71, 1), (72, 1), (73, 1), (74, 1), (75, 1),
(76, 1), (77, 1), (78, 1), (79, 1), (80, 1),
-- Fruits
(81, 2), (82, 2), (83, 2), (84, 2), (85, 2), (86, 2), (87, 2), (88, 2), (89, 2), (90, 2),
(91, 2), (92, 2),
-- Meat
(93, 3), (94, 3), (95, 3), (96, 3), (97, 3), (98, 3), (99, 3), (100, 3),
-- Fish & Seafood
(101, 4), (102, 4), (103, 4), (104, 4), (105, 4), (106, 4), (107, 4), (108, 4),
(109, 4), (110, 4), (111, 4), (112, 4),
-- Dairy
(113, 5), (114, 5), (115, 5), (116, 5), (117, 5), (118, 5), (119, 5), (120, 5), (121, 5), (122, 5),
-- Grains
(123, 6), (124, 6), (125, 6), (126, 6), (127, 6), (128, 6), (129, 6), (130, 6),
-- Pasta
(131, 15), (132, 15), (133, 15), (134, 15), (135, 15), (136, 15), (137, 15), (138, 15), (139, 15),
-- Legumes
(140, 7), (141, 7), (142, 7), (143, 7), (144, 7), (145, 7), (146, 7), (147, 7), (148, 7),
-- Nuts & Seeds
(149, 8), (150, 8), (151, 8), (152, 8), (153, 8), (154, 8), (155, 8), (156, 8), (157, 8),
(158, 8), (159, 8), (160, 8),
-- Herbs & Spices
(161, 9), (162, 9), (163, 9), (164, 9), (165, 9), (166, 9), (167, 9), (168, 9), (169, 9),
(170, 9), (171, 9), (172, 9), (173, 9), (174, 9), (175, 9), (176, 9), (177, 9),
-- Oils & Fats
(91, 10),
-- Condiments
(178, 12), (179, 12), (180, 12), (181, 12), (182, 12), (183, 12), (184, 12), (185, 12),
(186, 12), (187, 12), (188, 12), (189, 12), (190, 12),
-- Sweeteners
(191, 11), (192, 11), (193, 11), (194, 11),
-- Baking
(195, 13), (196, 13), (197, 13), (198, 13), (199, 13), (200, 13);

-- =====================================================
-- INGREDIENT ALLERGIES (ADDITIONAL)
-- =====================================================

INSERT INTO ingredient_allergies (ingredient_id, allergy_id) VALUES
-- Shellfish allergies
(106, 8), (107, 8), (108, 14), (111, 14),
-- Fish allergies
(101, 7), (102, 7), (103, 7), (104, 7), (105, 7),
-- Dairy allergies
(113, 3), (114, 3), (115, 3), (116, 3), (117, 3), (118, 3), (119, 3), (120, 3), (121, 3), (122, 3),
-- Nut allergies
(149, 2), (150, 2), (151, 2), (152, 2), (153, 2), (154, 2), (155, 2),
-- Wheat/Gluten allergies
(131, 5), (132, 5), (133, 5), (134, 5), (135, 5), (139, 5), (130, 5),
-- Soy allergies
(179, 6), (180, 7), (181, 8),
-- Corn allergies
(74, 15), (128, 15), (200, 15),
-- Celery allergies
(70, 12),
-- Sesame allergies
(160, 9), (182, 9);

-- =====================================================
-- ADDITIONAL USER PREFERENCES
-- =====================================================

INSERT INTO user_ingredient_preferences (user_id, ingredient_id, preference_type) VALUES
-- Yuki (Japan) - loves fish, rice, soy
(11, 21, 'preferred'), (11, 22, 'preferred'), (11, 31, 'preferred'), (11, 57, 'preferred'),
-- Mohammed - excludes pork, loves lamb
(12, 18, 'excluded'), (12, 19, 'excluded'), (12, 93, 'preferred'),
-- Olivia - health conscious, prefers vegetables
(13, 7, 'preferred'), (13, 8, 'preferred'), (13, 79, 'preferred'), (13, 23, 'excluded'),
-- Diego - loves Mexican flavors
(14, 91, 'preferred'), (14, 170, 'preferred'), (14, 162, 'preferred'),
-- Fatima - Mediterranean diet
(15, 51, 'preferred'), (15, 39, 'preferred'), (15, 123, 'preferred'),
-- Lars - Nordic preferences
(16, 102, 'preferred'), (16, 32, 'preferred'), (16, 76, 'preferred'),
-- Priya - Indian cuisine lover
(17, 166, 'preferred'), (17, 167, 'preferred'), (17, 38, 'preferred'),
-- Michael - loves stir-fry
(18, 57, 'preferred'), (18, 169, 'preferred'), (18, 3, 'preferred'),
-- Isabella - Portuguese style
(19, 24, 'preferred'), (19, 51, 'preferred'), (19, 76, 'preferred'),
-- Alexander - meat lover
(20, 95, 'preferred'), (20, 93, 'preferred'), (20, 18, 'preferred');

INSERT INTO user_ingredient_category_preferences (user_id, category_id, preference_type) VALUES
-- Health-conscious users prefer vegetables
(13, 1, 'preferred'), (13, 7, 'preferred'),
-- Mohammed excludes pork
(12, 3, 'preferred'),
-- Vegetarian preferences
(15, 3, 'excluded'), (15, 4, 'excluded'),
-- Seafood lovers
(11, 4, 'preferred'), (19, 4, 'preferred');

-- =====================================================
-- ADDITIONAL RECIPES DATA
-- =====================================================

INSERT INTO recipes (recipe_id, title, description, servings, is_published, difficulty, author_user_id) VALUES
(16, 'Sushi Rice Bowl', 'Japanese rice bowl with fresh fish and vegetables', 2, TRUE, 'Medium', 11),
(17, 'Lamb Tagine', 'Moroccan slow-cooked lamb with vegetables and spices', 6, TRUE, 'Hard', 15),
(18, 'Caesar Salad', 'Classic Roman salad with romaine and parmesan', 4, TRUE, 'Easy', 1),
(19, 'Chicken Fajitas', 'Mexican sizzling chicken with peppers', 4, TRUE, 'Easy', 14),
(20, 'Tom Yum Soup', 'Spicy Thai soup with shrimp', 4, TRUE, 'Medium', 11),
(21, 'Moussaka', 'Greek layered eggplant and meat casserole', 8, TRUE, 'Hard', 1),
(22, 'Butter Chicken', 'Indian creamy tomato chicken curry', 4, TRUE, 'Medium', 17),
(23, 'Spaghetti Bolognese', 'Italian meat sauce pasta', 6, TRUE, 'Easy', 5),
(24, 'Pho Bo', 'Vietnamese beef noodle soup', 4, TRUE, 'Hard', 18),
(25, 'Shakshuka', 'Middle Eastern eggs in tomato sauce', 4, TRUE, 'Easy', 12),
(26, 'Paella', 'Spanish rice with seafood and chicken', 6, TRUE, 'Hard', 3),
(27, 'Chicken Satay', 'Indonesian grilled chicken skewers with peanut sauce', 4, TRUE, 'Medium', 18),
(28, 'Falafel', 'Middle Eastern chickpea fritters', 4, TRUE, 'Medium', 12),
(29, 'Lasagna', 'Italian layered pasta with meat and cheese', 8, TRUE, 'Hard', 5),
(30, 'Beef Stroganoff', 'Russian beef in creamy sauce', 4, TRUE, 'Medium', 20),
(31, 'Gazpacho', 'Spanish cold tomato soup', 6, TRUE, 'Easy', 3),
(32, 'Chicken Schnitzel', 'Austrian breaded chicken cutlet', 4, TRUE, 'Medium', 8),
(33, 'Jambalaya', 'Louisiana Creole rice dish', 6, TRUE, 'Medium', 7),
(34, 'Bibimbap', 'Korean mixed rice bowl', 4, TRUE, 'Medium', 18),
(35, 'Croque Monsieur', 'French ham and cheese sandwich', 2, TRUE, 'Easy', 6),
(36, 'Chicken Korma', 'Mild Indian curry with cream and nuts', 4, TRUE, 'Medium', 17),
(37, 'Fish Tacos', 'Mexican-style fish tacos with cabbage slaw', 4, TRUE, 'Easy', 14),
(38, 'Minestrone', 'Italian vegetable soup', 6, TRUE, 'Easy', 5),
(39, 'Duck Confit', 'French preserved duck leg', 4, TRUE, 'Expert', 9),
(40, 'Ceviche', 'Latin American citrus-cured fish', 4, TRUE, 'Easy', 14),
(41, 'Chicken Parmesan', 'Italian-American breaded chicken with cheese', 4, TRUE, 'Medium', 7),
(42, 'Miso Ramen', 'Japanese noodle soup with miso broth', 2, TRUE, 'Hard', 11),
(43, 'Coq au Vin', 'French chicken in red wine', 6, TRUE, 'Hard', 9),
(44, 'Enchiladas', 'Mexican rolled tortillas with sauce', 6, TRUE, 'Medium', 14),
(45, 'Bouillabaisse', 'French fish stew from Marseille', 6, TRUE, 'Expert', 6),
(46, 'Goulash', 'Hungarian beef stew with paprika', 6, TRUE, 'Medium', 8),
(47, 'Chicken Teriyaki', 'Japanese glazed chicken', 4, TRUE, 'Easy', 11),
(48, 'Carbonara', 'Roman pasta with guanciale and egg', 4, TRUE, 'Medium', 5),
(49, 'Chicken Noodle Soup', 'American comfort soup', 6, TRUE, 'Easy', 1),
(50, 'Stuffed Peppers', 'Bell peppers filled with meat and rice', 4, TRUE, 'Medium', 13),
(51, 'Quiche Lorraine', 'French egg and bacon tart', 6, TRUE, 'Medium', 6),
(52, 'Pad See Ew', 'Thai stir-fried noodles', 2, TRUE, 'Easy', 11),
(53, 'Chicken Curry', 'Classic curry with vegetables', 4, TRUE, 'Medium', 17),
(54, 'Pasta Primavera', 'Italian pasta with spring vegetables', 4, TRUE, 'Easy', 5),
(55, 'Beef Tacos', 'Classic Mexican tacos', 4, TRUE, 'Easy', 14),
(56, 'Chicken Souvlaki', 'Greek grilled chicken skewers', 4, TRUE, 'Easy', 1),
(57, 'Shrimp Scampi', 'Italian-American garlic butter shrimp', 4, TRUE, 'Easy', 4),
(58, 'Vegetable Curry', 'Indian spiced vegetable stew', 6, TRUE, 'Medium', 17),
(59, 'Peking Duck', 'Chinese roasted duck', 4, TRUE, 'Expert', 18),
(60, 'Caprese Salad', 'Italian tomato mozzarella salad', 4, TRUE, 'Easy', 5);

-- =====================================================
-- RECIPE INGREDIENTS DATA (ADDITIONAL RECIPES)
-- =====================================================

-- Recipe 16: Sushi Rice Bowl
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(16, 31, 300, FALSE), (16, 21, 200, FALSE), (16, 22, 150, FALSE),
(16, 91, 100, FALSE), (16, 66, 100, FALSE), (16, 57, 30, FALSE),
(16, 58, 20, FALSE), (16, 160, 10, TRUE);

-- Recipe 17: Lamb Tagine
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(17, 93, 1000, FALSE), (17, 2, 200, FALSE), (17, 3, 20, FALSE),
(17, 1, 400, FALSE), (17, 75, 300, FALSE), (17, 39, 200, FALSE),
(17, 167, 10, FALSE), (17, 48, 5, FALSE), (17, 169, 15, FALSE),
(17, 55, 30, FALSE), (17, 51, 50, FALSE);

-- Recipe 18: Caesar Salad
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(18, 67, 400, FALSE), (18, 114, 50, FALSE), (18, 112, 30, TRUE),
(18, 34, 100, FALSE), (18, 3, 10, FALSE), (18, 184, 100, FALSE),
(18, 14, 30, FALSE), (18, 51, 30, FALSE);

-- Recipe 19: Chicken Fajitas
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(19, 16, 600, FALSE), (19, 6, 300, FALSE), (19, 2, 200, FALSE),
(19, 14, 30, FALSE), (19, 170, 10, FALSE), (19, 167, 5, FALSE),
(19, 51, 40, FALSE), (19, 118, 100, TRUE), (19, 26, 100, TRUE);

-- Recipe 20: Tom Yum Soup
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(20, 23, 300, FALSE), (20, 9, 150, FALSE), (20, 1, 200, FALSE),
(20, 14, 50, FALSE), (20, 169, 30, FALSE), (20, 162, 20, FALSE),
(20, 170, 5, FALSE), (20, 180, 20, FALSE);

-- Recipe 21: Moussaka
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(21, 68, 1000, FALSE), (21, 17, 500, FALSE), (21, 2, 200, FALSE),
(21, 1, 400, FALSE), (21, 3, 20, FALSE), (21, 25, 500, FALSE),
(21, 65, 200, FALSE), (21, 114, 100, FALSE), (21, 48, 5, FALSE),
(21, 51, 100, FALSE);

-- Recipe 22: Butter Chicken
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(22, 16, 800, FALSE), (22, 1, 400, FALSE), (22, 29, 200, FALSE),
(22, 28, 50, FALSE), (22, 3, 20, FALSE), (22, 169, 15, FALSE),
(22, 166, 10, FALSE), (22, 167, 5, FALSE), (22, 173, 3, FALSE),
(22, 27, 100, FALSE);

-- Recipe 23: Spaghetti Bolognese
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(23, 33, 500, FALSE), (23, 17, 500, FALSE), (23, 1, 400, FALSE),
(23, 2, 150, FALSE), (23, 4, 100, FALSE), (23, 3, 15, FALSE),
(23, 187, 100, FALSE), (23, 51, 40, FALSE), (23, 46, 5, FALSE),
(23, 175, 2, FALSE), (23, 114, 50, TRUE);

-- Recipe 24: Pho Bo
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(24, 136, 400, FALSE), (24, 95, 400, FALSE), (24, 2, 100, FALSE),
(24, 169, 30, FALSE), (24, 165, 10, FALSE), (24, 174, 5, FALSE),
(24, 162, 50, FALSE), (24, 14, 30, FALSE), (24, 180, 30, FALSE);

-- Recipe 25: Shakshuka
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(25, 1, 500, FALSE), (25, 65, 400, FALSE), (25, 2, 150, FALSE),
(25, 6, 150, FALSE), (25, 3, 15, FALSE), (25, 167, 10, FALSE),
(25, 47, 10, FALSE), (25, 51, 40, FALSE), (25, 161, 20, TRUE);

-- Recipe 26: Paella
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(26, 31, 500, FALSE), (26, 16, 400, FALSE), (26, 23, 300, FALSE),
(26, 108, 200, FALSE), (26, 73, 150, FALSE), (26, 1, 300, FALSE),
(26, 6, 200, FALSE), (26, 3, 20, FALSE), (26, 47, 10, FALSE),
(26, 51, 50, FALSE);

-- Recipe 27: Chicken Satay
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(27, 16, 600, FALSE), (27, 42, 100, FALSE), (27, 57, 40, FALSE),
(27, 55, 30, FALSE), (27, 14, 30, FALSE), (27, 3, 15, FALSE),
(27, 169, 10, FALSE), (27, 121, 100, FALSE);

-- Recipe 28: Falafel
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(28, 39, 400, FALSE), (28, 2, 100, FALSE), (28, 3, 20, FALSE),
(28, 161, 50, FALSE), (28, 162, 30, FALSE), (28, 167, 10, FALSE),
(28, 168, 10, FALSE), (28, 52, 200, FALSE);

-- Recipe 29: Lasagna
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(29, 131, 400, FALSE), (29, 17, 500, FALSE), (29, 1, 400, FALSE),
(29, 117, 500, FALSE), (29, 30, 300, FALSE), (29, 114, 100, FALSE),
(29, 2, 150, FALSE), (29, 3, 20, FALSE), (29, 51, 50, FALSE),
(29, 46, 10, FALSE);

-- Recipe 30: Beef Stroganoff
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(30, 95, 600, FALSE), (30, 9, 300, FALSE), (30, 2, 150, FALSE),
(30, 118, 200, FALSE), (30, 28, 30, FALSE), (30, 61, 30, FALSE),
(30, 44, 5, FALSE), (30, 139, 300, FALSE);

-- Recipe 31: Gazpacho
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(31, 1, 1000, FALSE), (31, 66, 200, FALSE), (31, 6, 150, FALSE),
(31, 2, 100, FALSE), (31, 3, 15, FALSE), (31, 51, 60, FALSE),
(31, 58, 30, FALSE), (31, 34, 100, TRUE);

-- Recipe 32: Chicken Schnitzel
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(32, 16, 600, FALSE), (32, 61, 150, FALSE), (32, 65, 100, FALSE),
(32, 34, 150, FALSE), (32, 52, 200, FALSE), (32, 14, 50, TRUE),
(32, 161, 20, TRUE);

-- Recipe 33: Jambalaya
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(33, 31, 400, FALSE), (33, 16, 300, FALSE), (33, 100, 200, FALSE),
(33, 23, 200, FALSE), (33, 1, 300, FALSE), (33, 6, 200, FALSE),
(33, 70, 100, FALSE), (33, 3, 15, FALSE), (33, 170, 10, FALSE);

-- Recipe 34: Bibimbap
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(34, 31, 400, FALSE), (34, 95, 200, FALSE), (34, 7, 150, FALSE),
(34, 4, 100, FALSE), (34, 9, 100, FALSE), (34, 65, 100, FALSE),
(34, 57, 40, FALSE), (34, 52, 40, FALSE), (34, 160, 10, FALSE);

-- Recipe 35: Croque Monsieur
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(35, 34, 200, FALSE), (35, 26, 100, FALSE), (35, 28, 40, FALSE),
(35, 25, 200, FALSE), (35, 61, 30, FALSE);

-- Recipe 36: Chicken Korma
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(36, 16, 700, FALSE), (36, 27, 200, FALSE), (36, 29, 150, FALSE),
(36, 2, 150, FALSE), (36, 3, 20, FALSE), (36, 169, 15, FALSE),
(36, 173, 5, FALSE), (36, 149, 50, FALSE), (36, 40, 30, TRUE);

-- Recipe 37: Fish Tacos
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(37, 24, 500, FALSE), (37, 78, 200, FALSE), (37, 14, 40, FALSE),
(37, 162, 30, FALSE), (37, 91, 150, TRUE), (37, 118, 100, TRUE),
(37, 52, 50, FALSE);

-- Recipe 38: Minestrone
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(38, 1, 300, FALSE), (38, 4, 150, FALSE), (38, 70, 100, FALSE),
(38, 78, 150, FALSE), (38, 72, 150, FALSE), (38, 148, 200, FALSE),
(38, 33, 100, FALSE), (38, 51, 40, FALSE), (38, 45, 20, FALSE);

-- Recipe 39: Duck Confit
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(39, 94, 800, FALSE), (39, 43, 50, FALSE), (39, 49, 10, FALSE),
(39, 175, 3, FALSE), (39, 3, 20, FALSE);

-- Recipe 40: Ceviche
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(40, 105, 500, FALSE), (40, 14, 100, FALSE), (40, 1, 200, FALSE),
(40, 2, 100, FALSE), (40, 162, 50, FALSE), (40, 170, 5, TRUE);

-- Recipe 41: Chicken Parmesan
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(41, 16, 600, FALSE), (41, 61, 150, FALSE), (41, 65, 100, FALSE),
(41, 34, 150, FALSE), (41, 1, 300, FALSE), (41, 30, 200, FALSE),
(41, 114, 100, FALSE), (41, 33, 400, FALSE);

-- Recipe 42: Miso Ramen
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(42, 138, 300, FALSE), (42, 18, 200, FALSE), (42, 65, 100, FALSE),
(42, 7, 100, FALSE), (42, 9, 100, FALSE), (42, 57, 40, FALSE),
(42, 3, 15, FALSE), (42, 169, 10, FALSE);

-- Recipe 43: Coq au Vin
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(43, 16, 1200, FALSE), (43, 19, 150, FALSE), (43, 9, 250, FALSE),
(43, 2, 200, FALSE), (43, 4, 150, FALSE), (43, 3, 20, FALSE),
(43, 49, 10, FALSE), (43, 175, 2, FALSE), (43, 28, 40, FALSE);

-- Recipe 44: Enchiladas
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(44, 16, 500, FALSE), (44, 26, 300, FALSE), (44, 1, 400, FALSE),
(44, 2, 150, FALSE), (44, 170, 15, FALSE), (44, 167, 10, FALSE),
(44, 118, 150, TRUE), (44, 162, 30, TRUE);

-- Recipe 45: Bouillabaisse
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(45, 105, 300, FALSE), (45, 23, 200, FALSE), (45, 108, 200, FALSE),
(45, 1, 400, FALSE), (45, 80, 150, FALSE), (45, 3, 30, FALSE),
(45, 165, 5, FALSE), (45, 175, 2, FALSE), (45, 51, 60, FALSE);

-- Recipe 46: Goulash
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(46, 95, 800, FALSE), (46, 2, 300, FALSE), (46, 6, 200, FALSE),
(46, 1, 400, FALSE), (46, 47, 30, FALSE), (46, 167, 10, FALSE),
(46, 51, 50, FALSE);

-- Recipe 47: Chicken Teriyaki
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(47, 16, 600, FALSE), (47, 57, 60, FALSE), (47, 55, 40, FALSE),
(47, 169, 15, FALSE), (47, 3, 10, FALSE), (47, 31, 300, FALSE),
(47, 8, 200, FALSE);

-- Recipe 48: Carbonara (authentic)
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(48, 33, 400, FALSE), (48, 19, 200, FALSE), (48, 65, 200, FALSE),
(48, 114, 100, FALSE), (48, 44, 5, FALSE);

-- Recipe 49: Chicken Noodle Soup
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(49, 16, 400, FALSE), (49, 139, 200, FALSE), (49, 4, 150, FALSE),
(49, 70, 100, FALSE), (49, 2, 100, FALSE), (49, 161, 30, FALSE);

-- Recipe 50: Stuffed Peppers
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(50, 6, 600, FALSE), (50, 17, 400, FALSE), (50, 31, 200, FALSE),
(50, 1, 200, FALSE), (50, 2, 100, FALSE), (50, 26, 150, FALSE);

-- Recipe 51: Quiche Lorraine
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(51, 61, 200, FALSE), (51, 28, 100, FALSE), (51, 65, 300, FALSE),
(51, 29, 200, FALSE), (51, 19, 150, FALSE), (51, 26, 100, FALSE);

-- Recipe 52: Pad See Ew
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(52, 136, 300, FALSE), (52, 16, 200, FALSE), (52, 8, 200, FALSE),
(52, 57, 40, FALSE), (52, 54, 20, FALSE), (52, 52, 40, FALSE);

-- Recipe 53: Chicken Curry
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(53, 16, 600, FALSE), (53, 121, 200, FALSE), (53, 1, 300, FALSE),
(53, 2, 150, FALSE), (53, 5, 200, FALSE), (53, 167, 15, FALSE),
(53, 166, 10, FALSE), (53, 169, 15, FALSE);

-- Recipe 54: Pasta Primavera
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(54, 133, 400, FALSE), (54, 8, 200, FALSE), (54, 6, 150, FALSE),
(54, 10, 150, FALSE), (54, 1, 200, FALSE), (54, 51, 50, FALSE),
(54, 3, 10, FALSE), (54, 45, 20, FALSE);

-- Recipe 55: Beef Tacos
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(55, 17, 500, FALSE), (55, 2, 100, FALSE), (55, 1, 200, FALSE),
(55, 26, 150, FALSE), (55, 170, 10, FALSE), (55, 67, 100, TRUE);

-- Recipe 56: Chicken Souvlaki
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(56, 16, 700, FALSE), (56, 51, 60, FALSE), (56, 14, 50, FALSE),
(56, 46, 10, FALSE), (56, 3, 15, FALSE), (56, 27, 200, TRUE);

-- Recipe 57: Shrimp Scampi
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(57, 23, 500, FALSE), (57, 33, 400, FALSE), (57, 3, 30, FALSE),
(57, 28, 100, FALSE), (57, 14, 40, FALSE), (57, 161, 30, FALSE);

-- Recipe 58: Vegetable Curry
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(58, 69, 300, FALSE), (58, 5, 300, FALSE), (58, 7, 200, FALSE),
(58, 39, 200, FALSE), (58, 121, 200, FALSE), (58, 1, 300, FALSE),
(58, 167, 15, FALSE), (58, 166, 10, FALSE);

-- Recipe 59: Peking Duck
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(59, 94, 1500, FALSE), (59, 55, 100, FALSE), (59, 57, 60, FALSE),
(59, 169, 30, FALSE), (59, 165, 10, FALSE), (59, 66, 200, FALSE);

-- Recipe 60: Caprese Salad
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(60, 1, 400, FALSE), (60, 30, 300, FALSE), (60, 45, 30, FALSE),
(60, 51, 50, FALSE), (60, 58, 20, FALSE);

-- =====================================================
-- RECIPE STEPS DATA (SELECTED RECIPES)
-- =====================================================

-- Recipe 16: Sushi Rice Bowl
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(16, 1, 'Cook sushi rice and season with vinegar', 25, 'cooking'),
(16, 2, 'Slice fresh fish into thin pieces', 10, 'action'),
(16, 3, 'Prepare vegetables and avocado', 5, 'action'),
(16, 4, 'Assemble bowl with rice, fish, and vegetables', 5, 'action'),
(16, 5, 'Drizzle with soy sauce and serve', 2, 'action');

-- Recipe 22: Butter Chicken
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(22, 1, 'Marinate chicken in yogurt and spices for 1 hour', 60, 'action'),
(22, 2, 'Cook marinated chicken until golden', 15, 'cooking'),
(22, 3, 'Prepare tomato sauce with butter and cream', 20, 'cooking'),
(22, 4, 'Add chicken to sauce and simmer', 15, 'cooking'),
(22, 5, 'Garnish with cream and serve with rice', 5, 'action');

-- Recipe 25: Shakshuka
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(25, 1, 'Sauté onions and peppers in olive oil', 8, 'cooking'),
(25, 2, 'Add tomatoes and spices, simmer until thick', 15, 'cooking'),
(25, 3, 'Make wells in sauce and crack eggs into them', 2, 'action'),
(25, 4, 'Cover and cook until eggs are just set', 8, 'cooking'),
(25, 5, 'Garnish with parsley and serve hot', 2, 'action');

-- Recipe 29: Lasagna
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(29, 1, 'Prepare bolognese sauce with meat and tomatoes', 45, 'cooking'),
(29, 2, 'Cook lasagna sheets according to package', 12, 'cooking'),
(29, 3, 'Mix ricotta with egg and herbs', 5, 'action'),
(29, 4, 'Layer sauce, pasta, ricotta, and mozzarella', 15, 'action'),
(29, 5, 'Bake at 180°C for 45 minutes', 45, 'cooking'),
(29, 6, 'Let rest for 10 minutes before serving', 10, 'action');

-- Recipe 35: Croque Monsieur
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(35, 1, 'Make béchamel sauce with butter, flour, and milk', 10, 'cooking'),
(35, 2, 'Butter bread slices on one side', 2, 'action'),
(35, 3, 'Layer cheese and ham between bread', 3, 'action'),
(35, 4, 'Top with béchamel and more cheese', 2, 'action'),
(35, 5, 'Bake or grill until golden and bubbling', 10, 'cooking');

-- Recipe 40: Ceviche
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(40, 1, 'Cut fresh fish into small cubes', 10, 'action'),
(40, 2, 'Cover fish with fresh lime juice', 3, 'action'),
(40, 3, 'Refrigerate for 30 minutes to "cook"', 30, 'action'),
(40, 4, 'Add diced tomato, onion, and cilantro', 5, 'action'),
(40, 5, 'Season and serve immediately', 2, 'action');

-- Recipe 60: Caprese Salad
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(60, 1, 'Slice tomatoes and mozzarella', 5, 'action'),
(60, 2, 'Arrange alternating slices on a plate', 3, 'action'),
(60, 3, 'Tuck fresh basil leaves between slices', 2, 'action'),
(60, 4, 'Drizzle with olive oil and balsamic', 1, 'action'),
(60, 5, 'Season with salt and pepper, serve', 1, 'action');

-- =====================================================
-- USER INGREDIENT STOCK DATA (ADDITIONAL)
-- =====================================================

INSERT INTO user_ingredient_stock (user_id, ingredient_id, quantity, expiration_date, storage_location) VALUES
-- Yuki's Japanese ingredients
(11, 31, 2000, DATE_ADD(CURDATE(), INTERVAL 365 DAY), 'Pantry'),
(11, 21, 400, DATE_ADD(CURDATE(), INTERVAL 2 DAY), 'Refrigerator'),
(11, 57, 500, DATE_ADD(CURDATE(), INTERVAL 180 DAY), 'Pantry'),
(11, 160, 100, DATE_ADD(CURDATE(), INTERVAL 365 DAY), 'Pantry'),

-- Mohammed's stock
(12, 93, 800, DATE_ADD(CURDATE(), INTERVAL 5 DAY), 'Freezer'),
(12, 123, 500, DATE_ADD(CURDATE(), INTERVAL 365 DAY), 'Pantry'),
(12, 167, 50, DATE_ADD(CURDATE(), INTERVAL 365 DAY), 'Pantry'),

-- Olivia's healthy ingredients
(13, 7, 300, DATE_ADD(CURDATE(), INTERVAL 4 DAY), 'Refrigerator'),
(13, 8, 300, DATE_ADD(CURDATE(), INTERVAL 4 DAY), 'Refrigerator'),
(13, 79, 200, DATE_ADD(CURDATE(), INTERVAL 3 DAY), 'Refrigerator'),
(13, 36, 500, DATE_ADD(CURDATE(), INTERVAL 365 DAY), 'Pantry'),

-- Diego's Mexican pantry
(14, 91, 300, DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'Refrigerator'),
(14, 170, 100, DATE_ADD(CURDATE(), INTERVAL 365 DAY), 'Pantry'),
(14, 162, 100, DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'Refrigerator'),

-- Fatima's Mediterranean stock
(15, 51, 1000, DATE_ADD(CURDATE(), INTERVAL 365 DAY), 'Pantry'),
(15, 39, 500, DATE_ADD(CURDATE(), INTERVAL 365 DAY), 'Pantry'),
(15, 123, 500, DATE_ADD(CURDATE(), INTERVAL 365 DAY), 'Pantry'),

-- More users' stock
(16, 102, 300, DATE_ADD(CURDATE(), INTERVAL 60 DAY), 'Pantry'),
(17, 166, 100, DATE_ADD(CURDATE(), INTERVAL 365 DAY), 'Pantry'),
(18, 57, 500, DATE_ADD(CURDATE(), INTERVAL 180 DAY), 'Pantry'),
(19, 24, 500, DATE_ADD(CURDATE(), INTERVAL 3 DAY), 'Refrigerator'),
(20, 95, 1000, DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'Freezer');

-- =====================================================
-- COMPLETED RECIPES DATA (ADDITIONAL)
-- =====================================================

INSERT INTO completed_recipes (user_id, recipe_id, rating, comment, completion_date) VALUES
-- Yuki's completions
(11, 16, 5, 'Perfect sushi rice bowl!', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(11, 42, 5, 'Authentic ramen taste', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(11, 47, 4, 'Easy and delicious', DATE_SUB(NOW(), INTERVAL 7 DAY)),

-- Mohammed's completions
(12, 17, 5, 'Amazing tagine, reminds me of home', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(12, 25, 5, 'Perfect shakshuka for breakfast', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(12, 28, 4, 'Great falafel recipe', DATE_SUB(NOW(), INTERVAL 10 DAY)),

-- Olivia's completions
(13, 18, 5, 'Best Caesar salad ever', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(13, 38, 5, 'Healthy and filling', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(13, 54, 4, 'Love the fresh vegetables', DATE_SUB(NOW(), INTERVAL 8 DAY)),

-- Diego's completions
(14, 19, 5, 'Authentic Mexican fajitas!', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(14, 37, 5, 'Fish tacos are incredible', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(14, 44, 4, 'Family loved the enchiladas', DATE_SUB(NOW(), INTERVAL 12 DAY)),

-- Fatima's completions
(15, 28, 5, 'Perfect falafel recipe', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(15, 58, 5, 'Delicious vegetable curry', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(15, 31, 4, 'Refreshing gazpacho', DATE_SUB(NOW(), INTERVAL 9 DAY)),

-- Lars's completions
(16, 32, 4, 'Good schnitzel', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(16, 46, 5, 'Hearty goulash', DATE_SUB(NOW(), INTERVAL 7 DAY)),

-- Priya's completions
(17, 22, 5, 'Best butter chicken recipe!', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(17, 36, 5, 'Creamy korma perfection', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(17, 53, 5, 'Classic curry done right', DATE_SUB(NOW(), INTERVAL 8 DAY)),

-- Michael's completions
(18, 24, 5, 'Authentic pho', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(18, 27, 4, 'Great satay', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(18, 34, 5, 'Perfect bibimbap', DATE_SUB(NOW(), INTERVAL 10 DAY)),

-- Isabella's completions
(19, 40, 5, 'Fresh and delicious ceviche', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(19, 45, 4, 'Good bouillabaisse', DATE_SUB(NOW(), INTERVAL 5 DAY)),

-- Alexander's completions
(20, 30, 5, 'Rich stroganoff', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(20, 46, 5, 'Excellent goulash', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(20, 43, 4, 'Classic coq au vin', DATE_SUB(NOW(), INTERVAL 11 DAY)),

-- More completions from existing users
(1, 41, 5, 'Crispy chicken parm!', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(2, 54, 5, 'Love the spring vegetables', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(3, 55, 5, 'Quick and tasty tacos', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(4, 57, 5, 'Garlic shrimp perfection', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(5, 29, 5, 'Best lasagna ever!', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(6, 51, 5, 'Authentic French quiche', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(7, 33, 4, 'Spicy jambalaya', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(8, 52, 5, 'Better than restaurant!', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(9, 39, 5, 'Perfect duck confit', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(10, 58, 4, 'Flavorful vegetable curry', DATE_SUB(NOW(), INTERVAL 3 DAY));

-- =====================================================
-- ADDITIONAL HISTORY DATA
-- =====================================================

INSERT INTO history_users (user_id, first_name, last_name, gender, email, role, country, city, is_active, birth_date, change_type, changed_at) VALUES
(11, 'Yuki', 'Tanaka', 'Female', 'yuki.tanaka@email.com', 'Regular', 'Japan', 'Tokyo', TRUE, '1995-01-12', 'INSERT', DATE_SUB(NOW(), INTERVAL 25 DAY)),
(12, 'Mohammed', 'Al-Rashid', 'Male', 'mohammed.rashid@email.com', 'Regular', 'UAE', 'Dubai', TRUE, '1984-09-05', 'INSERT', DATE_SUB(NOW(), INTERVAL 20 DAY)),
(13, 'Olivia', 'Anderson', 'Female', 'olivia.anderson@email.com', 'Regular', 'Australia', 'Sydney', TRUE, '1990-03-28', 'INSERT', DATE_SUB(NOW(), INTERVAL 18 DAY)),
(13, 'Olivia', 'Anderson', 'Female', 'olivia.anderson@email.com', 'Administrator', 'Australia', 'Sydney', TRUE, '1990-03-28', 'UPDATE', DATE_SUB(NOW(), INTERVAL 5 DAY));

INSERT INTO history_recipes (recipe_id, title, description, servings, difficulty, is_published, author_user_id, change_type, changed_at) VALUES
(16, 'Sushi Bowl', 'Japanese rice bowl', 2, 'Easy', FALSE, 11, 'INSERT', DATE_SUB(NOW(), INTERVAL 15 DAY)),
(16, 'Sushi Rice Bowl', 'Japanese rice bowl with fresh fish and vegetables', 2, 'Medium', TRUE, 11, 'UPDATE', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(22, 'Butter Chicken', 'Indian creamy tomato chicken curry', 4, 'Medium', TRUE, 17, 'INSERT', DATE_SUB(NOW(), INTERVAL 12 DAY));

-- =====================================================
-- ADDITIONAL ERROR LOGS
-- =====================================================

INSERT INTO error_logs (error_type, error_message, procedure_name, user_id, occurred_at, resolved) VALUES
('RECIPE_ERROR', 'Missing ingredient in recipe #45', NULL, 6, DATE_SUB(NOW(), INTERVAL 3 DAY), TRUE),
('STOCK_ERROR', 'Negative quantity detected for user #11', NULL, 11, DATE_SUB(NOW(), INTERVAL 2 DAY), TRUE),
('EXPIRATION_WARNING', 'Multiple items expiring today', NULL, 13, NOW(), FALSE),
('LOW_STOCK_WARNING', 'Low stock alert for ingredient #91', NULL, 14, DATE_SUB(NOW(), INTERVAL 1 DAY), FALSE);

SET FOREIGN_KEY_CHECKS = 1;