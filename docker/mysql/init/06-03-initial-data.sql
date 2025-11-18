USE food_advisor_db;

SET FOREIGN_KEY_CHECKS = 0;

-- =====================================================
-- ADDITIONAL INGREDIENTS DATA (201-350)
-- =====================================================

INSERT INTO ingredients (ingredient_id, name, carbohydrates, proteins, fats, fibers, calories, price, weight, measurement_unit) VALUES
-- More Vegetables (201-220)
(201, 'Artichoke', 10.51, 3.27, 0.15, 5.40, 47.00, 4.50, 100, 'grams'),
(202, 'Brussels Sprouts', 8.95, 3.38, 0.30, 3.80, 43.00, 3.80, 100, 'grams'),
(203, 'Turnip', 6.43, 0.90, 0.10, 1.80, 28.00, 2.00, 100, 'grams'),
(204, 'Parsnip', 17.99, 1.20, 0.30, 4.90, 75.00, 2.50, 100, 'grams'),
(205, 'Rutabaga', 8.62, 1.08, 0.16, 2.30, 37.00, 2.20, 100, 'grams'),
(206, 'Kohlrabi', 6.20, 1.70, 0.10, 3.60, 27.00, 3.00, 100, 'grams'),
(207, 'Fennel', 7.30, 1.24, 0.20, 3.10, 31.00, 3.50, 100, 'grams'),
(208, 'Radicchio', 4.48, 1.43, 0.25, 0.90, 23.00, 4.00, 100, 'grams'),
(209, 'Endive', 3.35, 1.25, 0.20, 3.10, 17.00, 3.80, 100, 'grams'),
(210, 'Arugula', 3.65, 2.58, 0.66, 1.60, 25.00, 3.50, 100, 'grams'),
(211, 'Watercress', 1.29, 2.30, 0.10, 0.50, 11.00, 4.50, 100, 'grams'),
(212, 'Bok Choy', 2.18, 1.50, 0.20, 1.00, 13.00, 3.20, 100, 'grams'),
(213, 'Swiss Chard', 3.74, 1.80, 0.20, 1.60, 19.00, 3.00, 100, 'grams'),
(214, 'Collard Greens', 5.42, 3.02, 0.61, 4.00, 32.00, 3.50, 100, 'grams'),
(215, 'Okra', 7.45, 1.93, 0.19, 3.20, 33.00, 3.80, 100, 'grams'),
(216, 'Bamboo Shoots', 5.20, 2.60, 0.30, 2.20, 27.00, 5.00, 100, 'grams'),
(217, 'Water Chestnuts', 23.94, 1.40, 0.10, 3.00, 97.00, 4.50, 100, 'grams'),
(218, 'Jicama', 8.82, 0.72, 0.09, 4.90, 38.00, 3.00, 100, 'grams'),
(219, 'Ginger Root', 17.77, 1.82, 0.75, 2.00, 80.00, 6.00, 100, 'grams'),
(220, 'Horseradish', 11.29, 1.18, 0.69, 3.30, 48.00, 7.00, 100, 'grams'),

-- More Fruits (221-240)
(221, 'Papaya', 10.82, 0.47, 0.26, 1.70, 43.00, 3.50, 100, 'grams'),
(222, 'Passion Fruit', 23.38, 2.20, 0.70, 10.40, 97.00, 5.50, 100, 'grams'),
(223, 'Dragon Fruit', 13.00, 1.10, 0.40, 3.00, 60.00, 6.00, 100, 'grams'),
(224, 'Lychee', 16.53, 0.83, 0.44, 1.30, 66.00, 7.00, 100, 'grams'),
(225, 'Star Fruit', 6.73, 1.04, 0.33, 2.80, 31.00, 4.50, 100, 'grams'),
(226, 'Guava', 14.32, 2.55, 0.95, 5.40, 68.00, 4.00, 100, 'grams'),
(227, 'Pomegranate', 18.70, 1.67, 1.17, 4.00, 83.00, 5.50, 100, 'grams'),
(228, 'Persimmon', 18.59, 0.58, 0.19, 3.60, 70.00, 4.50, 100, 'grams'),
(229, 'Fig', 19.18, 0.75, 0.30, 2.90, 74.00, 6.50, 100, 'grams'),
(230, 'Date', 74.97, 1.81, 0.15, 6.70, 277.00, 8.00, 100, 'grams'),
(231, 'Apricot', 11.12, 1.40, 0.39, 2.00, 48.00, 4.00, 100, 'grams'),
(232, 'Plum', 11.42, 0.70, 0.28, 1.40, 46.00, 3.50, 100, 'grams'),
(233, 'Nectarine', 10.55, 1.06, 0.32, 1.70, 44.00, 3.80, 100, 'grams'),
(234, 'Cantaloupe', 8.16, 0.84, 0.19, 0.90, 34.00, 2.80, 100, 'grams'),
(235, 'Honeydew', 9.09, 0.54, 0.14, 0.80, 36.00, 3.00, 100, 'grams'),
(236, 'Blackberries', 9.61, 1.39, 0.49, 5.30, 43.00, 6.00, 100, 'grams'),
(237, 'Cranberries', 12.20, 0.39, 0.13, 4.60, 46.00, 5.50, 100, 'grams'),
(238, 'Grapefruit', 10.66, 0.77, 0.14, 1.60, 42.00, 2.50, 100, 'grams'),
(239, 'Tangerine', 13.34, 0.81, 0.31, 1.80, 53.00, 3.00, 100, 'grams'),
(240, 'Lime', 10.54, 0.70, 0.20, 2.80, 30.00, 3.50, 100, 'grams'),

