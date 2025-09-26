-- =====================================================
-- SQL DATA ANALYSIS PROJECT - ECOMMERCE CASE
-- Task 4: SQL for Data Analysis - Internship Assignment
-- =====================================================

-- 1️⃣ DATABASE & TABLES SETUP
CREATE DATABASE IF NOT EXISTS ecommerce_analysis;
USE ecommerce_analysis;

-- Drop tables if already exist
DROP TABLE IF EXISTS order_items, orders, products, users;

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    country VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 18 AND age <= 100)
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    cost DECIMAL(10,2) NOT NULL CHECK (cost > 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    status ENUM('Processing','Shipped','Delivered','Cancelled') DEFAULT 'Processing',
    shipping_cost DECIMAL(8,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_order_date (order_date),
    INDEX idx_user_id (user_id)
);

-- Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- =====================================================
-- 2️⃣ SAMPLE DATA INSERTION
-- =====================================================

-- Users
INSERT INTO users (first_name,last_name,email,registration_date,country,age) VALUES
('John','Doe','john.doe@email.com','2023-01-15','USA',28),
('Jane','Smith','jane.smith@email.com','2023-02-20','Canada',34),
('Mike','Johnson','mike.johnson@email.com','2023-03-10','USA',45);

-- Products
INSERT INTO products (product_name,category,price,cost,stock_quantity) VALUES
('iPhone 14','Electronics',999.99,650.00,50),
('Nike Air Max','Footwear',129.99,65.00,100),
('Levis Jeans','Clothing',79.99,35.00,120);

-- Orders
INSERT INTO orders (user_id,order_date,total_amount,status,shipping_cost) VALUES
(1,'2024-01-15',1129.98,'Delivered',9.99),
(2,'2024-02-01',129.99,'Shipped',5.99),
(3,'2024-02-15',79.99,'Delivered',3.99);

-- Order Items
INSERT INTO order_items (order_id,product_id,quantity,unit_price) VALUES
(1,1,1,999.99),(1,2,1,129.99),
(2,2,1,129.99),
(3,3,1,79.99);

-- =====================================================
-- 3️⃣ EXAMPLE ANALYSIS QUERIES
-- =====================================================

-- Total Revenue
SELECT SUM(total_amount) AS total_revenue FROM orders;

-- Average Revenue Per User (ARPU)
SELECT ROUND(SUM(total_amount)/COUNT(DISTINCT user_id),2) AS avg_revenue_per_user 
FROM orders;

-- Orders per Country
SELECT u.country, COUNT(o.order_id) AS total_orders, SUM(o.total_amount) AS revenue
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.country;

-- Top Products by Revenue
SELECT p.product_name, SUM(oi.quantity*oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- Customer Segmentation (VIP if spent > 1000)
SELECT u.first_name, u.last_name, SUM(o.total_amount) AS total_spent,
       CASE WHEN SUM(o.total_amount) > 1000 THEN 'VIP' ELSE 'Regular' END AS customer_type
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id;
