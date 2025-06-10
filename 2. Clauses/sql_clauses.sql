DROP TABLE IF EXISTS Employees CASCADE 

CREATE TABLE Employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

-- Insert sample data
INSERT INTO Employees (emp_name, department, salary) VALUES
('Alice', 'HR', 50000),
('Bob', 'Engineering', 80000),
('Charlie', 'Engineering', 75000),
('David', 'Marketing', 60000),
('Eve', 'Engineering', 90000),
('Frank', 'HR', 55000),
('Grace', 'Marketing', 62000);

-- WHERE CLAUSE

-- Filters rows before they are are grouped or processed
-- When you want to retrieve specific rows that match conditions.
-- Ex: Filter by age, department, salary etc

SELECT * FROM Employees
WHERE Salary > 70000;

-- ORDER BY CLAUSE

-- Sorts the result set by one or more columns, ascending (ASC) or descending (DESC).
-- When you want results sorted by name, date, salary, etc.

SELECT * FROM Employees
ORDER BY salary DESC

-- GROUP BY Clause

-- 	Groups rows that have the same value in specified columns into summary rows.
-- When you use aggregate functions (SUM, COUNT, AVG) 
-- to get totals or averages grouped by a field (like department).

SELECT department, SUM(salary) AS total_salary
FROM Employees
GROUP BY department;

-- HAVING Clause

-- Filters groups (after GROUP BY is applied), not individual rows.
-- When you want to filter grouped results by some condition
-- (e.g., groups with count > 1, total > 1000).

SELECT department, SUM(salary) AS total_salary
FROM Employees
GROUP BY department
HAVING sum(salary) > 120000;

-- LIMIT Clause

-- Limits the number of rows returned. PostgreSQL supports this natively.
-- When you only want the top N rows of a result 
-- (e.g., top 5 students, latest 10 transactions).

SELECT * FROM Employees
ORDER BY salary DESC
LIMIT 3;