-- More Proteins (241-260)
(241, 'Quail', 0.00, 21.76, 5.00, 0.00, 134.00, 18.00, 100, 'grams'),
(242, 'Rabbit', 0.00, 21.79, 5.55, 0.00, 144.00, 15.00, 100, 'grams'),
(243, 'Venison', 0.00, 30.21, 2.42, 0.00, 157.00, 22.00, 100, 'grams'),
(244, 'Bison', 0.00, 21.62, 1.84, 0.00, 109.00, 20.00, 100, 'grams'),
(245, 'Goose', 0.00, 22.75, 12.67, 0.00, 238.00, 16.00, 100, 'grams'),
(246, 'Pheasant', 0.00, 24.32, 5.16, 0.00, 148.00, 19.00, 100, 'grams'),
(247, 'Prosciutto', 1.00, 25.50, 12.90, 0.00, 234.00, 25.00, 100, 'grams'),
(248, 'Salami', 1.60, 22.60, 33.70, 0.00, 407.00, 18.00, 100, 'grams'),
(249, 'Chorizo', 2.00, 24.10, 38.30, 0.00, 455.00, 15.00, 100, 'grams'),
(250, 'Pancetta', 0.00, 20.90, 40.00, 0.00, 458.00, 20.00, 100, 'grams'),
(251, 'Pastrami', 2.80, 14.10, 5.00, 0.00, 124.00, 22.00, 100, 'grams'),
(252, 'Bologna', 3.30, 10.60, 25.10, 0.00, 301.00, 8.00, 100, 'grams'),
(253, 'Bratwurst', 2.60, 12.40, 27.30, 0.00, 297.00, 12.00, 100, 'grams'),
(254, 'Mortadella', 3.00, 14.70, 25.40, 0.00, 311.00, 16.00, 100, 'grams'),
(255, 'Andouille', 2.00, 13.00, 30.00, 0.00, 315.00, 14.00, 100, 'grams'),
(256, 'Pepperoni', 4.00, 23.00, 40.20, 0.00, 494.00, 12.00, 100, 'grams'),
(257, 'Ham', 1.50, 22.00, 2.50, 0.00, 120.00, 10.00, 100, 'grams'),
(258, 'Corned Beef', 0.47, 18.18, 19.00, 0.00, 251.00, 15.00, 100, 'grams'),
(259, 'Chicken Liver', 0.73, 16.92, 4.83, 0.00, 119.00, 6.00, 100, 'grams'),
(260, 'Beef Liver', 5.35, 20.36, 3.63, 0.00, 135.00, 7.00, 100, 'grams'),

-- More Seafood (261-280)
(261, 'Tilapia', 0.00, 26.15, 1.70, 0.00, 128.00, 9.00, 100, 'grams'),
(262, 'Catfish', 0.00, 16.38, 2.82, 0.00, 105.00, 8.50, 100, 'grams'),
(263, 'Swordfish', 0.00, 19.66, 4.01, 0.00, 121.00, 18.00, 100, 'grams'),
(264, 'Mahi Mahi', 0.00, 18.50, 0.70, 0.00, 85.00, 16.00, 100, 'grams'),
(265, 'Snapper', 0.00, 20.51, 1.34, 0.00, 100.00, 15.00, 100, 'grams'),
(266, 'Grouper', 0.00, 19.38, 1.02, 0.00, 92.00, 17.00, 100, 'grams'),
(267, 'Barramundi', 0.00, 24.30, 2.50, 0.00, 134.00, 14.00, 100, 'grams'),
(268, 'Pollock', 0.00, 17.43, 0.93, 0.00, 78.00, 8.00, 100, 'grams'),
(269, 'Haddock', 0.00, 18.31, 0.45, 0.00, 74.00, 11.00, 100, 'grams'),
(270, 'Sea Bream', 0.00, 19.39, 3.50, 0.00, 115.00, 13.00, 100, 'grams'),
(271, 'Octopus', 2.20, 14.91, 1.04, 0.00, 82.00, 20.00, 100, 'grams'),
(272, 'Clams', 5.13, 12.77, 0.97, 0.00, 86.00, 12.00, 100, 'grams'),
(273, 'Cockles', 4.70, 13.50, 0.60, 0.00, 79.00, 10.00, 100, 'grams'),
(274, 'Conch', 3.00, 18.30, 0.80, 0.00, 92.00, 15.00, 100, 'grams'),
(275, 'Sea Urchin', 3.00, 13.80, 4.30, 0.00, 104.00, 35.00, 100, 'grams'),
(276, 'Caviar', 4.00, 24.60, 17.90, 0.00, 264.00, 100.00, 100, 'grams'),
(277, 'Smoked Salmon', 0.00, 18.28, 4.32, 0.00, 117.00, 22.00, 100, 'grams'),
(278, 'Smoked Trout', 0.00, 24.26, 3.76, 0.00, 132.00, 18.00, 100, 'grams'),
(279, 'Smoked Mackerel', 0.00, 18.50, 11.90, 0.00, 194.00, 14.00, 100, 'grams'),
(280, 'Eel', 0.00, 18.44, 11.66, 0.00, 184.00, 25.00, 100, 'grams'),

