DROP DATABASE IF EXISTS Homework_1;
CREATE DATABASE homework_1;
USE homework_1;
 
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    hire_date DATE
);

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Projects (
    proj_id INT PRIMARY KEY,
    proj_name VARCHAR(50),
    dept_id INT,
    budget DECIMAL(10,2)
);

CREATE TABLE Equipment (
    equip_id INT PRIMARY KEY,
    equip_name VARCHAR(50),
    emp_id INT,
    purchase_date DATE
);

CREATE TABLE Salaries (
    emp_id INT PRIMARY KEY,
    salary DECIMAL(10,2),
    bonus DECIMAL(10,2)
);

INSERT INTO Employees (emp_id, name, dept_id, hire_date) VALUES
(1, 'Alice', 1, '2020-01-15'),
(2, 'Bob', 2, '2019-03-22'),
(3, 'Charlie', 1, '2021-07-10'),
(4, 'David', 3, '2018-11-05'),
(5, 'Eva', 2, '2022-05-30'),
(6, 'Frank', 4, '2020-09-12'),
(7, 'Grace', 5, '2021-12-01');

INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');

INSERT INTO Projects (proj_id, proj_name, dept_id, budget) VALUES
(1, 'Website Upgrade', 1, 50000),
(2, 'Recruitment Drive', 2, 20000),
(3, 'Audit 2023', 3, 15000),
(4, 'Marketing Campaign', 4, 30000),
(5, 'Product Launch', 5, 40000);

INSERT INTO Equipment (equip_id, equip_name, emp_id, purchase_date) VALUES
(1, 'Laptop', 1, '2020-02-01'),
(2, 'Phone', 2, '2019-04-01'),
(3, 'Monitor', 3, '2021-08-01'),
(4, 'Tablet', 4, '2018-12-01'),
(5, 'Laptop', 5, '2022-06-01'),
(6, 'Printer', 6, '2020-10-01'),
(7, 'Headset', 7, '2022-01-01');

INSERT INTO Salaries (emp_id, salary, bonus) VALUES
(1, 60000, 5000),
(2, 55000, 3000),
(3, 62000, 4000),
(4, 58000, 3500),
(5, 50000, 2000),
(6, 53000, 2500),
(7, 57000, 3000);


WITH DeptBudget AS (
    SELECT d.dept_id, d.dept_name, SUM(p.budget) AS total_budget
    FROM Departments d
    JOIN Projects p ON d.dept_id = p.dept_id
    GROUP BY d.dept_id, d.dept_name
    HAVING SUM(p.budget) > 10000   
)

SELECT e.name AS empolee_name,
       d.dept_name,
       p.proj_name,
       eq.equip_name,
       s.salary,
       db.total_budget,
       'Rich' AS category
FROM Employees e
JOIN Salaries s ON e.emp_id = s.emp_id
JOIN Departments d ON e.dept_id = d.dept_id
JOIN Projects p ON d.dept_id = p.dept_id
JOIN Equipment eq ON e.emp_id = eq.emp_id
JOIN DeptBudget db ON d.dept_id = db.dept_id
WHERE s.salary > (SELECT AVG(salary) FROM Salaries) 

UNION

SELECT e.name AS empolee_name,
       d.dept_name,
       p.proj_name,
       eq.equip_name,
       s.salary,
       db.total_budget,
       'Poor' AS category
FROM Employees e
JOIN Salaries s ON e.emp_id = s.emp_id
JOIN Departments d ON e.dept_id = d.dept_id
JOIN Projects p ON d.dept_id = p.dept_id
JOIN Equipment eq ON e.emp_id = eq.emp_id
JOIN DeptBudget db ON d.dept_id = db.dept_id
WHERE s.salary < (SELECT AVG(salary) FROM Salaries)

ORDER BY salary DESC
LIMIT 5;
