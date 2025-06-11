-- FULL JOIN — Combines the results of INNER JOIN, LEFT JOIN, and RIGHT JOIN. 
-- Returns all records from both tables; fills with NULL where there is no match.

-- CROSS JOIN — Joins two tables without any relationship or condition. 
-- Returns the Cartesian product (all possible combinations of rows).

-- NATURAL JOIN — Automatically joins tables based on columns with the same name in both tables.

-- SELF JOIN — Joins a table with itself. Useful for comparing rows within the same table.


DROP TABLE department CASCADE;
DROP TABLE manager CASCADE;
DROP TABLE employee CASCADE;
DROP TABLE project CASCADE;
DROP TABLE company CASCADE;

CREATE TABLE department (
    dept_id VARCHAR(10) PRIMARY KEY,
    dept_name VARCHAR(100)
);


CREATE TABLE manager (
    manager_id VARCHAR(10) PRIMARY KEY,
    manager_name VARCHAR(100) NOT NULL,
    dept_id VARCHAR(10) NOT NULL
    -- FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);
CREATE TABLE employee (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    salary NUMERIC(10, 2) NOT NULL,
    dept_id VARCHAR(10) NOT NULL,
    manager_id VARCHAR(10)
    -- FOREIGN KEY (dept_id) REFERENCES department(dept_id),
    -- FOREIGN KEY (manager_id) REFERENCES manager(manager_id)
);

CREATE TABLE project (
    project_id VARCHAR(10) PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    team_member_id VARCHAR(10) NOT NULL
    -- FOREIGN KEY (team_member_id) REFERENCES employee(emp_id)
);

CREATE TABLE company (
    company_name VARCHAR(100) NOT NULL,
	location_name VARCHAR(50) NOT NULL
);


CREATE TABLE family (
    member_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    parent_id VARCHAR(10)
);

-- Insert departments
INSERT INTO department (dept_id, dept_name) VALUES
('D1', 'Engineering'),
('D2', 'Human Resources'),
('D3', 'Marketing'),
('D4', 'Accounts');

-- Insert managers
INSERT INTO manager (manager_id, manager_name, dept_id) VALUES
('M1', 'Alice Johnson', 'D1'),
('M2', 'Bob Smith', 'D2'),
('M3', 'Charlie Brown', 'D3');

-- Insert employees
INSERT INTO employee (emp_id, emp_name, salary, dept_id, manager_id) VALUES
('E1', 'David Thomas', 60000.00, 'D1', 'M1'),
('E2', 'Eva Green', 55000.00, 'D2', 'M2'),
('E3', 'Frank Lee', 62000.00, 'D1', 'M1'),
('E4', 'Grace Kim', 58000.00, 'D3', 'M3'),
('E5', 'Joe Daniel', 78000.00, 'D1', 'M1'),
('E6', 'Christy cathy', 88000.00, 'D2', 'M2'),
('E7', 'Sam Jim', 99000.00, 'D5', 'M1'),
('E8', 'Rly Hion', 10000.00, 'D5', 'M2');

-- Insert projects
INSERT INTO project (project_id, project_name, team_member_id) VALUES
('P1', 'Apollo', 'E1'),
('P2', 'Hera', 'E3'),
('P3', 'Zeus', 'E4');

-- Insert family
INSERT INTO family (member_id, name, age, parent_id) VALUES
('P01', 'Alice', 60, NULL),       -- Root
('P02', 'Bob', 62, NULL),         -- Root
('P03', 'Charlie', 35, 'P01'),    -- Child of Alice
('P04', 'Daisy', 33, 'P01'),      -- Child of Alice
('P05', 'Evan', 38, 'P02'),       -- Child of Bob
('P06', 'Fiona', 10, 'P03'),      -- Child of Charlie
('P07', 'George', 8, 'P03'),      -- Child of Charlie
('P08', 'Hannah', 5, 'P04'),      -- Child of Daisy
('P09', 'Ian', 3, 'P05'),         -- Child of Evan
('P10', 'Julia', 1, 'P05');       -- Child of Evan



-- Insert Company
INSERT INTO company (company_name, location_name) VALUES
('Data Tech crops', 'Coimbatore')

SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM manager;
SELECT * FROM project;
SELECT * FROM family;
-- Fetch the employee name and the department name they belong to.

-- Full Join = Inner Join 
--                + all remaining records from Left Table (returns null value on the right table)
--                + all remaining records from Right Table (returns null value on the left table)
SELECT e.emp_name, d.dept_name
FROM employee e
FULL JOIN department d on d.dept_id = e.dept_id;

-- CROSS JOIN
-- CROSS JOIN returns Cartesian product

SELECT e.emp_name, d.dept_name
FROM employee e
CROSS JOIN department d;

-- write a query to fetch the employee name and their corresponding departnment name
-- Also make sure to display the companu name and the company location corresponsing to each employeee
-- Use case - If you wanna join the table that has no relationship you can use cross join
-- Company table doesn't have relationship with either employee or department table
SELECT e.emp_name, d.dept_name, c.company_name, c.location_name
FROM employee e
JOIN department d ON e.dept_id = d.dept_id
CROSS JOIN company c


-- NATURAL JOIN
-- Like cross join we will not give the 'ON' condition
-- The SQL itself make decision to join the table based on the column_name
-- IF the column name varies then it would disastrous
SELECT e.emp_name, d.dept_name
FROM employee e
NATURAL JOIN department d;

ALTER TABLE department RENAME COLUMN dept_id to id;


-- SELF JOIN
-- Helpful when you wanna join the same table
SELECT child.name as child_name,
child.age as child_age,
parent.name as parent_name,
parent.age as parent_age 
FROM family as child
JOIN family as parent ON child.parent_id = parent.member_id;