-- More Dairy & Cheese (281-295)
(281, 'Gruyere', 0.36, 29.81, 32.34, 0.00, 413.00, 22.00, 100, 'grams'),
(282, 'Brie', 0.45, 20.75, 27.68, 0.00, 334.00, 16.00, 100, 'grams'),
(283, 'Camembert', 0.46, 19.80, 24.26, 0.00, 299.00, 15.00, 100, 'grams'),
(284, 'Roquefort', 2.00, 21.54, 30.64, 0.00, 369.00, 20.00, 100, 'grams'),
(285, 'Gorgonzola', 2.34, 21.40, 28.74, 0.00, 353.00, 18.00, 100, 'grams'),
(286, 'Manchego', 1.32, 25.86, 32.10, 0.00, 406.00, 24.00, 100, 'grams'),
(287, 'Pecorino', 3.63, 25.83, 27.30, 0.00, 387.00, 20.00, 100, 'grams'),
(288, 'Asiago', 3.71, 29.73, 25.49, 0.00, 392.00, 17.00, 100, 'grams'),
(289, 'Fontina', 1.55, 25.60, 31.14, 0.00, 389.00, 19.00, 100, 'grams'),
(290, 'Provolone', 2.14, 25.58, 26.62, 0.00, 351.00, 14.00, 100, 'grams'),
(291, 'Halloumi', 3.00, 22.00, 25.00, 0.00, 321.00, 16.00, 100, 'grams'),
(292, 'Mascarpone', 4.79, 4.84, 43.99, 0.00, 429.00, 12.00, 100, 'grams'),
(293, 'Cream Cheese', 5.52, 5.93, 34.24, 0.00, 342.00, 8.00, 100, 'grams'),
(294, 'Buttermilk', 4.88, 3.31, 0.88, 0.00, 40.00, 4.00, 1000, 'milliliters'),
(295, 'Kefir', 4.48, 3.38, 0.93, 0.00, 41.00, 5.00, 1000, 'milliliters'),

-- More Grains & Ancient Grains (296-310)
(296, 'Amaranth', 65.25, 13.56, 7.02, 6.70, 371.00, 8.00, 100, 'grams'),
(297, 'Teff', 73.13, 13.30, 2.38, 8.00, 367.00, 9.00, 100, 'grams'),
(298, 'Kamut', 70.00, 15.00, 2.20, 7.00, 337.00, 10.00, 100, 'grams'),
(299, 'Spelt', 70.19, 14.57, 2.43, 10.70, 338.00, 7.00, 100, 'grams'),
(300, 'Farro', 67.00, 15.00, 2.50, 6.80, 340.00, 8.00, 100, 'grams'),
(301, 'Freekeh', 72.00, 12.00, 2.30, 12.00, 325.00, 9.00, 100, 'grams'),
(302, 'Sorghum', 74.63, 11.30, 3.30, 6.30, 329.00, 6.00, 100, 'grams'),
(303, 'Wheat Berries', 71.18, 13.21, 1.92, 12.20, 332.00, 5.00, 100, 'grams'),
(304, 'Rye Berries', 75.86, 10.34, 1.63, 15.10, 338.00, 5.50, 100, 'grams'),
(305, 'Polenta', 79.00, 8.70, 2.70, 3.90, 362.00, 4.00, 100, 'grams'),
(306, 'Semolina', 72.83, 12.68, 1.05, 3.90, 360.00, 4.50, 100, 'grams'),
(307, 'Rice Flour', 80.13, 5.95, 1.42, 2.40, 366.00, 5.00, 100, 'grams'),
(308, 'Chickpea Flour', 57.82, 22.39, 6.69, 10.80, 387.00, 7.00, 100, 'grams'),
(309, 'Almond Flour', 21.43, 21.43, 53.57, 10.70, 607.00, 18.00, 100, 'grams'),
(310, 'Coconut Flour', 60.00, 20.00, 16.67, 33.30, 400.00, 12.00, 100, 'grams'),

