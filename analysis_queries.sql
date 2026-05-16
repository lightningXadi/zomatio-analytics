-- =============================================
-- Zomato Analytics Project - Analysis Queries
-- Author: Your Name
-- =============================================

-- -----------------------------------------------
-- ANALYSIS 1: Top Rated Restaurants by Cuisine
-- Concepts: WHERE, ORDER BY, GROUP BY, RANK()
-- -----------------------------------------------
SELECT
    cuisine,
    name,
    area,
    avg_rating,
    total_votes,
    RANK() OVER (PARTITION BY cuisine ORDER BY avg_rating DESC) AS rank_in_cuisine
FROM restaurants
WHERE total_votes > 100
ORDER BY cuisine, rank_in_cuisine;


-- -----------------------------------------------
-- ANALYSIS 2: Peak Order Hours
-- Concepts: GROUP BY, HAVING, COUNT
-- -----------------------------------------------
SELECT
    order_hour,
    COUNT(*) AS total_orders,
    ROUND(AVG(order_amount), 2) AS avg_order_value,
    CASE
        WHEN order_hour BETWEEN 7 AND 10 THEN 'Breakfast'
        WHEN order_hour BETWEEN 11 AND 14 THEN 'Lunch'
        WHEN order_hour BETWEEN 15 AND 17 THEN 'Snacks'
        WHEN order_hour BETWEEN 18 AND 22 THEN 'Dinner'
        ELSE 'Late Night'
    END AS meal_period
FROM orders
GROUP BY order_hour
HAVING COUNT(*) > 10
ORDER BY total_orders DESC;


-- -----------------------------------------------
-- ANALYSIS 3: Avg Delivery Time by Restaurant Type
-- Concepts: JOIN, AVG, GROUP BY, ORDER BY
-- -----------------------------------------------
SELECT
    r.restaurant_type,
    COUNT(DISTINCT r.restaurant_id) AS total_restaurants,
    ROUND(AVG(o.delivery_time_mins), 2) AS avg_delivery_time,
    ROUND(AVG(o.order_amount), 2) AS avg_order_value
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_type
ORDER BY avg_delivery_time ASC;


-- -----------------------------------------------
-- ANALYSIS 4: Restaurant Rankings with Window Functions
-- Concepts: DENSE_RANK(), PARTITION BY, Window FN
-- -----------------------------------------------
SELECT
    name,
    area,
    cuisine,
    avg_rating,
    total_votes,
    avg_cost_for_two,
    DENSE_RANK() OVER (ORDER BY avg_rating DESC) AS overall_rank,
    DENSE_RANK() OVER (PARTITION BY cuisine ORDER BY avg_rating DESC) AS cuisine_rank,
    DENSE_RANK() OVER (PARTITION BY area ORDER BY avg_rating DESC) AS area_rank
FROM restaurants
WHERE total_votes > 50
ORDER BY overall_rank;


-- -----------------------------------------------
-- BONUS: Top Areas by Average Rating
-- -----------------------------------------------
SELECT
    area,
    COUNT(*) AS total_restaurants,
    ROUND(AVG(avg_rating), 2) AS avg_area_rating,
    MAX(avg_rating) AS best_rating,
    SUM(total_votes) AS total_votes
FROM restaurants
GROUP BY area
HAVING COUNT(*) >= 5
ORDER BY avg_area_rating DESC
LIMIT 15;
