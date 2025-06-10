| Constraint Type     | Description                                                                      |
| ------------------- | -------------------------------------------------------------------------------- |
| `PRIMARY KEY`       | Ensures each record is uniquely identified                                       |
| `NOT NULL`          | Prevents missing values                                                          |
| `UNIQUE`            | Prevents duplicate values in a column (or set of columns)                        |
| `CHECK`             | Enforces a rule on acceptable values (e.g., salary >= 0, status in allowed list) |
| `FOREIGN KEY`       | Ensures referential integrity between tables                                     |
| `ON DELETE CASCADE` | Deletes dependent rows when the referenced parent row is deleted                 |
| `DEFAULT`           | Provides a default value if none is given                                        |


-- Drop existing tables if they exist
DROP TABLE IF EXISTS Assignments CASCADE;
DROP TABLE IF EXISTS Employees CASCADE;
DROP TABLE IF EXISTS Projects CASCADE;

-- Employees Table
CREATE TABLE Employees (
    emp_id SERIAL PRIMARY KEY,                           -- Unique ID with auto-increment
    emp_name VARCHAR(50) NOT NULL,                       -- Name cannot be NULL
    department VARCHAR(50) NOT NULL,                     -- Department cannot be NULL
    salary INT NOT NULL CHECK (salary >= 0)              -- Salary must be non-negative
);

-- Projects Table
CREATE TABLE Projects (
    project_id SERIAL PRIMARY KEY,                       -- Unique Project ID
    project_name VARCHAR(100) NOT NULL UNIQUE            -- Name must be unique and not NULL
);

-- Assignments Table
CREATE TABLE Assignments (
    assignment_id SERIAL PRIMARY KEY,                    -- Unique Assignment ID
    emp_id INT NOT NULL,                                 -- Must reference an existing employee
    project_id INT NOT NULL,                             -- Must reference an existing project
    assignment_date DATE DEFAULT CURRENT_DATE,           -- Optional: when the assignment was made
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'completed', 'on_hold')), -- Optional status check
    
    -- Foreign key constraints with cascading delete
    CONSTRAINT fk_emp FOREIGN KEY (emp_id) REFERENCES Employees(emp_id) ON DELETE CASCADE,
    CONSTRAINT fk_proj FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,

    -- These two lines define foreign key relationships:

    -- emp_id in the Assignments table must exist in the Employees table.
    -- project_id in the Assignments table must exist in the Projects table.

    -- The part ON DELETE CASCADE means:
    -- If an employee or project is deleted from the Employees or Projects table, any assignment related to that employee/project in the Assignments table will also be automatically deleted.
    -- A particular employee can be assigned to a specific project only once.

  
    
    -- Unique constraint to prevent duplicate assignments
    CONSTRAINT unique_assignment UNIQUE (emp_id, project_id)
);
