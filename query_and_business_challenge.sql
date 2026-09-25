CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    customer_type VARCHAR(30)
);

select * from customers

INSERT INTO customers (customer_name, city, customer_type)
VALUES
('Ada Stores', 'Lagos', 'Retail'),
('Bright Technologies', 'Abuja', 'Corporate'),
('Chika Ventures', 'Lagos', 'Retail'),
('David Enterprises', 'Kano', 'Corporate'),
('Elite Supermarket', 'Port Harcourt', 'Retail'),
('Favour Collections', 'Ibadan', 'Retail'),
('Grace Foods', 'Lagos', 'Corporate');

drop table customers

---PRODUCTS TABLE--------

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price NUMERIC(10,2),
    stock_quantity INT
);


INSERT INTO products (
    product_name,
    category,
    unit_price,
    stock_quantity
)
VALUES
('Laptop', 'Electronics', 850000, 15),
('Smartphone', 'Electronics', 350000, 30),
('Office Chair', 'Furniture', 120000, 20),
('Office Desk', 'Furniture', 180000, 12),
('Printer', 'Electronics', 250000, 10),
('Air Conditioner', 'Appliances', 400000, 8),
('Generator', 'Appliances', 600000, 6),
('Projector', 'Electronics', 300000, 5);


CREATE TABLE employees(
employee_id SERIAL PRIMARY KEY, 
employee_name VARCHAR(100) NOT NULL, 
job_title VARCHAR(50),
manager_id INT,
FOREIGN KEY(manager_id) REFERENCES employees(employee_id)
)

-- employeeid 	name 	managerid
-- 1			John	null 
-- 2			James	1

INSERT INTO employees(
	employee_name, job_title, manager_id
)
Values('John Okafor', 'Sales Manager', NULL),
('Mary James', 'Sales Manager', NULL)

INSERT INTO employees(
	employee_name, job_title, manager_id
)
VALUES 
('Peter Eneche', 'Sales Rep', 1),
('Mathew Hindu', 'Sales Rep', 1),
('Shade Olawole', 'Sales Rep', 2),
('Bruno Fernadez', 'Sales Rep', 2);

select * from employees


---- ORDERS TABLE --------
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    order_status VARCHAR(30),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

select * from orders

INSERT INTO orders (
    customer_id,
    employee_id,
    order_date,
    order_status
)
VALUES
(1, 3, '2026-08-01', 'Completed'),
(2, 4, '2026-08-02', 'Completed'),
(3, 3, '2026-08-03', 'Pending'),
(1, 5, '2026-08-05', 'Completed'),
(4, 6, '2026-08-06', 'Completed'),
(5, 4, '2026-08-08', 'Pending'),
(2, 3, '2026-08-10', 'Completed'),
(3, 6, '2026-08-12', 'Cancelled'),
(1, 4, '2026-08-15', 'Completed');

select * from orders

----ORDER ITEMS ------
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price NUMERIC(10,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


INSERT INTO order_items (
    order_id,
    product_id,
    quantity,
    unit_price
)
VALUES
(1, 1, 1, 850000),
(1, 2, 2, 350000),

(2, 3, 5, 120000),
(2, 4, 2, 180000),

(3, 2, 1, 350000),

(4, 5, 1, 250000),
(4, 2, 1, 350000),

(5, 6, 2, 400000),
(5, 7, 1, 600000),

(6, 3, 3, 120000),

(7, 1, 2, 850000),
(7, 5, 1, 250000),

(8, 2, 2, 350000),

(9, 4, 1, 180000),
(9, 6, 1, 400000);



-- ============================================================
-- ASSIGNMENT TASKS
-- ============================================================

-- Task 1: Completed orders by Corporate customers
SELECT 
    c.customer_name, 
    o.order_id, 
    o.order_date, 
    o.order_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_type = 'Corporate' 
  AND o.order_status = 'Completed';


-- Task 2: All Retail customers from Lagos and their orders (including those without orders)
SELECT 
    c.customer_name, 
    c.city, 
    c.customer_type, 
    o.order_id, 
    o.order_date, 
    o.order_status
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE c.customer_type = 'Retail' 
  AND c.city = 'Lagos';


-- Task 3: Employees who have handled at least one Pending order
SELECT DISTINCT 
    e.employee_name, 
    e.job_title
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
WHERE o.order_status = 'Pending';


-- Task 4: Products with stock_quantity < 10 that have appeared in at least one order
SELECT DISTINCT 
    p.product_id, 
    p.product_name, 
    p.stock_quantity
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
WHERE p.stock_quantity < 10;


-- Task 5: Product details for all Completed orders
SELECT 
    c.customer_name,
    e.employee_name,
    p.product_name,
    oi.quantity,
    (oi.quantity * oi.unit_price) AS total_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN employees e ON o.employee_id = e.employee_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed';


-- Task 6: Customers whose total quantity of products purchased is > 2

SELECT 
    c.customer_name, 
    SUM(oi.quantity) AS total_quantity_purchased
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(oi.quantity) > 2;


-- Task 7: Employees whose total sales value is greater than average employee sales
SELECT 
    e.employee_name, 
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY e.employee_id, e.employee_name
HAVING SUM(oi.quantity * oi.unit_price) > (
    SELECT AVG(emp_sales)
    FROM (
        SELECT SUM(oi2.quantity * oi2.unit_price) AS emp_sales
        FROM employees e2
        JOIN orders o2 ON e2.employee_id = o2.employee_id
        JOIN order_items oi2 ON o2.order_id = oi2.order_id
        GROUP BY e2.employee_id
    ) sub
);


-- Task 8: Products with price greater than the Office Desk
SELECT 
    product_name, 
    category, 
    unit_price
FROM products
WHERE unit_price > (
    SELECT unit_price 
    FROM products 
    WHERE product_name = 'Office Desk'
);


-- Task 9: Customers with a Completed order but NO Cancelled order
SELECT c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.customer_id 
      AND o.order_status = 'Completed'
) 
AND NOT EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.customer_id 
      AND o.order_status = 'Cancelled'
);


