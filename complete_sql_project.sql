-- =====================================================
-- SQL DATA ANALYSIS PROJECT - COMPLETE SOLUTION
-- Student: [Your Name]
-- Date: [Current Date]
-- Task 4: SQL for Data Analysis - Internship Assignment
-- =====================================================

-- SECTION 1: DATABASE SETUP AND SCHEMA CREATION
-- =====================================================

-- Create the database
CREATE DATABASE IF NOT EXISTS ecommerce_analysis;
USE ecommerce_analysis;

-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

-- Table 1: Users (Customer Information)
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    country VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 18 AND age <= 100)
);

-- Table 2: Products (Product Catalog)
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    cost DECIMAL(10,2) NOT NULL CHECK (cost > 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0)
);

-- Table 3: Orders (Order Transactions)
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    status ENUM('Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Processing',
    shipping_cost DECIMAL(8,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_order_date (order_date),
    INDEX idx_user_id (user_id)
);

-- Table 4: Order Items (Order Line Items - Junction Table)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    INDEX idx_order_id (order_id),
    INDEX idx_product_id (product_id)
);

-- =====================================================
-- SECTION 2: SAMPLE DATA INSERTION
-- =====================================================

-- Insert Users Data
INSERT INTO users (first_name, last_name, email, registration_date, country, age) VALUES
('John', 'Doe', 'john.doe@email.com', '2023-01-15', 'USA', 28),
('Jane', 'Smith', 'jane.smith@email.com', '2023-02-20', 'Canada', 34),
('Mike', 'Johnson', 'mike.johnson@email.com', '2023-03-10', 'USA', 45),
('Sarah', 'Wilson', 'sarah.wilson@email.com', '2023-04-05', 'UK', 29),
('David', 'Brown', 'david.brown@email.com', '2023-05-12', 'Australia', 31),
('Lisa', 'Garcia', 'lisa.garcia@email.com', '2023-06-08', 'Spain', 27),
('Tom', 'Anderson', 'tom.anderson@email.com', '2023-07-22', 'Germany', 38),
('Emma', 'Taylor', 'emma.taylor@email.com', '2023-08-14', 'France', 25),
('Chris', 'Martinez', 'chris.martinez@email.com', '2023-09-03', 'Mexico', 33),
('Anna', 'Davis', 'anna.davis@email.com', '2023-10-18', 'Italy', 30);

-- Insert Products Data
INSERT INTO products (product_name, category, price, cost, stock_quantity) VALUES
('iPhone 14', 'Electronics', 999.99, 650.00, 50),
('Samsung Galaxy S23', 'Electronics', 899.99, 580.00, 45),
('MacBook Pro', 'Electronics', 1999.99, 1300.00, 25),
('Nike Air Max', 'Footwear', 129.99, 65.00, 100),
('Adidas Ultraboost', 'Footwear', 149.99, 75.00, 80),
('Levis Jeans', 'Clothing', 79.99, 35.00, 120),
('H&M T-Shirt', 'Clothing', 19.99, 8.00, 200),
('Sony Headphones', 'Electronics', 299.99, 150.00, 60),
('Coffee Maker', 'Home & Garden', 89.99, 45.00, 40),
('Yoga Mat', 'Sports', 39.99, 20.00, 90),
('Gaming Chair', 'Furniture', 299.99, 180.00, 30),
('Wireless Mouse', 'Electronics', 49.99, 25.00, 150);

-- Insert Orders Data
INSERT INTO orders (user_id, order_date, total_amount, status, shipping_cost) VALUES
(1, '2024-01-15', 1129.98, 'Delivered', 9.99),
(2, '2024-01-20', 899.99, 'Delivered', 0.00),
(3, '2024-02-01', 2299.98, 'Delivered', 19.99),
(1, '2024-02-15', 179.98, 'Delivered', 5.99),
(4, '2024-03-01', 109.98, 'Shipped', 7.99),
(5, '2024-03-10', 459.97, 'Delivered', 12.99),
(6, '2024-03-20', 79.99, 'Delivered', 4.99),
(2, '2024-04-01', 389.98, 'Processing', 8.99),
(7, '2024-04-15', 149.99, 'Delivered', 6.99),
(8, '2024-05-01', 999.99, 'Delivered', 15.99),
(3, '2024-05-10', 349.98, 'Processing', 11.99),
(5, '2024-05-15', 89.99, 'Shipped', 3.99);