-- Specialty Ingredients (311-330)
(311, 'Tofu', 1.87, 8.08, 4.78, 0.30, 76.00, 3.50, 100, 'grams'),
(312, 'Tempeh', 9.05, 18.54, 10.80, 0.00, 193.00, 5.00, 100, 'grams'),
(313, 'Seitan', 14.00, 75.00, 1.90, 0.60, 370.00, 8.00, 100, 'grams'),
(314, 'Nori Seaweed', 5.11, 5.81, 0.28, 0.30, 35.00, 6.00, 100, 'grams'),
(315, 'Wakame', 9.14, 3.03, 0.64, 0.50, 45.00, 8.00, 100, 'grams'),
(316, 'Kombu', 12.00, 1.68, 1.16, 1.30, 43.00, 10.00, 100, 'grams'),
(317, 'Kimchi', 3.00, 1.10, 0.50, 1.60, 15.00, 7.00, 100, 'grams'),
(318, 'Sauerkraut', 4.28, 0.91, 0.14, 2.90, 19.00, 4.00, 100, 'grams'),
(319, 'Miso Paste', 25.37, 12.79, 6.01, 5.40, 199.00, 9.00, 100, 'grams'),
(320, 'Nutritional Yeast', 36.00, 50.00, 7.00, 27.00, 325.00, 15.00, 100, 'grams'),
(321, 'Capers', 4.89, 2.36, 0.86, 3.20, 23.00, 8.00, 100, 'grams'),
(322, 'Olives Black', 6.26, 0.84, 10.68, 3.20, 115.00, 6.00, 100, 'grams'),
(323, 'Olives Green', 3.84, 1.03, 15.32, 3.30, 145.00, 6.50, 100, 'grams'),
(324, 'Sun-dried Tomatoes', 55.76, 14.11, 2.97, 12.30, 258.00, 12.00, 100, 'grams'),
(325, 'Pickles', 2.26, 0.33, 0.20, 1.20, 11.00, 3.50, 100, 'grams'),
(326, 'Artichoke Hearts', 10.51, 3.27, 0.34, 5.40, 47.00, 8.00, 100, 'grams'),
(327, 'Roasted Red Peppers', 10.00, 1.50, 0.80, 2.00, 50.00, 7.00, 100, 'grams'),
(328, 'Anchovies Paste', 0.00, 28.90, 9.71, 0.00, 210.00, 10.00, 100, 'grams'),
(329, 'Tamarind Paste', 62.50, 2.80, 0.60, 5.10, 239.00, 9.00, 100, 'grams'),
(330, 'Harissa Paste', 15.00, 3.00, 7.00, 5.00, 120.00, 8.00, 100, 'grams'),

-- More Spices & Seasonings (331-350)
(331, 'Saffron', 65.37, 11.43, 5.85, 3.90, 310.00, 150.00, 100, 'grams'),
(332, 'Sumac', 38.00, 5.00, 14.00, 13.00, 245.00, 12.00, 100, 'grams'),
(333, 'Za\'atar', 42.00, 9.00, 13.00, 20.00, 267.00, 15.00, 100, 'grams'),
(334, 'Garam Masala', 50.00, 12.00, 15.00, 18.00, 379.00, 10.00, 100, 'grams'),
(335, 'Chinese Five Spice', 53.00, 10.00, 8.00, 15.00, 296.00, 9.00, 100, 'grams'),
(336, 'Curry Powder', 55.83, 14.29, 14.01, 33.20, 325.00, 8.00, 100, 'grams'),
(337, 'Allspice', 72.12, 6.09, 8.69, 21.60, 263.00, 10.00, 100, 'grams'),
(338, 'Anise Seeds', 50.02, 17.60, 15.90, 14.60, 337.00, 11.00, 100, 'grams'),
(339, 'Caraway Seeds', 49.90, 19.77, 14.59, 38.00, 333.00, 8.00, 100, 'grams'),
(340, 'Celery Seeds', 41.35, 18.07, 25.27, 11.80, 392.00, 12.00, 100, 'grams'),
(341, 'Dill Seeds', 55.15, 15.98, 14.54, 21.10, 305.00, 9.00, 100, 'grams'),
(342, 'Fenugreek Seeds', 58.35, 23.00, 6.41, 24.60, 323.00, 7.00, 100, 'grams'),
(343, 'Mustard Seeds', 28.09, 26.08, 36.24, 12.20, 508.00, 6.00, 100, 'grams'),
(344, 'Poppy Seeds', 28.13, 17.99, 41.56, 19.50, 525.00, 14.00, 100, 'grams'),
(345, 'Sesame Oil', 0.00, 0.00, 100.00, 0.00, 884.00, 12.00, 1000, 'milliliters'),
(346, 'Truffle Oil', 0.00, 0.00, 100.00, 0.00, 884.00, 45.00, 1000, 'milliliters'),
(347, 'Chili Oil', 0.00, 0.00, 100.00, 0.00, 884.00, 10.00, 1000, 'milliliters'),
(348, 'Lemongrass', 25.31, 1.82, 0.49, 0.00, 99.00, 7.00, 100, 'grams'),
(349, 'Galangal', 15.00, 1.00, 0.50, 2.00, 71.00, 8.00, 100, 'grams'),
(350, 'Kaffir Lime Leaves', 12.00, 2.00, 0.30, 6.00, 53.00, 10.00, 100, 'grams');

-- =====================================================
-- INGREDIENT CATEGORY ASSIGNMENTS (201-350)
-- =====================================================

INSERT INTO ingredient_category_assignments (ingredient_id, category_id) VALUES
-- Vegetables (201-220)
(201, 1), (202, 1), (203, 1), (204, 1), (205, 1), (206, 1), (207, 1), (208, 1), (209, 1), (210, 1),
(211, 1), (212, 1), (213, 1), (214, 1), (215, 1), (216, 1), (217, 1), (218, 1), (219, 1), (220, 1),

-- Fruits (221-240)
(221, 2), (222, 2), (223, 2), (224, 2), (225, 2), (226, 2), (227, 2), (228, 2), (229, 2), (230, 2),
(231, 2), (232, 2), (233, 2), (234, 2), (235, 2), (236, 2), (237, 2), (238, 2), (239, 2), (240, 2),

