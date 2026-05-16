-- =============================================
-- Zomato Analytics Project
-- Create Tables
-- =============================================

DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS restaurants CASCADE;

CREATE TABLE restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    area VARCHAR(50),
    city VARCHAR(50),
    cuisine VARCHAR(50),
    avg_rating DECIMAL(3,2),
    total_votes INTEGER,
    avg_cost_for_two INTEGER,
    restaurant_type VARCHAR(50),
    online_order BOOLEAN
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    restaurant_id INTEGER REFERENCES restaurants(restaurant_id),
    order_date TIMESTAMP,
    delivery_time_mins INTEGER,
    order_amount DECIMAL(10,2),
    order_hour INTEGER
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    restaurant_id INTEGER REFERENCES restaurants(restaurant_id),
    rating DECIMAL(3,2),
    review_date DATE
);