-- Insert Order Items Data
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- Order 1: iPhone + Nike shoes
(1, 1, 1, 999.99), (1, 4, 1, 129.99),
-- Order 2: Samsung phone
(2, 2, 1, 899.99),
-- Order 3: MacBook + Headphones
(3, 3, 1, 1999.99), (3, 8, 1, 299.99),
-- Order 4: Multiple small items
(4, 4, 1, 129.99), (4, 10, 1, 39.99), (4, 7, 1, 19.99),
-- Order 5: Jeans + T-shirt + Yoga mat
(5, 6, 1, 79.99), (5, 7, 1, 19.99), (5, 10, 1, 39.99),
-- Order 6: Electronics bundle
(6, 8, 1, 299.99), (6, 9, 1, 89.99),
-- Order 7: Just jeans
(7, 6, 1, 79.99),
-- Order 8: Electronics accessories
(8, 8, 1, 299.99), (8, 12, 1, 49.99),
-- Order 9: Footwear
(9, 5, 1, 149.99),
-- Order 10: iPhone
(10, 1, 1, 999.99),
-- Order 11: Gaming setup
(11, 11, 1, 299.99), (11, 12, 1, 49.99),
-- Order 12: Home item
(12, 9, 1, 89.99);

-- =====================================================
-- SECTION 3: INTERVIEW QUESTIONS WITH DETAILED ANSWERS
-- =====================================================

-- QUESTION 1: What is the difference between WHERE and HAVING?
/*
ANSWER:
WHERE clause:
- Filters individual rows BEFORE grouping
- Cannot use aggregate functions
- Applied to individual records
- Executed before GROUP BY

HAVING clause:
- Filters groups AFTER grouping
- Can use aggregate functions
- Applied to grouped results
- Executed after GROUP BY

Example demonstrating the difference:
*/

-- WHERE example: Filter products before any grouping
SELECT category, product_name, price 
FROM products 
WHERE price > 500;  -- Filters individual products

-- HAVING example: Filter categories after grouping
SELECT category, AVG(price) as avg_price, COUNT(*) as product_count
FROM products 
GROUP BY category
HAVING AVG(price) > 200;  -- Filters grouped results

-- QUESTION 2: What are the different types of joins?
/*
ANSWER:
1. INNER JOIN: Returns only matching records from both tables
2. LEFT JOIN (LEFT OUTER JOIN): Returns all records from left table + matching from right
3. RIGHT JOIN (RIGHT OUTER JOIN): Returns all records from right table + matching from left
4. FULL OUTER JOIN: Returns all records from both tables (not supported in MySQL)
5. CROSS JOIN: Returns Cartesian product of both tables
6. SELF JOIN: Joins a table with itself

Examples below demonstrate each type:
*/

-- INNER JOIN Example
SELECT u.first_name, u.last_name, o.order_date, o.total_amount
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
LIMIT 3;

-- LEFT JOIN Example  
SELECT u.first_name, u.last_name, COUNT(o.order_id) as order_count
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.first_name, u.last_name
LIMIT 5;

-- RIGHT JOIN Example
SELECT u.first_name, o.order_id, o.total_amount
FROM users u
RIGHT JOIN orders o ON u.user_id = o.user_id
LIMIT 3;

-- CROSS JOIN Example (limited for demonstration)
SELECT u.first_name, p.product_name
FROM users u
CROSS JOIN products p
WHERE u.user_id = 1 AND p.product_id <= 2;

-- QUESTION 3: How do you calculate average revenue per user in SQL?
/*
ANSWER: ARPU = Total Revenue / Number of Unique Users
Methods:
1. Simple division of totals
2. Individual user revenue then average
3. Segmented by time period or other dimensions
*/

