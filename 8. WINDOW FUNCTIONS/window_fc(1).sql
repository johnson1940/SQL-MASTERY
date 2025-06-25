SELECT * FROM employee;


-- Finding the max salary by dept using aggregate function

SELECT dept_name, MAX(salary) as max_salary
FROM employee
GROUP BY dept_name



-- Using WINDOW function

-- For each record it will create an window 
SELECT e.*,
MAX(salary) OVER() as max_salary
FROM employee e;

-- For each dept it will create an window 
SELECT e.*,
MAX(salary) OVER(PARTITION BY dept_name) as max_salary
FROM employee e;




-- ROW_NUMBER 
/* ROW_NUMBER() is a window function that assigns a unique sequential number to each row within a result set,
based on the order you specify.
*/

SELECT e.*,
ROW_NUMBER() OVER(PARTITION BY dept_name) as rn
FROM employee e;

-- Fetch the firt 1 employee from each department to join the company
SELECT * FROM
     (SELECT e.*,
     ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY emp_id) as rn
     FROM employee e) x
WHERE x.rn < 2;	 




	 
-- RANK

/*RANK() is a window function that assigns a rank (position)
to each row within a partition based on the ordering of one or more columns.

If there are ties (duplicate values), it assigns the same rank, 
and then skips the next ranks.

DENSE RANK - Doesn't skip a value for the duplicate
*/



SELECT e.*,
RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) as rnk
FROM employee e;

-- Fetching the top 3 employees in each department earning the max salary

SELECT * FROM
      (SELECT e.*,
      RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) as rnk
      FROM employee e) x
WHERE x.rnk < 4;


-- rank, dense_rank and row_number
SELECT e.*,
RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) as rnk,
DENSE_RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) as DENSE_rnk,
ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY salary DESC) as row_no
FROM employee e;


-- LAG
-- Fetch a query to display if the salary of an employee is higher 
-- lower or equal to the previous employee


SELECT e.*,
LAG(salary) OVER (PARTITION BY dept_name ORDER BY emp_id) as prev_emp_salary,
LEAD(salary) OVER (PARTITION BY dept_name ORDER BY emp_id) as next_emp_salary
FROM employee e;

-- use case
SELECT e.*,
LAG(salary) OVER (PARTITION BY dept_name ORDER BY emp_id) as prev_emp_salary,
CASE WHEN e.salary > LAG(salary) OVER (PARTITION BY dept_name ORDER BY emp_id) THEN 'Higher than previous emp'
     WHEN e.salary < LAG(salary) OVER (PARTITION BY dept_name ORDER BY emp_id) THEN 'Lower than previous emp'
	 WHEN e.salary = LAG(salary) OVER (PARTITION BY dept_name ORDER BY emp_id) THEN 'Same than previous emp'    
     END sal_range
FROM employee e;


