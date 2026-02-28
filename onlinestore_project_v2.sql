-- Online Store Management System
-- A simple SQL project simulating a small online shop database
-- Created for practice and learning purposes

-- Create database
CREATE DATABASE IF NOT EXISTS onlinestore;
USE onlinestore;

-- ===========================
-- Customers Table
-- ===========================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50)
);

-- ===========================
-- Categories Table
-- ===========================
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50)
);

-- ===========================
-- Products Table
-- ===========================
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- ===========================
-- Orders Table
-- ===========================
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ===========================
-- Order Details Table
-- ===========================
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ===========================
-- Payments Table
-- ===========================
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- ===========================
-- Insert Categories
-- ===========================
INSERT INTO categories (category_name) VALUES
('Electronics'),
('Accessories'),
('Home'),
('Books');

-- ===========================
-- Insert Customers
-- ===========================
INSERT INTO customers (name, email, city) VALUES
('Arun', 'arun@gmail.com', 'Chennai'),
('Bala', 'bala@gmail.com', 'Madurai'),
('Cathy', 'cathy@gmail.com', 'Coimbatore'),
('David', 'david@gmail.com', 'Salem'),
('Eva', 'eva@gmail.com', 'Trichy'),
('Farhan', 'farhan@gmail.com', 'Chennai'),
('Gokul', 'gokul@gmail.com', 'Erode'),
('Hari', 'hari@gmail.com', 'Vellore');

-- ===========================
-- Insert Products
-- ===========================
INSERT INTO products (product_name, price, stock, category_id) VALUES
('Laptop', 55000, 8, 1),
('Smartphone', 22000, 15, 1),
('Headphones', 2000, 40, 2),
('Keyboard', 1500, 25, 2),
('Mouse', 800, 30, 2),
('Chair', 3500, 10, 3),
('Table Lamp', 1200, 12, 3),
('Novel Book', 500, 20, 4),
('Notebook', 100, 100, 4),
('Monitor', 12000, 6, 1);

-- ===========================
-- Insert Orders
-- ===========================
INSERT INTO orders (customer_id, order_date) VALUES
(1, '2026-02-01'),
(2, '2026-02-02'),
(3, '2026-02-03'),
(1, '2026-02-05'),
(4, '2026-02-06'),
(5, '2026-02-07'),
(6, '2026-02-08'),
(7, '2026-02-09');

-- ===========================
-- Insert Order Details
-- ===========================
INSERT INTO order_details (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(2, 5, 1),
(3, 4, 1),
(3, 8, 2),
(4, 6, 1),
(5, 7, 1),
(6, 9, 5),
(7, 10, 1),
(8, 3, 2);

-- ===========================
-- Insert Payments
-- ===========================
INSERT INTO payments (order_id, amount, payment_date) VALUES
(1, 59000, '2026-02-01'),
(2, 22800, '2026-02-02'),
(3, 2500, '2026-02-03'),
(4, 3500, '2026-02-05'),
(5, 1200, '2026-02-06'),
(6, 500, '2026-02-07'),
(7, 12000, '2026-02-08'),
(8, 4000, '2026-02-09');

-- ===========================
-- Basic Queries
-- ===========================

-- View all customers
SELECT * FROM customers;

-- View all products
SELECT * FROM products;

-- View all orders
SELECT * FROM orders;

-- ===========================
-- Join Queries
-- ===========================

-- Customer Orders
SELECT c.name, o.order_id, o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- Product Sales
SELECT p.product_name, od.quantity
FROM products p
JOIN order_details od ON p.product_id = od.product_id;

-- Orders with Payment
SELECT o.order_id, p.amount
FROM orders o
JOIN payments p ON o.order_id = p.order_id;

-- ===========================
-- Aggregate Queries
-- ===========================

-- Total Sales
SELECT SUM(amount) AS total_sales
FROM payments;

-- Number of Orders per Customer
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;

-- Low Stock Products
SELECT product_name, stock
FROM products
WHERE stock < 10;

-- Best Selling Products
SELECT product_id, SUM(quantity) AS total_sold
FROM order_details
GROUP BY product_id
ORDER BY total_sold DESC;

-- Monthly Orders
SELECT MONTH(order_date) AS month, COUNT(*) AS total_orders
FROM orders
GROUP BY MONTH(order_date);

-- End of Project