-- Method 1: Overall ARPU
SELECT 
    ROUND(SUM(total_amount) / COUNT(DISTINCT user_id), 2) as overall_arpu,
    SUM(total_amount) as total_revenue,
    COUNT(DISTINCT user_id) as unique_users
FROM orders;

-- Method 2: ARPU by Country
SELECT 
    u.country,
    ROUND(SUM(o.total_amount) / COUNT(DISTINCT o.user_id), 2) as country_arpu,
    COUNT(DISTINCT o.user_id) as users_count,
    COUNT(o.order_id) as total_orders
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.country
ORDER BY country_arpu DESC;

-- QUESTION 4: What are subqueries?
/*
ANSWER:
Subqueries are queries nested inside another query. Types:
1. Scalar subquery: Returns single value
2. Row subquery: Returns single row  
3. Column subquery: Returns single column
4. Table subquery: Returns multiple rows and columns
5. Correlated subquery: References outer query
6. Non-correlated subquery: Independent of outer query

Uses: SELECT, WHERE, FROM, HAVING clauses
*/

-- Scalar subquery example
SELECT product_name, price,
       (price - (SELECT AVG(price) FROM products)) as price_vs_avg
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Table subquery example
SELECT u.first_name, u.last_name, user_totals.total_spent
FROM users u
JOIN (
    SELECT user_id, SUM(total_amount) as total_spent
    FROM orders
    GROUP BY user_id
    HAVING SUM(total_amount) > 500
) as user_totals ON u.user_id = user_totals.user_id;

-- Correlated subquery example
SELECT p.product_name, p.category, p.price
FROM products p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category = p.category
);

-- QUESTION 5: How do you optimize a SQL query?
/*
ANSWER: Query optimization techniques:
1. Use appropriate indexes
2. Avoid SELECT * - specify needed columns
3. Use WHERE clause to filter early
4. Use appropriate JOIN types
5. Avoid functions in WHERE clause on large datasets
6. Use LIMIT for large result sets
7. Analyze execution plans with EXPLAIN
8. Proper database normalization
9. Use EXISTS instead of IN for subqueries
10. Avoid unnecessary GROUP BY and ORDER BY

Examples of optimization:
*/

-- Create indexes for better performance
CREATE INDEX idx_users_country ON users(country);
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_date_user ON orders(order_date, user_id);

-- Optimized query example
SELECT o.order_id, o.order_date, u.first_name, u.last_name
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
WHERE o.order_date >= '2024-03-01'
  AND o.status = 'Delivered'
  AND u.country IN ('USA', 'Canada')
ORDER BY o.order_date DESC
LIMIT 10;

-- Show execution plan
EXPLAIN SELECT * FROM orders o
JOIN users u ON o.user_id = u.user_id
WHERE u.country = 'USA';

-- QUESTION 6: What is a view in SQL?
/*
ANSWER:
A view is a virtual table based on a SQL query that:
- Doesn't store data physically
- Provides data security and abstraction
- Simplifies complex queries
- Can be used like a regular table
- Updates automatically when underlying data changes
- Can have indexes in some databases

Benefits:
- Security (hide sensitive columns)
- Simplification (complex joins)
- Consistency (standardized queries)
*/

-- Create a customer summary view
CREATE VIEW customer_summary AS
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.country,
    u.registration_date,
    COUNT(o.order_id) as total_orders,
    COALESCE(SUM(o.total_amount), 0) as total_spent,
    COALESCE(AVG(o.total_amount), 0) as avg_order_value,
    MAX(o.order_date) as last_order_date,
    CASE 
        WHEN SUM(o.total_amount) > 1000 THEN 'VIP'
        WHEN SUM(o.total_amount) > 500 THEN 'Regular'
        WHEN COUNT(o.order_id) > 0 THEN 'Basic'
        ELSE 'Inactive'
    END as customer_tier
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.email, u.country, u.registration_date;

