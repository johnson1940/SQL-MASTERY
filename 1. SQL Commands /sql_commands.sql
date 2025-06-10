| **Type** | **Commands Covered**          |
| -------- | ----------------------------- |
| **DDL**  | CREATE, ALTER, DROP, TRUNCATE |
| **DML**  | INSERT, UPDATE, DELETE        |
| **DQL**  | SELECT, JOIN                  |
| **TCL**  | BEGIN, COMMIT, ROLLBACK       |
| **DCL**  | GRANT, REVOKE                 |

  
-- Create Students Table
DROP TABLE IF EXISTS Students CASCADE;
DROP TABLE IF EXISTS Courses CASCADE;
DROP TABLE IF EXISTS Enrollments CASCADE;

CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    email VARCHAR(100)
);

-- Create Courses Table
CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credits INT NOT NULL
);

-- Create Enrollments Table (Many-to-Many Relationship)
CREATE TABLE Enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES Students(student_id),
    course_id INT REFERENCES Courses(course_id),
    enrollment_date DATE DEFAULT CURRENT_DATE
);



-- Insert Students
INSERT INTO Students (student_name, department, email) VALUES
('Alice', 'Computer Science', 'alice@example.com'),
('Bob', 'Physics', 'bob@example.com'),
('Charlie', 'Mathematics', 'charlie@example.com');

-- Insert Courses
INSERT INTO Courses (course_name, credits) VALUES
('Data Structures', 4),
('Quantum Physics', 3),
('Linear Algebra', 3);

-- Insert Enrollments
INSERT INTO Enrollments (student_id, course_id) VALUES
(1, 1),  -- Alice enrolled in Data Structures
(2, 2),  -- Bob enrolled in Quantum Physics
(3, 3),  -- Charlie enrolled in Linear Algebra
(1, 2);  -- Alice enrolled in Quantum Physics too


-- Get all Students
SELECT * FROM Students;

-- Get all courses
SELECT * FROM Courses;

-- Get enrollments with student names and course names
SELECT
     e.enrollment_id,
	 s.student_name,
	 s.department,
	 c.course_name,
	 e.enrollment_date
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id;


-- update a students department 
UPDATE Students SET department = 'Data Science' WHERE student_name = 'Alice';

-- Delete a specific enrollment 
DELETE FROM Enrollments WHERE enrollment_id = 4;


BEGIN;

UPDATE Students SET student_name = 'Robert' WHERE student_id = 2;

-- To undo
-- ROll back

-- To Save
COMMIT;

-- Add a column to Courses
ALTER TABLE Courses ADD COLUMN instructor VARCHAR(50);

-- Truncate all enrollments (empties table but keeps structure)
TRUNCATE TABLE Enrollments RESTART IDENTITY	 

-- Create a new database user 
CREATE ROLE app_user WITH LOGIN PASSWORD 'xxxxxxxx';

-- Grant SELECT privilege on Students table to app_user
GRANT SELECT ON Students TO app_user;

-- Revoke that privilege
REVOKE SELECT ON Students FROM app_user;


