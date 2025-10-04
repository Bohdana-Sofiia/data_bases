DROP DATABASE IF EXISTS Homework_1;
CREATE DATABASE Homework_1;
USE Homework_1;

-- Creating tables
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    department VARCHAR(30),
    manager VARCHAR(50)
);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    budget INT,
    manager VARCHAR(20)
);

CREATE TABLE Teams (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    manager VARCHAR(50),
    specialty VARCHAR(50),
    level INT
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    manager VARCHAR(50),
    price DECIMAL(6,2)
);

CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    category VARCHAR(30),
    assigned_to VARCHAR(30)
);

-- Inserting data
INSERT INTO Teams (manager, specialty, level) VALUES
('manager_1','Data Analytics',10),
('manager_2','Cybersecurity',15),
('manager_3','Web Development',17),
('manager_4','Customer Support',5),
('manager_5','Marketing',9);

INSERT INTO Employees (name, department, manager) VALUES
('Alice','Finance','manager_2'),
('Bob','IT','manager_1'),
('Charlie','HR','manager_3'),
('Diana','Operations','manager_4'),
('Ethan','Marketing','manager_5');

INSERT INTO Projects (name, budget, manager) VALUES
('System Upgrade','100','Charlie'),
('Website Launch','200','manager_1'),
('Security Audit','50','manager_4'),
('Process Automation','150','manager_2'),
('Customer Portal','20','manager_3');

INSERT INTO Products (name, manager, price) VALUES
('Analytics Suite','manager_3',50.00),
('Security Tool','manager_1',75.00),
('HR Platform','manager_4',25.00),
('Workflow Manager','manager_2',30.00),
('Marketing Dashboard','manager_5',40.00);

INSERT INTO Equipment (name, category, assigned_to) VALUES
('Laptop','Electronics','manager_1'),
('Printer','Office','manager_5'),
('Router','Networking','manager_2'),
('Desk','Furniture','manager_5'),
('Phone','Electronics','manager_4'),
('Monitor','Electronics','manager_3'),
('Mouse','Electronics', NULL);

-- Joining 5 tables
SELECT 
    t.manager AS team_head,
    p.name AS team_project,
    e.name AS team_employee,
    pr.name AS team_product,
    eq.name AS team_equipment
FROM Teams t
JOIN Employees e ON e.manager = t.manager
JOIN Projects p ON p.manager = t.manager
JOIN Products pr ON pr.manager = t.manager
JOIN Equipment eq ON eq.assigned_to = t.manager;

-- Using CTE + Where + Order by + Limit
WITH Super_Cool_Teams AS(
	SELECT manager, level
    FROM Teams 
    WHERE level > 8
)

SELECT manager AS whose_team, level
FROM Super_Cool_Teams
ORDER BY level DESC
LIMIT 2;

-- Using subquery + where
SELECT manager, level
FROM Teams
WHERE level > (SELECT AVG(level) FROM Teams); 

-- Group by + having
SELECT assigned_to, COUNT(*) AS equipment_count
FROM Equipment
WHERE assigned_to IS NOT NULL
GROUP BY assigned_to
HAVING COUNT(*) > 1;

-- Union
SELECT name AS company_investments
FROM Products
WHERE price > 0

UNION

SELECT name AS company_investments
FROM Projects
WHERE budget > 0;
