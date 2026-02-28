CREATE DATABASE company_data;
USE company_data;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    manager_id INT,
    hire_date DATE
);
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50)
);
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    project_name VARCHAR(50),
    hours_worked INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
INSERT INTO employees (name, department, salary, manager_id, hire_date) VALUES
('Arun', 'IT', 60000, NULL, '2022-01-10'),
('Bala', 'HR', 45000, 1, '2023-02-15'),
('Cathy', 'IT', 70000, 1, '2021-07-20'),
('David', 'Sales', 50000, 2, '2022-03-12'),
('Eva', 'IT', 80000, 1, '2020-05-05');
INSERT INTO projects (emp_id, project_name, hours_worked) VALUES
(1, 'Website', 120),
(1, 'App', 80),
(2, 'Recruitment', 50),
(3, 'System', 200),
(4, 'Marketing', 90),
(5, 'Cloud', 150);
SELECT MAX(salary) FROM employees;
-- second highest slary
SELECT MAX(salary)
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);
-- top three salary 
SELECT * FROM employees
ORDER BY salary DESC
LIMIT 3;
SELECT *
FROM employees
WHERE department = 'IT'
AND salary > 60000;
SELECT *
FROM employees
WHERE name LIKE 'A%'; 
-- group by having
SELECT department, AVG(salary)
FROM employees
GROUP BY department;
SELECT department, AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;  
-- inner joins
SELECT employees.name, projects.project_name
FROM employees
JOIN projects
ON employees.emp_id = projects.emp_id;
-- left join 
SELECT employees.name, projects.project_name
FROM employees
LEFT JOIN projects
ON employees.emp_id = projects.emp_id;
-- self joins
SELECT e1.name AS Employee, e2.name AS Manager
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.emp_id;
-- subquries 
SELECT name, salary
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);
SELECT name
FROM employees
WHERE emp_id IN
(
    SELECT emp_id
    FROM projects
    WHERE hours_worked > 100
);   
SELECT name, salary,
RANK() OVER (ORDER BY salary desc) AS rank_salary
FROM employees; 
SELECT name, department, salary,
RANK() OVER (PARTITION BY department ORDER BY salary DESC )
FROM employees;
SELECT e.name, SUM(p.hours_worked) AS total_hours
FROM employees e
JOIN projects p
ON e.emp_id = p.emp_id
GROUP BY e.name;
SELECT name
FROM employees
WHERE emp_id =
(
    SELECT emp_id
    FROM projects
    GROUP BY emp_id
    ORDER BY SUM(hours_worked) DESC
    LIMIT 1
);
-- stored procedure 
DELIMITER //

CREATE PROCEDURE HighSalary()
BEGIN
    SELECT * FROM employees
    WHERE salary > 60000;
END //

DELIMITER ;
CALL HighSalary();

-- trigger 
CREATE TABLE log_table (
    message VARCHAR(100)
);
DELIMITER //

CREATE TRIGGER after_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
INSERT INTO log_table
VALUES ('New Employee Added');
END //

DELIMITER ;