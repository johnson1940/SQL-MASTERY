CREATE TABLE employee (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(100),
    dept_name VARCHAR(100),
    salary DECIMAL(10, 2)
);

CREATE TABLE department (
    dept_id VARCHAR(10) PRIMARY KEY,
    dept_name VARCHAR(100),
    location VARCHAR(100)
);

INSERT INTO employee (emp_id, emp_name, dept_name, salary)
VALUES 
('emp1', 'Alice Johnson', 'IT', 72000.00),
('emp2', 'Bob Smith', 'HR', 65000.00),
('emp3', 'Charlie Lee', 'Finance', 78000.00),
('emp4', 'Diana King', 'IT', 81000.00),
('emp5', 'Ethan Patel', 'Marketing', 60000.00),
('emp6', 'Fiona Grace', 'HR', 67000.00),
('emp7', 'George White', 'IT', 75000.00),
('emp8', 'Hannah Brown', 'Finance', 82000.00),
('emp9', 'Isaac Wong', 'IT', 73000.00),
('emp10', 'Julia Green', 'Marketing', 64000.00);


INSERT INTO department (dept_id, dept_name, location)
VALUES 
('D1', 'IT', 'New York'),
('D2', 'HR', 'Chicago'),
('D3', 'Finance', 'San Francisco'),
('D4', 'Marketing', 'Los Angeles'),
('D5', 'Operations', 'Houston');


SELECT * FROM employee;
SELECT * FROM department;
-- SUB query - QUery Inside another query

/* QUESTION: Find the employee who's salary is more than the average salary
earned by all employee 
1. Find the avg salary
2. Filter the employees based on the above result.
*/

SELECT AVG(salary) FROM employee;

SELECT *    -- outer query / Main query
FROM employee 
WHERE salary > (SELECT AVG(salary) FROM employees); -- subquery / Inner Query


-- Scalar subquery
-- It always returns 1 row and 1 column
SELECT e.*
FROM employee e
JOIN (SELECT AVG(salary) sal FROM employee) avg_sal
      ON e.salary > avg_sal.sal;

-- multiple row subquery
-- subquery which return multiple column and multiple row
-- subquery which return only 1 column and multiple rows.

SELECT *
FROM employee
WHERE (dept_name, salary) IN (SELECT dept_name, max(salary)
                              FROM employee
                              GROUP BY dept_name);

-- single column, multiple row subquery
/* QUESTION: Find department who do not have any employee */

SELECT *
FROM department
WHERE dept_name NOT IN (SELECT DISTINCT dept_name FROM employee);


-- Correlated subquery 

							  