-- Proteins/Meat (241-260)
(241, 3), (242, 3), (243, 3), (244, 3), (245, 3), (246, 3), (247, 3), (248, 3), (249, 3), (250, 3),
(251, 3), (252, 3), (253, 3), (254, 3), (255, 3), (256, 3), (257, 3), (258, 3), (259, 3), (260, 3),

-- Seafood (261-280)
(261, 4), (262, 4), (263, 4), (264, 4), (265, 4), (266, 4), (267, 4), (268, 4), (269, 4), (270, 4),
(271, 4), (272, 4), (273, 4), (274, 4), (275, 4), (276, 4), (277, 4), (278, 4), (279, 4), (280, 4),

-- Dairy (281-295)
(281, 5), (282, 5), (283, 5), (284, 5), (285, 5), (286, 5), (287, 5), (288, 5), (289, 5), (290, 5),
(291, 5), (292, 5), (293, 5), (294, 5), (295, 5),

-- Grains (296-310)
(296, 6), (297, 6), (298, 6), (299, 6), (300, 6), (301, 6), (302, 6), (303, 6), (304, 6), (305, 6),
(306, 6), (307, 6), (308, 6), (309, 6), (310, 6),

-- Specialty/Condiments (311-330)
(311, 12), (312, 12), (313, 12), (314, 12), (315, 12), (316, 12), (317, 12), (318, 12), (319, 12), (320, 12),
(321, 12), (322, 12), (323, 12), (324, 12), (325, 12), (326, 12), (327, 12), (328, 12), (329, 12), (330, 12),

-- Spices & Oils (331-350)
(331, 9), (332, 9), (333, 9), (334, 9), (335, 9), (336, 9), (337, 9), (338, 9), (339, 9), (340, 9),
(341, 9), (342, 9), (343, 9), (344, 9), (345, 10), (346, 10), (347, 10), (348, 9), (349, 9), (350, 9);

-- =====================================================
-- INGREDIENT ALLERGIES (ADDITIONAL)
-- =====================================================

INSERT INTO ingredient_allergies (ingredient_id, allergy_id) VALUES
-- Seafood allergies
(261, 7), (262, 7), (263, 7), (264, 7), (265, 7), (266, 7), (267, 7), (268, 7), (269, 7), (270, 7),
(271, 14), (272, 8), (273, 8), (274, 14), (275, 8), (280, 7),
-- Dairy allergies
(281, 3), (282, 3), (283, 3), (284, 3), (285, 3), (286, 3), (287, 3), (288, 3), (289, 3), (290, 3),
(291, 3), (292, 3), (293, 3), (294, 3), (295, 3),
-- Gluten/Wheat allergies
(299, 5), (303, 5), (304, 5), (306, 5),
-- Soy allergies
(311, 6), (312, 6), (319, 6),
-- Sesame allergies
(345, 9),
-- Celery allergies
(340, 12);

-- =====================================================
-- NEW RECIPES (61-120)
-- =====================================================

INSERT INTO recipes (recipe_id, title, description, servings, is_published, difficulty, author_user_id) VALUES
-- Asian Cuisine (61-75)
(61, 'Kung Pao Chicken', 'Spicy Sichuan chicken with peanuts', 4, TRUE, 'Medium', 18),
(62, 'Mapo Tofu', 'Spicy Sichuan tofu with ground pork', 4, TRUE, 'Medium', 18),
(63, 'General Tso Chicken', 'Sweet and spicy Chinese chicken', 4, TRUE, 'Medium', 18),
(64, 'Orange Chicken', 'Sweet orange-glazed chicken', 4, TRUE, 'Easy', 11),
(65, 'Beef and Broccoli', 'Classic Chinese stir-fry', 4, TRUE, 'Easy', 18),
(66, 'Sweet and Sour Pork', 'Cantonese pork in tangy sauce', 4, TRUE, 'Medium', 18),
(67, 'Dim Sum Dumplings', 'Steamed pork dumplings', 6, TRUE, 'Hard', 18),
(68, 'Spring Rolls', 'Fresh Vietnamese rolls', 4, TRUE, 'Easy', 11),
(69, 'Chicken Katsu', 'Japanese breaded chicken cutlet', 4, TRUE, 'Medium', 11),
(70, 'Tonkatsu', 'Japanese breaded pork cutlet', 4, TRUE, 'Medium', 11),
(71, 'Okonomiyaki', 'Japanese savory pancake', 4, TRUE, 'Medium', 11),
(72, 'Yakitori', 'Japanese grilled chicken skewers', 4, TRUE, 'Easy', 11),
(73, 'Bulgogi', 'Korean marinated beef', 4, TRUE, 'Medium', 18),
(74, 'Korean Fried Chicken', 'Crispy twice-fried chicken', 4, TRUE, 'Hard', 18),
(75, 'Japchae', 'Korean glass noodle stir-fry', 4, TRUE, 'Medium', 18),