-- Use the view
SELECT * FROM customer_summary 
WHERE customer_tier IN ('VIP', 'Regular')
ORDER BY total_spent DESC;

-- QUESTION 7: How would you handle null values in SQL?
/*
ANSWER: NULL handling techniques:
1. IS NULL / IS NOT NULL for checking
2. COALESCE() for providing default values
3. IFNULL() or ISNULL() functions (MySQL/SQL Server)
4. CASE statements for complex logic
5. NULL-safe equality operator <=> (MySQL)
6. Consider NULL behavior in aggregate functions
7. Use NULLIF() to convert values to NULL
*/

-- Demonstrate NULL handling
-- Add some NULL data for demonstration
INSERT INTO users (first_name, last_name, email, registration_date, country, age) 
VALUES ('Test', 'User', 'test@email.com', '2024-01-01', 'Unknown', NULL);

-- Various NULL handling techniques
SELECT 
    first_name,
    last_name,
    age,
    COALESCE(age, 25) as age_with_default,
    IFNULL(age, 'Age Not Provided') as age_display,
    CASE 
        WHEN age IS NULL THEN 'Age Unknown'
        WHEN age < 30 THEN 'Young'
        WHEN age >= 30 THEN 'Mature'
    END as age_group,
    NULLIF(country, 'Unknown') as cleaned_country
FROM users
WHERE user_id >= 10;

-- Clean up test data
DELETE FROM users WHERE email = 'test@email.com';

-- =====================================================
-- SECTION 4: BASIC SQL OPERATIONS
-- =====================================================

-- 4.1 SELECT with WHERE and ORDER BY
SELECT user_id, first_name, last_name, email, country, age
FROM users 
WHERE age > 30 
ORDER BY registration_date DESC;

-- 4.2 SELECT with multiple conditions
SELECT product_name, category, price, stock_quantity
FROM products 
WHERE category IN ('Electronics', 'Footwear') 
  AND price BETWEEN 100 AND 1000
ORDER BY category, price DESC;

-- 4.3 Pattern matching with LIKE
SELECT first_name, last_name, email
FROM users 
WHERE first_name LIKE 'J%' 
   OR email LIKE '%.smith@%';

-- 4.4 Date range queries
SELECT order_id, user_id, order_date, total_amount, status
FROM orders 
WHERE order_date BETWEEN '2024-02-01' AND '2024-04-30'
ORDER BY order_date;

-- =====================================================
-- SECTION 5: GROUP BY AND AGGREGATE FUNCTIONS
-- =====================================================

-- 5.1 Basic GROUP BY with COUNT
SELECT country, COUNT(*) as user_count
FROM users 
GROUP BY country
ORDER BY user_count DESC;

-- 5.2 Sales summary by category
SELECT 
    p.category,
    COUNT(DISTINCT p.product_id) as products_count,
    COUNT(oi.order_item_id) as items_sold,
    SUM(oi.quantity) as total_quantity,
    SUM(oi.quantity * oi.unit_price) as total_revenue,
    AVG(oi.unit_price) as avg_price,
    MIN(oi.unit_price) as min_price,
    MAX(oi.unit_price) as max_price
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 5.3 Monthly sales analysis
SELECT 
    YEAR(order_date) as order_year,
    MONTH(order_date) as order_month,
    MONTHNAME(order_date) as month_name,
    COUNT(order_id) as total_orders,
    SUM(total_amount) as monthly_revenue,
    AVG(total_amount) as avg_order_value,
    SUM(shipping_cost) as total_shipping
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date), MONTHNAME(order_date)
ORDER BY order_year, order_month;

-- 5.4 Customer order frequency
SELECT 
    CASE 
        WHEN COUNT(order_id) = 1 THEN 'One-time buyer'
        WHEN COUNT(order_id) = 2 THEN 'Repeat buyer'
        WHEN COUNT(order_id) >= 3 THEN 'Loyal customer'
    END as customer_type,
    COUNT(*) as customers_count,
    AVG(total_spent) as avg_spent_per_customer
