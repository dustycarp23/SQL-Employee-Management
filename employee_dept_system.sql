-- SQL Portfolio Project: Employee & Department Management
-- Description: A relational database system handling HR data, departments, and payroll logic.

-- 1. Create the Department Table (Parent)
CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

-- 2. Create the Employee Table (Child) with Foreign Key
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    hire_date DATE,
    dept_id INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

-- 3. Insert Sample Data: Departments
INSERT INTO department VALUES 
(1, 'IT', 'New York'),
(2, 'HR', 'London'),
(3, 'Sales', 'Tokyo');

-- 4. Insert Sample Data: Employees
INSERT INTO employee VALUES 
(101, 'Alice Johnson', 90000, '2022-01-15', 1, NULL),
(102, 'Bob Smith', 60000, '2022-03-10', 1, 101),
(103, 'Charlie Brown', 55000, '2021-06-25', 2, 101),
(104, 'David Lee', 75000, '2023-01-05', 3, 101);

-- 5. Key Analysis Query: Find average salary per department
SELECT d.dept_name, AVG(e.salary) as avg_salary
FROM employee e
JOIN department d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;