-- Mediterranean & Middle Eastern (76-90)
(76, 'Hummus', 'Classic chickpea dip', 8, TRUE, 'Easy', 12),
(77, 'Baba Ganoush', 'Smoky eggplant dip', 6, TRUE, 'Easy', 12),
(78, 'Tabbouleh', 'Lebanese parsley salad', 6, TRUE, 'Easy', 12),
(79, 'Spanakopita', 'Greek spinach pie', 8, TRUE, 'Hard', 1),
(80, 'Dolma', 'Stuffed grape leaves', 8, TRUE, 'Hard', 12),
(81, 'Kofta', 'Middle Eastern meatballs', 6, TRUE, 'Medium', 12),
(82, 'Chicken Shawarma', 'Middle Eastern spiced chicken', 4, TRUE, 'Medium', 12),
(83, 'Baklava', 'Sweet pastry with nuts and honey', 12, TRUE, 'Hard', 12),
(84, 'Fattoush', 'Lebanese bread salad', 4, TRUE, 'Easy', 12),
(85, 'Mansaf', 'Jordanian lamb with rice', 6, TRUE, 'Hard', 12),
(86, 'Chicken Bastilla', 'Moroccan savory pie', 8, TRUE, 'Expert', 15),
(87, 'Chermoula Fish', 'Moroccan herb-marinated fish', 4, TRUE, 'Medium', 15),
(88, 'Harira', 'Moroccan lentil soup', 6, TRUE, 'Medium', 15),
(89, 'Couscous Royale', 'North African couscous feast', 8, TRUE, 'Hard', 15),
(90, 'Merguez Sausage', 'Spicy North African sausage', 4, TRUE, 'Medium', 15),

-- European Specialties (91-105)
(91, 'Risotto Milanese', 'Saffron risotto from Milan', 4, TRUE, 'Hard', 5),
(92, 'Osso Buco', 'Milanese braised veal shanks', 4, TRUE, 'Expert', 5),
(93, 'Vitello Tonnato', 'Italian veal with tuna sauce', 6, TRUE, 'Medium', 5),
(94, 'Arancini', 'Sicilian fried rice balls', 6, TRUE, 'Hard', 5),
(95, 'Panzanella', 'Tuscan bread salad', 6, TRUE, 'Easy', 5),
(96, 'Cassoulet', 'French white bean stew', 8, TRUE, 'Expert', 9),
(97, 'Duck à l\'Orange', 'French duck with orange sauce', 4, TRUE, 'Expert', 9),
(98, 'Tarte Tatin', 'French upside-down apple tart', 8, TRUE, 'Hard', 6),
(99, 'Crème Brûlée', 'French vanilla custard dessert', 6, TRUE, 'Medium', 6),
(100, 'Sauerbraten', 'German pot roast', 6, TRUE, 'Hard', 8),
(101, 'Wiener Schnitzel', 'Austrian veal cutlet', 4, TRUE, 'Medium', 8),
(102, 'Paella Valenciana', 'Original Valencian paella', 6, TRUE, 'Hard', 3),
(103, 'Tortilla Española', 'Spanish potato omelet', 6, TRUE, 'Easy', 3),
(104, 'Patatas Bravas', 'Spicy Spanish potatoes', 4, TRUE, 'Easy', 3),
(105, 'Bacalhau à Brás', 'Portuguese salt cod dish', 4, TRUE, 'Medium', 19),

-- Americas (106-120)
(106, 'Pulled Pork', 'American BBQ pulled pork', 8, TRUE, 'Hard', 7),
(107, 'Brisket', 'Texas-style smoked brisket', 8, TRUE, 'Expert', 7),
(108, 'Mac and Cheese', 'Classic American comfort food', 6, TRUE, 'Easy', 7),
(109, 'Clam Chowder', 'New England creamy soup', 6, TRUE, 'Medium', 4),
(110, 'Lobster Roll', 'New England lobster sandwich', 4, TRUE, 'Easy', 4),
(111, 'Gumbo', 'Louisiana Creole stew', 8, TRUE, 'Hard', 7),
(112, 'Red Beans and Rice', 'Creole Monday classic', 6, TRUE, 'Easy', 7),
(113, 'Chicken and Waffles', 'Southern comfort dish', 4, TRUE, 'Medium', 7),
(114, 'Mole Poblano', 'Mexican chocolate chili sauce', 6, TRUE, 'Expert', 14),
(115, 'Chiles Rellenos', 'Stuffed poblano peppers', 4, TRUE, 'Hard', 14),
(116, 'Pozole', 'Mexican hominy soup', 8, TRUE, 'Medium', 14),
(117, 'Tamales', 'Steamed corn masa with filling', 12, TRUE, 'Hard', 14),
(118, 'Empanadas', 'Latin American stuffed pastries', 8, TRUE, 'Medium', 14),
(119, 'Peruvian Ceviche', 'Tiger milk marinated fish', 4, TRUE, 'Easy', 14),
(120, 'Feijoada', 'Brazilian black bean stew', 8, TRUE, 'Hard', 10);

-- =====================================================
-- RECIPE INGREDIENTS (SELECTED RECIPES 61-120)
-- =====================================================

-- Recipe 61: Kung Pao Chicken
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(61, 16, 600, FALSE), (61, 149, 100, FALSE), (61, 6, 200, FALSE),
(61, 57, 40, FALSE), (61, 58, 20, FALSE), (61, 54, 20, FALSE),
(61, 3, 20, FALSE), (61, 169, 15, FALSE), (61, 170, 10, FALSE);

