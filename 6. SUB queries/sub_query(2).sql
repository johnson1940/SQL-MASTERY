CREATE TABLE store_products (
    store_id INTEGER,
    store_name VARCHAR(50),
    product_name VARCHAR(50),
    quantity INTEGER,
    price INTEGER
);


INSERT INTO store_products (store_id, store_name, product_name, quantity, price) VALUES
(1, 'Apple Store 1', 'iPhone 13 Pro', 1, 1000),
(1, 'Apple Store 1', 'MacBook pro 14', 3, 6000),
(1, 'Apple Store 1', 'AirPods Pro', 2, 500),
(2, 'Apple Store 2', 'iPhone 13 Pro', 2, 2000),
(3, 'Apple Store 3', 'iPhone 12 Pro', 1, 750),
(3, 'Apple Store 3', 'MacBook pro 14', 1, 2000),
(3, 'Apple Store 3', 'i pad gen3', 1, 2500),
(4, 'Apple Store 4', 'iPhone 12 Pro', 1, 850),
(4, 'Apple Store 4', 'MacBook pro 14', 1, 1500),
(4, 'Apple Store 4', 'i pad gen3', 1, 2500);

ALTER TABLE store_products RENAME TO sales;

-- Nested Subquery -> Query inside another query

/*  Find Stores who's sales whether better than the average sales acorss all the stores
1. Find the total sales for each stores
2. Find the avg sales for all the stores
3. compare 1 AND 2
*/

-- Finding the average for each stores
SELECT store_name, sum(price)
FROM sales
GROUP BY store_name;

-- Nested subquery
SELECT *
FROM (SELECT store_name, sum(price) as total_sales
      FROM sales
	  GROUP BY store_name) sales
JOIN (SELECT AVG(total_sales) as sales
      FROM (SELECT store_name, sum(price) as total_sales
	  FROM sales
	  GROUP BY store_name) x) avg_sales
   ON sales.total_sales > avg_sales.sales;	  

-- Since we are duplicating the same query multiple times
-- Its time for us to use with cause
-- WITH CLAUSE also called Common Table Expression (CTE)
-- used to define a temporary result
-- Instead of writing the repeated query we used with clause

WITH sales AS 
     (SELECT store_name, sum(price) as total_sales
	  FROM sales
	  GROUP BY store_name)
SELECT *
FROM sales
JOIN (SELECT AVG(total_sales) as sales
      FROM sales x) avg_sales
	  ON sales.total_sales > avg_sales.sales;
	  
-- we can use subqueries 
1. SELECT 
2. FROM
3. WHERE
4. HAVING


-- Using subquery in SELECT clause 
-- But its not an recommended way 
-- Fetch all employee details and add remarks to those employees who earn more than the average salary

SELECT *,
(CASE WHEN salary > (SELECT AVG(salary) FROM employee)
           then 'Higher than average'
		   else 'lower than average'
END) as remarks 
FROM employee;

-- alternative way 

SELECT *,
(CASE WHEN salary > avg_sal.sal
           then 'Higher than average'
		   else 'lower than average'
END) as remarks 
FROM employee
CROSS JOIN (SELECT AVG(salary) sal FROM employee) avg_sal;


-- HAVING CLAUSE 
-- Find the stores who have sold more units than the avearge units sold by all the stores

SELECT store_name, sum(quantity)
FROM sales
GROUP BY store_name
HAVING sum(quantity) > (SELECT AVG(quantity) FROM sales);

