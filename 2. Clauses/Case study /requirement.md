# Case Study: TechCorp Employee & Project Management

## Background

TechCorp is a fast-growing software company with multiple departments and various ongoing projects. Each employee belongs to a department and may work on multiple projects.

As the Data Analyst for TechCorp, you’ve been asked to generate reports to help with HR decisions, budgeting, and resource allocation.

## 1. Employee Table

| Column     | Type        | Description                |
| ---------- | ----------- | -------------------------- |
| emp\_id    | SERIAL (PK) | Unique employee ID         |
| name       | VARCHAR     | Name of the employee       |
| department | VARCHAR     | Department of the employee |
| salary     | INT         | Monthly salary (in ₹)      |

## 2. Project Table

| Column        | Type        | Description         |
| ------------- | ----------- | ------------------- |
| project\_id   | SERIAL (PK) | Unique project ID   |
| project\_name | VARCHAR     | Name of the project |

## 3. Assignments Table (Many-to-Many Relationship)

| Column         | Type        | Description            |
| -------------- | ----------- | ---------------------- |
| assignment\_id | SERIAL (PK) | Unique assignment ID   |
| emp\_id        | INT (FK)    | References `Employees` |
| project\_id    | INT (FK)    | References `Projects`  |

## Business Requirements (Problems to Solve)

### 1. Employee Distribution

**Find the total number of employees in each department.**

> **Why?** To see which departments are growing the fastest.
> SELECT department, COUNT(*) AS num_employees
FROM Employees
GROUP BY department;

### 2. Budget Planning

**Show the total monthly salary paid per department, in descending order.**

> **Why?** Helps plan department-wise budgets.

### 3. Key Contributors

**List the top 3 highest-paid employees.**

> **Why?** To identify key contributors and top earners.

### 4. Popular Projects

**Show each project along with the number of employees assigned to it.**

> **Why?** To understand project staffing levels.

### 5. Active Departments

**Find departments with more than 2 employees.**

> **Why?** Helps in resource planning for team leads.

### 6. Project Staffing

**List names of employees working on the project ‘Website Redesign’.**

> **Why?** For project team introductions and communication.

## Expected Outcomes

| Report                | Helps In                    |
| --------------------- | --------------------------- |
| Employee Distribution | HR Planning                 |
| Department Budgets    | Finance                     |
| Top Earners           | Performance/Retention Plans |
| Popular Projects      | Resource Allocation         |

## Extensions (For Advanced Practice)

* Calculate average salary per department.
* Show projects with NO employees assigned.
* JOIN with a new Departments table for richer analysis.
* Add a date field to Assignments and write time-based queries.