FROM (
    SELECT user_id, COUNT(order_id) as order_count, SUM(total_amount) as total_spent
    FROM orders
    GROUP BY user_id
) as customer_stats
GROUP BY customer_type;

-- =====================================================
-- SECTION 6: JOIN OPERATIONS
-- =====================================================

-- 6.1 INNER JOIN - Orders with customer details
SELECT 
    o.order_id,
    u.first_name,
    u.last_name,
    u.country,
    o.order_date,
    o.total_amount,
    o.status
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
WHERE o.status = 'Delivered'
ORDER BY o.total_amount DESC;

-- 6.2 LEFT JOIN - All users with order statistics
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.country,
    u.registration_date,
    COUNT(o.order_id) as order_count,
    COALESCE(SUM(o.total_amount), 0) as total_spent,
    COALESCE(MAX(o.order_date), 'Never') as last_order_date
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.country, u.registration_date
ORDER BY total_spent DESC;

-- 6.3 Multiple table JOIN - Complete order details
SELECT 
    o.order_id,
    o.order_date,
    u.first_name,
    u.last_name,
    u.country,
    p.product_name,
    p.category,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) as line_total
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
ORDER BY o.order_id, p.product_name;

-- 6.4 Self JOIN example - Users from same country
SELECT 
    u1.first_name as user1_name,
    u2.first_name as user2_name,
    u1.country
FROM users u1
INNER JOIN users u2 ON u1.country = u2.country 
WHERE u1.user_id < u2.user_id
ORDER BY u1.country;

-- =====================================================
-- SECTION 7: SUBQUERIES
-- =====================================================

-- 7.1 Scalar subquery - Products above average price
SELECT 
    product_name,
    category,
    price,
    ROUND(price - (SELECT AVG(price) FROM products), 2) as price_diff_from_avg
FROM products
WHERE price > (SELECT AVG(price) FROM products)
ORDER BY price DESC;

-- 7.2 Correlated subquery - Best selling product per category
SELECT 
    p.category,
    p.product_name,
    p.price,
    COALESCE(category_sales.total_sold, 0) as total_sold
FROM products p
LEFT JOIN (
    SELECT 
        p2.product_id,
        SUM(oi.quantity) as total_sold
    FROM products p2
    LEFT JOIN order_items oi ON p2.product_id = oi.product_id
    GROUP BY p2.product_id
) category_sales ON p.product_id = category_sales.product_id
WHERE category_sales.total_sold = (
    SELECT MAX(product_totals.total_sold)
    FROM (
        SELECT 
            p3.product_id,
            COALESCE(SUM(oi2.quantity), 0) as total_sold
        FROM products p3
        LEFT JOIN order_items oi2 ON p3.product_id = oi2.product_id
        WHERE p3.category = p.category
        GROUP BY p3.product_id
    ) product_totals
) OR (category_sales.total_sold IS NULL AND NOT EXISTS (
    SELECT 1 FROM order_items oi3 
    JOIN products p4 ON oi3.product_id = p4.product_id 
    WHERE p4.category = p.category
))
ORDER BY p.category;

-- 7.3 EXISTS subquery - Users who have placed orders
SELECT u.first_name, u.last_name, u.country
FROM users u
WHERE EXISTS (
    SELECT 1 FROM orders o 
    WHERE o.user_id = u.user_id 
    AND o.status = 'Delivered'
);

-- 7.4 NOT EXISTS subquery - Users who haven't placed orders
SELECT u.first_name, u.last_name, u.country, u.registration_date
FROM users u
WHERE NOT EXISTS (
    SELECT 1 FROM orders o 
    WHERE o.user_id = u.user_id
);

-- =====================================================
-- SECTION 8: ADVANCED ANALYSIS QUERIES
-- =====================================================