-- Recipe 62: Mapo Tofu
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(62, 311, 500, FALSE), (62, 17, 200, FALSE), (62, 57, 40, FALSE),
(62, 319, 30, FALSE), (62, 3, 20, FALSE), (62, 169, 15, FALSE),
(62, 170, 10, FALSE), (62, 80, 50, FALSE);

-- Recipe 63: General Tso's Chicken
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(63, 16, 700, FALSE), (63, 57, 60, FALSE), (63, 54, 40, FALSE),
(63, 58, 30, FALSE), (63, 169, 20, FALSE), (63, 3, 15, FALSE),
(63, 170, 10, FALSE), (63, 61, 100, FALSE);

-- Recipe 64: Orange Chicken
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(64, 16, 700, FALSE), (64, 13, 200, FALSE), (64, 54, 50, FALSE),
(64, 57, 40, FALSE), (64, 169, 15, FALSE), (64, 61, 100, FALSE);

-- Recipe 65: Beef and Broccoli
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(65, 95, 500, FALSE), (65, 8, 400, FALSE), (65, 57, 50, FALSE),
(65, 3, 15, FALSE), (65, 169, 10, FALSE), (65, 52, 40, FALSE);

-- Recipe 76: Hummus
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(76, 39, 400, FALSE), (76, 182, 100, FALSE), (76, 14, 60, FALSE),
(76, 3, 20, FALSE), (76, 51, 60, FALSE), (76, 167, 5, FALSE);

-- Recipe 77: Baba Ganoush
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(77, 68, 800, FALSE), (77, 182, 80, FALSE), (77, 14, 50, FALSE),
(77, 3, 15, FALSE), (77, 51, 40, FALSE), (77, 161, 20, FALSE);

-- Recipe 78: Tabbouleh
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(78, 124, 100, FALSE), (78, 161, 200, FALSE), (78, 1, 300, FALSE),
(78, 66, 100, FALSE), (78, 14, 60, FALSE), (78, 51, 80, FALSE),
(78, 164, 30, FALSE);

-- Recipe 79: Spanakopita
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(79, 7, 1000, FALSE), (79, 113, 400, FALSE), (79, 65, 200, FALSE),
(79, 2, 200, FALSE), (79, 51, 100, FALSE), (79, 163, 20, FALSE);

-- Recipe 83: Baklava
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(83, 41, 400, FALSE), (83, 150, 200, FALSE), (83, 28, 200, FALSE),
(83, 55, 300, FALSE), (83, 48, 10, FALSE), (83, 174, 5, FALSE);

-- Recipe 91: Risotto Milanese
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(91, 31, 400, FALSE), (91, 331, 1, FALSE), (91, 2, 100, FALSE),
(91, 28, 80, FALSE), (91, 114, 100, FALSE), (91, 51, 40, FALSE);

-- Recipe 92: Osso Buco
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(92, 96, 1200, FALSE), (92, 1, 400, FALSE), (92, 4, 150, FALSE),
(92, 70, 150, FALSE), (92, 2, 150, FALSE), (92, 51, 60, FALSE),
(92, 175, 2, FALSE), (92, 50, 10, FALSE);

-- Recipe 96: Cassoulet
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(96, 148, 500, FALSE), (96, 94, 400, FALSE), (96, 100, 300, FALSE),
(96, 93, 400, FALSE), (96, 1, 300, FALSE), (96, 4, 150, FALSE),
(96, 49, 10, FALSE), (96, 175, 2, FALSE);

-- Recipe 99: Crème Brûlée
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(99, 122, 500, FALSE), (99, 65, 300, FALSE), (99, 54, 100, FALSE),
(99, 64, 10, FALSE);

-- Recipe 106: Pulled Pork
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(106, 18, 2000, FALSE), (106, 47, 30, FALSE), (106, 191, 50, FALSE),
(106, 3, 30, FALSE), (106, 44, 10, FALSE), (106, 185, 200, TRUE);

-- Recipe 108: Mac and Cheese
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(108, 133, 500, FALSE), (108, 26, 300, FALSE), (108, 25, 500, FALSE),
(108, 28, 50, FALSE), (108, 61, 40, FALSE), (108, 34, 100, TRUE);

-- Recipe 109: Clam Chowder
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(109, 272, 500, FALSE), (109, 5, 400, FALSE), (109, 2, 150, FALSE),
(109, 70, 100, FALSE), (109, 29, 300, FALSE), (109, 28, 50, FALSE),
(109, 19, 100, TRUE);

-- Recipe 110: Lobster Roll
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(110, 106, 400, FALSE), (110, 184, 100, FALSE), (110, 70, 50, FALSE),
(110, 14, 30, FALSE), (110, 34, 200, FALSE), (110, 28, 40, FALSE);

-- Recipe 114: Mole Poblano
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(114, 16, 800, FALSE), (114, 170, 20, FALSE), (114, 195, 50, FALSE),
(114, 1, 400, FALSE), (114, 230, 50, FALSE), (114, 40, 50, FALSE),
(114, 160, 20, FALSE), (114, 48, 10, FALSE), (114, 174, 5, FALSE);

-- Recipe 118: Empanadas
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(118, 61, 500, FALSE), (118, 17, 400, FALSE), (118, 2, 150, FALSE),
(118, 65, 100, FALSE), (118, 167, 10, FALSE), (118, 47, 10, FALSE),
(118, 28, 80, FALSE);

