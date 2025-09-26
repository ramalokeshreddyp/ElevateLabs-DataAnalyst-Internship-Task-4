# 🗄️ Elevate Labs – Data Analyst Internship (Task 4: SQL for Data Analysis)

## 🎯 Objective
To **use SQL queries** to extract, manipulate, and analyze structured data from an e-commerce database.  
This task helps in practicing **real-world SQL operations** like filtering, aggregations, joins, subqueries, views, query optimization, and advanced analytics.

---

## 🛠 Tools Used
- 🐬 MySQL *(primary tool for database creation & queries)*  
- 🐘 PostgreSQL / 🗄️ SQLite *(can also be used as alternatives)*  
- 📂 Dataset: **Ecommerce SQL Database** (sample dataset created with users, products, orders, and order items)

---

## 🗂 Database Schema
The project uses **4 main tables**:

1. 👤 **Users** – customer info (id, name, email, age, country, registration date)  
2. 📦 **Products** – product catalog (id, name, category, price, cost, stock)  
3. 🛒 **Orders** – order transactions (id, user_id, order_date, total_amount, status, shipping cost)  
4. 📑 **Order Items** – junction table linking orders & products (order_id, product_id, quantity, unit_price)  

---

## 📝 Key Steps Performed

### 🔹 Database Setup
- Created schema with constraints (PK, FK, CHECK, INDEX).  
- Inserted **sample data** for users, products, orders, and order items.  

### 🔹 Core SQL Operations
- `SELECT`, `WHERE`, `ORDER BY` for filtering.  
- Aggregations with `SUM`, `AVG`, `COUNT`, `MIN`, `MAX`.  
- Grouping with `GROUP BY` + filtering using `HAVING`.  

### 🔹 Joins
- `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `CROSS JOIN`, and `SELF JOIN` examples.  
- Combined user, order, and product details.  

### 🔹 Subqueries
- Scalar subqueries  
- Correlated subqueries  
- Nested table subqueries  
- `EXISTS` and `NOT EXISTS` conditions  

### 🔹 Views
- Created a **Customer Summary View** (with total orders, total spent, avg order value, customer tier like *VIP/Regular/Inactive*).  

### 🔹 Query Optimization
- Added **indexes** on `orders(order_date, user_id)` and other frequently queried columns.  
- Used `EXPLAIN` to analyze query performance.  
- Replaced `IN` with `EXISTS` for efficiency.  

### 🔹 Advanced Analysis
- **RFM Analysis** (Recency, Frequency, Monetary) for customer segmentation.  
- **Product Performance Analysis** with revenue, profit, and profit margins.  
- **Monthly Growth Analysis** with percentage growth using `LAG()`.  
- **Geographic Analysis** of revenue and users by country.  
- **Window Functions**: Running totals, moving averages, ranking customers by spending.  

---


## ✅ Outcome
- Built a **complete SQL project** for an e-commerce scenario.  
- Practiced **end-to-end SQL skills**: database design, data cleaning, query writing, optimization, and analytics.  
- Strengthened ability to **analyze structured data** and extract meaningful insights.  
- Prepared for **SQL interview questions** with practical examples.  

---


✨ This project demonstrates strong SQL skills for **real-world business analysis** and serves as a solid foundation for advanced data analytics tasks.  
