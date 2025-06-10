
1. Write a query to find the department that has the highest total salary among its employees.

Table: Employees(emp_id, name, department, salary)
| department  | total_salary | 
| Engineering | 245000       | 

-- Solution 
SELECT department, SUM(salary) AS total_salary
FROM Employees
GROUP BY department
ORDER BY total_salary DESC
LIMIT 1


2.Problem:
Find the names and salaries of employees earning more than ₹60,000.
Expected Output:
| name    | salary |
| ------- | ------ |
| Bob     | 80000  |
| Charlie | 75000  |
| Eve     | 90000  |

-- Solution 
SELECT emp_name AS name, salary
FROM Employees
WHERE salary > 60000

3.Problem:
Find all departments that have more than 1 employee and show how many employees they have.
| department  | num\_employees |
| ----------- | -------------- |
| HR          | 2              |
| Engineering | 3              |
| Marketing   | 2              |


-- Solution 
SELECT department, COUNT(*) AS num_employees
FROM Employees
GROUP BY department
HAVING COUNT(*) > 1;



  

