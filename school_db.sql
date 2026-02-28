CREATE DATABASE company;
USE company;
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2),
    department VARCHAR(50)
);
INSERT INTO employees (id, name, salary, department)
VALUES
(1, 'Sibi', 50000, 'IT'),
(2, 'Arun', 40000, 'HR'),
(3, 'Kumar', 45000, 'Sales'),
(4, 'Ravi', 47000, 'IT'),
(5, 'Priya', 52000, 'HR'),
(6, 'Meena', 48000, 'Finance'),
(7, 'John', 60000, 'IT'),
(8, 'Asha', 39000, 'Support'),
(9, 'Vijay', 55000, 'Marketing'),
(10, 'Divya', 42000, 'HR');
SELECT * FROM employees;
CREATE TABLE date_example (
    date_col DATE,
    time_col TIME,
    datetime_col DATETIME,
    timestamp_col TIMESTAMP,
    year_col YEAR
);
INSERT INTO date_example VALUES
('2026-02-11',
 '14:30:00',
 '2026-02-11 14:30:00',
 NOW(),
 2026);
SELECT * FROM date_example;
SELECT * FROM employees;   
show tables ;
describe date_example;
create database stddata;
use stddata;
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    marks INT
);
DESCRIBE students;
INSERT INTO students VALUES (1, 'Arun', 20, 85);
INSERT INTO students VALUES (2, 'Bala', 21, 90);
INSERT INTO students VALUES (3, 'Cathy', 19, 75);
SELECT * FROM students;
  
 -- select queries with multiple methods
SELECT name FROM students;
SELECT * FROM students WHERE age > 20;
SELECT * FROM students WHERE marks >= 80;
  SELECT * FROM students ORDER BY marks DESC;
  SELECT * FROM students LIMIT 2;
  DELETE FROM students
WHERE id = 3;
SELECT * FROM students
WHERE marks BETWEEN 70 AND 90;
SELECT * FROM students
WHERE age < 21 AND marks > 80;
SELECT * FROM students
WHERE age > 21 or marks > 80;
SELECT * FROM students
WHERE age IN (19, 21);
SELECT * FROM students
WHERE name LIKE '%A';
SELECT * FROM students
WHERE name LIKE 'A%';
SELECT COUNT(*) FROM students;
SELECT MAX(marks) FROM students;
SELECT MIN(marks) FROM students;
SELECT AVG(marks) FROM students;
SELECT SUM(marks) FROM students;
SELECT age, COUNT(*)
FROM students
GROUP BY age;
-- joins
CREATE TABLE courses (
    student_id INT ,
    course VARCHAR(50)
);
alter table courses 
add primary key (student_id);
SELECT student_id, COUNT(*)
FROM courses
GROUP BY student_id
HAVING COUNT(*) > 1;
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course VARCHAR(50)
);
drop table courses;
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course VARCHAR(50)
);
INSERT INTO courses (student_id, course) VALUES (1, 'Java');
INSERT INTO courses (student_id, course) VALUES (2, 'Python');
INSERT INTO courses (student_id, course) VALUES (1, 'SQL');
select * from  students;
select * from courses;
SELECT students.name, courses.course
FROM students
INNER JOIN courses
ON students.id = courses.student_id;
SELECT name
FROM students
WHERE marks = (
    SELECT MAX(marks) FROM students
);
CREATE VIEW top_students AS
SELECT name, marks
FROM students
WHERE marks > 80;
SELECT * FROM top_students;