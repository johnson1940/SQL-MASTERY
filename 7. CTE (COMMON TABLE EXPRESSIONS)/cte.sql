-- It's a temporary result set that you can refer to within a SELECT, INSERT, UPDATE, or DELETE statement.

SELECT * FROM employee;

-- Fetch employees who earn more than the average salary of all employees

WITH average_salary (avg_sal) as
     (SELECT CAST(avg(salary) as INT) FROM employee)
SELECT *
FROM employee e, average_salary av
WHERE e.salary > av.avg_sal;

-- Or we can use like this way

WITH average_salary AS 
     (SELECT CAST(AVG(salary) AS INT)
	  AS avg_sal FROM employee)
SELECT *
FROM employee e, average_salary av
WHERE e.salary > av.avg_sal


-- WITHOUT WITH CLAUSE

SELECT * FROM sales;

-- Find stores who's sales where better than the average sales accorss all stores
1. Total sales per each store -- Total_sales

SELECT s.store_id, SUM(price) as total_sales_per_store
FROM sales s
GROUP BY s.store_id;

2. Find the average sales with respect to all the stores - Avg_sales

SELECT avg(total_sales_per_store) as avg_sales_for_all_stores
FROM (SELECT s.store_id, SUM(price) as total_sales_per_store
      FROM sales s
      GROUP BY s.store_id) x;

3. Find the stores where Total_sales > avg_sales of all stores

SELECT *
FROM (SELECT s.store_id, SUM(price) as total_sales_per_store
      FROM sales s 
      GROUP BY s.store_id) total_sales

JOIN (SELECT avg(total_sales_per_store) as avg_sales_for_all_stores
     FROM(
      SELECT s.store_id, SUM(price) as total_sales_per_store
      FROM sales s
      GROUP BY s.store_id) x) avg_sales
ON total_sales.total_sales_per_store > avg_sales.avg_sales_for_all_stores;
	  

/* Drawbacks 
1. Nested query - Complex query
2. Not clean
3. Not understandable by other programmers
*/

-- Now using the with clause
WITH Total_Sales (store_id, total_sales_per_store) as
         (SELECT s.store_id, sum(price) as total_sales_per_store
		 FROM sales s
		 GROUP BY s.store_id),
     avg_sales (avg_sales_for_all_stores) as
	     (SELECT AVG(total_sales_per_store) AS avg_sales_for_all_stores
		  FROM Total_Sales)
SELECT *
FROM Total_Sales ts
JOIN avg_sales av
ON ts.total_sales_per_store > av.avg_sales_for_all_stores


/* Advantages 
1. More readable 
2. Maintable 
3. Easier to debug 
4. Improve in perfomance - Because as soon it is executed it will create an temp tables


when to use with clause?
1. Even trying to write a same query multiple times
2. For complex query -> into smaller 
3. TO improve perfomance -> For example if we have millions of data and we are interested
only on the 1000 records by filtering so it will make the filtering faster so this result 
can be used.
