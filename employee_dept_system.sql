/* PROJECT: Employee & Department Management System
   GOAL: Demonstrate comprehensive SQL skills including DDL, DML, Joins, and Aggregates.
   AUTHOR: [Your Name]
*/

-- ==========================================
-- 1. DATABASE OPERATIONS
-- ==========================================
-- Create a new database container
CREATE DATABASE IF NOT EXISTS company_db;

-- Select the database to use
USE company_db;

-- Show all available databases
SHOW DATABASES;

-- ==========================================
-- 2. CREATING TABLES (DDL & CONSTRAINTS)
-- ==========================================

-- Create Department Table (Parent Table)
CREATE TABLE department (
    dept_id INT PRIMARY KEY,          -- Constraint: Primary Key
    dept_name VARCHAR(50) NOT NULL,   -- Constraint: Not Null
    location VARCHAR(50)
);

-- Create Employee Table (Child Table)
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    hire_date DATE,
    dept_id INT,
    manager_id INT,                   -- For Self Join (Who is the boss?)
    FOREIGN KEY (dept_id) REFERENCES department(dept_id) -- Constraint: Foreign Key
);

-- Show the structure of the table
DESCRIBE employee;
-- Show all tables in the database
SHOW TABLES;

-- ==========================================
-- 3. INSERTING DATA (DML)
-- ==========================================

-- Insert into Department
INSERT INTO department (dept_id, dept_name, location) VALUES 
(1, 'IT', 'New York'),
(2, 'HR', 'London'),
(3, 'Sales', 'Tokyo'),
(4, 'Marketing', 'Paris'); -- Marketing has no employees yet (for Right Join)

-- Insert into Employee
INSERT INTO employee (emp_id, name, salary, hire_date, dept_id, manager_id) VALUES 
(101, 'Alice Johnson', 90000, '2022-01-15', 1, NULL),  -- The Boss (No manager)
(102, 'Bob Smith', 60000, '2022-03-10', 1, 101),      -- Reports to Alice
(103, 'Charlie Brown', 55000, '2021-06-25', 2, 101),
(104, 'David Lee', 75000, '2023-01-05', 3, 101),
(105, 'Eve Davis', 82000, '2023-02-20', 1, 102),
(106, 'Frank White', 45000, '2023-11-01', NULL, 103); -- New hire, no dept yet (for Left Join)

-- ==========================================
-- 4. SELECT BASICS & FILTERING
-- ==========================================

-- Select All
SELECT * FROM employee;

-- Select Specific Columns with Aliases
SELECT name AS Employee_Name, salary AS Annual_Salary FROM employee;

-- Select with Condition (WHERE) and Logical Operators (AND, OR, NOT)
SELECT * FROM employee 
WHERE dept_id = 1 AND salary > 70000;

SELECT * FROM employee 
WHERE dept_id = 1 OR dept_id = 2;

SELECT * FROM employee 
WHERE NOT dept_id = 1;

-- Sorting Data (ORDER BY)
SELECT * FROM employee ORDER BY salary DESC; -- Highest to lowest
SELECT * FROM employee ORDER BY name ASC;    -- Alphabetical

-- ==========================================
-- 5. ADVANCED FILTERING (LIKE, IN, BETWEEN, TOP/LIMIT)
-- ==========================================

-- LIKE & Wildcards (Names starting with 'A')
SELECT * FROM employee WHERE name LIKE 'A%';

-- IN (Multiple specific values)
SELECT * FROM employee WHERE dept_id IN (1, 3);

-- BETWEEN (Range)
SELECT * FROM employee WHERE salary BETWEEN 50000 AND 80000;

-- Select Top/Limit (Top 3 highest earners)
SELECT * FROM employee ORDER BY salary DESC LIMIT 3; 
-- Note: Use 'SELECT TOP 3 *' for SQL Server

-- ==========================================
-- 6. AGGREGATE FUNCTIONS & GROUPING
-- ==========================================

-- Basic Aggregates
SELECT 
    COUNT(*) AS Total_Employees,
    SUM(salary) AS Total_Payroll,
    AVG(salary) AS Average_Salary,
    MAX(salary) AS Highest_Paid,
    MIN(salary) AS Lowest_Paid
FROM employee;

-- GROUP BY (Count employees per department)
SELECT dept_id, COUNT(*) AS emp_count 
FROM employee 
GROUP BY dept_id;

-- HAVING (Filter groups: Only depts with avg salary > 60k)
SELECT dept_id, AVG(salary) 
FROM employee 
GROUP BY dept_id 
HAVING AVG(salary) > 60000;

-- ==========================================
-- 7. JOIN QUERIES
-- ==========================================

-- INNER JOIN (Matches in both tables)
SELECT e.name, d.dept_name 
FROM employee e
INNER JOIN department d ON e.dept_id = d.dept_id;

-- LEFT JOIN (All employees, even if no department)
SELECT e.name, d.dept_name 
FROM employee e
LEFT JOIN department d ON e.dept_id = d.dept_id;

-- RIGHT JOIN (All departments, even if no employees)
SELECT e.name, d.dept_name 
FROM employee e
RIGHT JOIN department d ON e.dept_id = d.dept_id;

-- FULL JOIN Simulation (MySQL doesn't support FULL OUTER JOIN natively, use UNION)
SELECT e.name, d.dept_name FROM employee e LEFT JOIN department d ON e.dept_id = d.dept_id
UNION
SELECT e.name, d.dept_name FROM employee e RIGHT JOIN department d ON e.dept_id = d.dept_id;

-- CROSS JOIN (Cartesian product - every row with every row)
SELECT e.name, d.dept_name FROM employee e CROSS JOIN department d;

-- SELF JOIN (Who is the manager?)
SELECT e1.name AS Employee, e2.name AS Manager 
FROM employee e1
JOIN employee e2 ON e1.manager_id = e2.emp_id;

-- ==========================================
-- 8. SUBQUERIES & EXISTS
-- ==========================================

-- EXISTS (Find departments that have employees)
SELECT dept_name FROM department d
WHERE EXISTS (SELECT 1 FROM employee e WHERE e.dept_id = d.dept_id);

-- ==========================================
-- 9. SET OPERATIONS
-- ==========================================

-- UNION (Combine results, remove duplicates)
SELECT dept_id FROM employee
UNION
SELECT dept_id FROM department;

-- ==========================================
-- 10. MODIFYING STRUCTURE & DATA
-- ==========================================

-- UPDATE Table
UPDATE employee SET salary = salary + 5000 WHERE emp_id = 104;

-- ALTER TABLE (Add Column)
ALTER TABLE employee ADD COLUMN email VARCHAR(100);

-- ALTER TABLE (Modify Column)
ALTER TABLE employee MODIFY COLUMN name VARCHAR(150);

-- ALTER TABLE (Drop Column)
ALTER TABLE employee DROP COLUMN email;

-- ==========================================
-- 11. DELETING & CLEANING UP
-- ==========================================

-- DELETE Data (Specific row)
DELETE FROM employee WHERE emp_id = 106;

-- TRUNCATE (Remove all data, keep structure)
-- TRUNCATE TABLE employee; 

-- DROP TABLE (Destroy table entirely)
-- DROP TABLE employee; give me the suitable name for this for github
