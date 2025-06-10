| Function                    | Description                                            | Example                                     |
| --------------------------- | ------------------------------------------------------ | ------------------------------------------- |
| **COUNT()**                 | Counts the number of rows                              | `SELECT COUNT(*) FROM Employees;`           |
| **SUM()**                   | Returns the total sum of a numeric column              | `SELECT SUM(salary) FROM Employees;`        |
| **AVG()**                   | Returns the average value of a numeric column          | `SELECT AVG(salary) FROM Employees;`        |
| **MIN()**                   | Returns the smallest value                             | `SELECT MIN(salary) FROM Employees;`        |
| **MAX()**                   | Returns the largest value                              | `SELECT MAX(salary) FROM Employees;`        |
| **GROUP\_CONCAT()** (MySQL) | Concatenates values from multiple rows into one string | `SELECT GROUP_CONCAT(name) FROM Employees;` |

-- Avg salary based on the departments
SELECT department, AVG(salary)
FROM Employees
GROUP BY department;

SELECT SUM(salary) AS total_salary FROM Employees;

SELECT COUNT(*) AS total_employees FROM Employees;

SELECT MAX(salary) AS highest_salary FROM Employees;

SELECT MIN(salary) AS lowest_salary FROM Employees;

SELECT AVG(salary) AS average_salary FROM Employees;

-- Number of Employees in Each Department
SELECT department, COUNT(*) AS employee_count
FROM Employees
GROUP BY department;

-- Total Salary Spent per Department
SELECT department, SUM(salary) AS department_salary
FROM Employees
GROUP BY department;

-- Departments with More than 5 employees
SELECT department, COUNT(*) AS employee_count
FROM Employees
GROUP BY department
HAVING COUNT(*) > 2;

-- Average Salary per Department, Sorted by Highest Avg
SELECT department, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department
ORDER BY avg_salary DESC

-- Projects with Most Employees Assigned (Example with JOIN)
SELECT project_id, COUNT(emp_id) AS assigned_employees
FROM Assignments
GROUP BY project_id
ORDER BY assigned_employees DESC;