-- 8.1 Customer Segmentation using RFM Analysis
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    rfm.recency_days,
    rfm.frequency,
    rfm.monetary,
    CASE 
        WHEN rfm.monetary > 1500 AND rfm.frequency > 2 THEN 'Champions'
        WHEN rfm.monetary > 1000 AND rfm.frequency > 1 THEN 'Loyal Customers'
        WHEN rfm.recency_days <= 30 AND rfm.monetary > 500 THEN 'Potential Loyalists'
        WHEN rfm.recency_days <= 60 THEN 'New Customers'
        WHEN rfm.recency_days > 90 THEN 'At Risk'
        ELSE 'Regular Customers'
    END as customer_segment
FROM users u
JOIN (
    SELECT 
        user_id,
        DATEDIFF(CURDATE(), MAX(order_date)) as recency_days,
        COUNT(order_id) as frequency,
        SUM(total_amount) as monetary
    FROM orders
    GROUP BY user_id
) rfm ON u.user_id = rfm.user_id
ORDER BY rfm.monetary DESC;

-- 8.2 Product Performance Analysis
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.cost,
    COALESCE(sales.total_quantity, 0) as units_sold,
    COALESCE(sales.total_revenue, 0) as revenue,
    COALESCE(sales.total_orders, 0) as orders_count,
    ROUND((p.price - p.cost) * COALESCE(sales.total_quantity, 0), 2) as profit,
    ROUND(((p.price - p.cost) / p.price) * 100, 2) as profit_margin_percent,
    CASE 
        WHEN COALESCE(sales.total_quantity, 0) = 0 THEN 'No Sales'
        WHEN sales.total_quantity >= 2 THEN 'Best Seller'
        WHEN sales.total_quantity = 1 THEN 'Regular'
    END as performance_category
FROM products p
LEFT JOIN (
    SELECT 
        product_id,
        SUM(quantity) as total_quantity,
        SUM(quantity * unit_price) as total_revenue,
        COUNT(DISTINCT order_id) as total_orders
    FROM order_items
    GROUP BY product_id
) sales ON p.product_id = sales.product_id
ORDER BY revenue DESC, units_sold DESC;

-- 8.3 Monthly Growth Analysis
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') as month,
    COUNT(order_id) as monthly_orders,
    SUM(total_amount) as monthly_revenue,
    AVG(total_amount) as avg_order_value,
    LAG(SUM(total_amount)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) as prev_month_revenue,
    ROUND(
        CASE 
            WHEN LAG(SUM(total_amount)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) IS NULL THEN NULL
            ELSE ((SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m'))) 
                  / LAG(SUM(total_amount)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m'))) * 100
        END, 2
    ) as growth_rate_percent
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 8.4 Geographic Analysis
SELECT 
    u.country,
    COUNT(DISTINCT u.user_id) as total_users,
    COUNT(o.order_id) as total_orders,
    ROUND(COUNT(o.order_id) / COUNT(DISTINCT u.user_id), 2) as orders_per_user,
    SUM(o.total_amount) as total_revenue,
    ROUND(SUM(o.total_amount) / COUNT(DISTINCT u.user_id), 2) as revenue_per_user,
    ROUND(AVG(o.total_amount), 2) as avg_order_value,
    SUM(o.shipping_cost) as total_shipping_costs
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.country
ORDER BY total_revenue DESC;

-- =====================================================
-- SECTION 9: WINDOW FUNCTIONS AND ADVANCED ANALYTICS
-- =====================================================

-- 9.1 Running totals and moving averages
SELECT 
    order_date,
    total_amount,
    SUM(total_amount) OVER (ORDER BY order_date) as running_total,
    AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as moving_avg_3orders,
    ROW_NUMBER() OVER (ORDER BY total_amount DESC) as revenue_rank,
    DENSE_RANK() OVER (ORDER BY DATE(order_date)) as date_rank
FROM orders
ORDER BY order_date;

-- 9.2 Customer ranking by spending
SELECT 
    u.first_name,
    u.last_name,
    u.country,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) as spending_rank,
    DENSE_RANK() OVER (PARTITION BY u.country ORDER BY total_spent DESC) as country_rank,
    NTILE(4) OVER (ORDER BY total_spent DESC) as spending_quartile
FROM users u
JOIN (