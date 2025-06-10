DROP TABLE department CASCADE;
DROP TABLE manager CASCADE;
DROP TABLE employee CASCADE;
DROP TABLE project CASCADE;

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


SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM manager;
SELECT * FROM project;

-- Fetch the employee name and the department name they belong to.

-- Inner join / JOIN
-- An INNER JOIN is a type of SQL join that returns only the rows that have matching values in both tables.
SELECT e.emp_name , d.dept_name
FROM employee e INNER JOIN department d on e.dept_id = d.dept_id

-- LEFT JOIN - Inner Join + any additional record in the left table
SELECT e.emp_name , d.dept_name
FROM employee e LEFT JOIN department d on e.dept_id = d.dept_id

-- RIGHT JOIN - Inner Join + any additional record in the right table
SELECT e.emp_name , d.dept_name
FROM employee e RIGHT JOIN department d on e.dept_id = d.dept_id

-- Fetch details of all emp, their manager, their department and the project they work on.
SELECT e.emp_name, d.dept_name, m.manager_name, p.project_name
FROM employee e
LEFT JOIN department d on e.dept_id = d.dept_id
INNER JOIN manager m on m.manager_id = e.manager_id
LEFT JOIN project p on p.team_member_id = e.emp_id;