-- Recipe 120: Feijoada
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, is_optional) VALUES
(120, 37, 500, FALSE), (120, 18, 400, FALSE), (120, 100, 300, FALSE),
(120, 2, 200, FALSE), (120, 3, 30, FALSE), (120, 175, 3, FALSE),
(120, 13, 100, TRUE);

-- =====================================================
-- RECIPE STEPS (SELECTED RECIPES)
-- =====================================================

-- Recipe 61: Kung Pao Chicken
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(61, 1, 'Cut chicken into cubes and marinate', 15, 'action'),
(61, 2, 'Toast peanuts until fragrant', 5, 'cooking'),
(61, 3, 'Stir-fry chicken in hot wok', 8, 'cooking'),
(61, 4, 'Add vegetables and sauce', 5, 'cooking'),
(61, 5, 'Toss in peanuts and serve', 2, 'action');

-- Recipe 76: Hummus
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(76, 1, 'Blend chickpeas with tahini', 5, 'action'),
(76, 2, 'Add lemon juice and garlic', 2, 'action'),
(76, 3, 'Blend until smooth, adding water if needed', 5, 'action'),
(76, 4, 'Season with cumin and salt', 2, 'action'),
(76, 5, 'Drizzle with olive oil and serve', 1, 'action');

-- Recipe 83: Baklava
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(83, 1, 'Chop nuts and mix with cinnamon', 10, 'action'),
(83, 2, 'Layer phyllo sheets with melted butter', 20, 'action'),
(83, 3, 'Add nut mixture between layers', 15, 'action'),
(83, 4, 'Cut into diamonds and bake at 175°C', 45, 'cooking'),
(83, 5, 'Pour honey syrup over hot baklava', 10, 'action'),
(83, 6, 'Cool completely before serving', 120, 'action');

-- Recipe 91: Risotto Milanese
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(91, 1, 'Steep saffron in warm broth', 10, 'action'),
(91, 2, 'Sauté onion in butter until soft', 5, 'cooking'),
(91, 3, 'Add rice and toast for 2 minutes', 3, 'cooking'),
(91, 4, 'Add saffron broth gradually, stirring constantly', 25, 'cooking'),
(91, 5, 'Stir in butter and parmesan', 3, 'action'),
(91, 6, 'Rest for 2 minutes and serve', 2, 'action');

-- Recipe 99: Crème Brûlée
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(99, 1, 'Heat cream with vanilla until steaming', 10, 'cooking'),
(99, 2, 'Whisk egg yolks with sugar', 5, 'action'),
(99, 3, 'Temper eggs with hot cream', 5, 'action'),
(99, 4, 'Pour into ramekins and bake in water bath at 150°C', 40, 'cooking'),
(99, 5, 'Chill for at least 4 hours', 240, 'action'),
(99, 6, 'Sprinkle sugar on top and caramelize with torch', 3, 'action');

-- Recipe 108: Mac and Cheese
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(108, 1, 'Cook pasta until al dente', 10, 'cooking'),
(108, 2, 'Make cheese sauce with butter, flour, and milk', 10, 'cooking'),
(108, 3, 'Add shredded cheese and stir until melted', 5, 'cooking'),
(108, 4, 'Mix pasta with cheese sauce', 3, 'action'),
(108, 5, 'Top with breadcrumbs and bake at 180°C', 20, 'cooking');

-- Recipe 110: Lobster Roll
INSERT INTO recipe_steps (recipe_id, step_order, description, duration_minutes, step_type) VALUES
(110, 1, 'Cook and chill lobster meat', 15, 'cooking'),
(110, 2, 'Chop lobster into chunks', 5, 'action'),
(110, 3, 'Mix with mayo, celery, and lemon', 5, 'action'),
(110, 4, 'Toast split-top buns with butter', 3, 'cooking'),
(110, 5, 'Fill buns with lobster salad', 2, 'action');

-- =====================================================
-- ADDITIONAL COMPLETED RECIPES
-- =====================================================

INSERT INTO completed_recipes (user_id, recipe_id, rating, comment, completion_date) VALUES
-- More completions for new recipes
(11, 64, 5, 'Sweet and delicious!', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(11, 69, 5, 'Crispy perfection', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(11, 72, 4, 'Great for parties', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(12, 76, 5, 'Creamy hummus!', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(12, 82, 5, 'Authentic shawarma', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(14, 114, 5, 'Complex but worth it!', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(14, 118, 4, 'Family loves these', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(18, 61, 5, 'Spicy and perfect', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(18, 62, 5, 'Authentic mapo tofu', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(18, 65, 4, 'Quick weeknight dinner', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(5, 91, 5, 'Best risotto ever!', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5, 94, 4, 'Crispy and tasty', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(9, 96, 5, 'Classic French comfort', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(6, 99, 5, 'Perfect crème brûlée!', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(7, 106, 5, 'BBQ perfection', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(7, 108, 5, 'Kids absolutely loved it', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(4, 110, 5, 'Better than restaurants', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(1, 79, 4, 'Flaky and delicious', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(15, 88, 5, 'Hearty and warming', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(3, 102, 5, 'Authentic Valencian recipe', DATE_SUB(NOW(), INTERVAL 4 DAY));

SET FOREIGN_KEY_CHECKS = 1;