-- Task 10: Products purchased by customers located in Lagos

SELECT DISTINCT 
    p.product_id, 
    p.product_name, 
    p.category
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.city = 'Lagos';


-- Task 11: Employees who have handled orders for more than one different customer

SELECT 
    e.employee_name, 
    COUNT(DISTINCT o.customer_id) AS number_of_customers
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.employee_name
HAVING COUNT(DISTINCT o.customer_id) > 1;


-- Task 12: Customers whose number of orders is greater than the average per customer
SELECT 
    c.customer_name, 
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > (
    SELECT COUNT(order_id)::DECIMAL / COUNT(DISTINCT customer_id)
    FROM orders
);


-- Task 13: Products whose stock is greater than average in their category
SELECT 
    p1.product_name, 
    p1.category, 
    p1.stock_quantity
FROM products p1
WHERE p1.stock_quantity > (
    SELECT AVG(p2.stock_quantity)
    FROM products p2
    WHERE p2.category = p1.category
);


-- Task 14: Customers who purchased at least one product from Electronics

SELECT c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1 
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE o.customer_id = c.customer_id 
      AND p.category = 'Electronics'
);


-- Task 15: Employees who have never handled a Cancelled order

SELECT e.employee_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.employee_id = e.employee_id 
      AND o.order_status = 'Cancelled'
);


-- Task 16: Orders whose total value is greater than the average order value

WITH order_totals AS (
    SELECT 
        o.order_id, 
        c.customer_name, 
        SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, c.customer_name
)
SELECT order_id, customer_name, order_value
FROM order_totals
WHERE order_value > (SELECT AVG(order_value) FROM order_totals);


-- Task 17: Product(s) purchased in the highest total quantity

SELECT 
    p.product_name, 
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) = (
    SELECT MAX(total_qty)
    FROM (
        SELECT SUM(quantity) AS total_qty
        FROM order_items
        GROUP BY product_id
    ) sub
);


-- Task 18: Customers who purchased products from more than one product category
SELECT 
    c.customer_name, 
    COUNT(DISTINCT p.category) AS number_of_categories
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT p.category) > 1;


-- Task 19: Customers whose total spending > average spending of spending customers

WITH customer_spending AS (
    SELECT 
        c.customer_name, 
        SUM(oi.quantity * oi.unit_price) AS Total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name, Total_spent
FROM customer_spending
WHERE Total_spent > (SELECT AVG(Total_spent) FROM customer_spending)
ORDER BY Total_spent DESC;


-- ============================================================
-- FINAL BUSINESS CHALLENGE QUERIES
-- ============================================================

-- Q1: Category with highest total revenue
SELECT 
    p.category, 
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC
LIMIT 1;

-- Q2: Employee who handled highest number of completed orders
SELECT 
    e.employee_name, 
    COUNT(o.order_id) AS completed_orders_count
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
WHERE o.order_status = 'Completed'
GROUP BY e.employee_id, e.employee_name
ORDER BY completed_orders_count DESC
LIMIT 1;

-- Q3: City that generated highest total sales value
SELECT 
    c.city, 
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.city
ORDER BY total_sales DESC
LIMIT 1;

-- Q4: Customer who bought the largest total number of items

SELECT 
    c.customer_name, 
    SUM(oi.quantity) AS total_items
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_items DESC
LIMIT 1;

-- Q5: Products purchased by more than one different customer

SELECT 
    p.product_name, 
    COUNT(DISTINCT o.customer_id) AS distinct_customer_count
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(DISTINCT o.customer_id) > 1;




























