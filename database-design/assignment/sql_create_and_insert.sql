
-- CREATE TABLE
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    faculty_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE CASCADE
);

CREATE TABLE Courses (
    course_code VARCHAR(20) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    faculty_id INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id) ON DELETE SET NULL
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_code VARCHAR(20) NOT NULL,
    enrollment_date DATE NOT NULL,
    grade DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_code) REFERENCES Courses(course_code) ON DELETE CASCADE
);

-- Insert Data
-- 1, Intert to Students
INSERT INTO Students (first_name, last_name, date_of_birth, email)
VALUES
		('Alice', 'Johnson', '2001-06-15', 'alice@example.com'),
		('Sok', 'Sochetra', '2004-12-19', 'sochetra@example.com'),
		('Christiano', 'Roanldo', '1998-03-15', 'ronaldo@example.com'),
		('Lionel', 'Messi', '1990-06-30', 'messi@example.com'),
		('Roronoa', 'Zoro', '2000-09-19', 'zoro@example.com'),
		('Monkey D.', 'Luffy', '2001-09-12', 'luffy@example.com'),
		('Nico', 'Robin', '2007-12-31', 'robin@example.com'),
		('Tony Tony', 'Chopper', '2001-04-21', 'chopper@example.com'),
		('Itachi', 'Uchiha', '1999-01-19', 'itachi@example.com'),
		('Sasuke', 'Uchiha', '2000-01-19', 'sasuke@example.com');

-- 2, Intert to Departments
INSERT INTO Departments (department_id, department_name)
VALUES
		(1, 'ITE'),
		(2, 'BIOE'),
        (3, 'TEE');

-- 3, Intert to Faculty
INSERT INTO Faculty (faculty_id, faculty_name, department_id)
VALUES
		(1, 'Dr. Dre', 1),
		(2, 'Dr. Doom', 2),
		(3, 'Dr. Thanos', 3);

-- 4, Intert to Courses
INSERT 	INTO Courses (course_code, course_name, faculty_id)
VALUES
		('APL', 'Advance Programming Language', 1),
		('DB', 'Database', 2),
		('DSA', 'Data Structure And Algorithm', 3),
		('MATH', 'Calculus I', 2),
		('PHY', 'General Physics', 3),
		('PL', 'Philosophy', 1),
        ('ENG', 'English', NULL),
		('TD', 'Technical Drawing', NULL);

-- 5, Intert to Enrollments
INSERT INTO Enrollments (enrollment_id, student_id, course_code, enrollment_date, grade)
VALUES
		(1, 1, 'APL', '2024-01-10', 85.50),
		(2, 2, 'MATH', '2024-02-15', 90.00),
		(3, 3, 'PHY', '2024-03-20', 88.50),
		(4, 4, 'APL', '2024-01-10', 99.99),
		(5, 5, 'PHY', '2024-03-20', 29.09),
		(6, 6, 'MATH', '2024-02-15', 39.99),
		(7, 7, 'APL', '2024-01-10', 19.01),
		(8, 8, 'APL', '2024-01-10', 1.88);
        
-- Querying the Database
-- 1, Retrieve all students who enrolled in a specific course.
SELECT 	s.first_name, 
		s.last_name, 
		e.course_code, 
        e.enrollment_date 
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.course_code = 'APL';
                     
-- 2, Find all faculty members in a particular department.
SELECT 	f.faculty_name, 
		d.department_name
FROM  Faculty f
JOIN  Departments d ON f.department_id = d.department_id
WHERE d.department_name = 'ITE';

-- 3, List all courses a particular student is enrolled in.
SELECT 	c.course_code, 
		c.course_name
FROM Courses c
JOIN Enrollments e ON c.course_code = e.course_code
WHERE e.student_id = 1;

-- 4, Retrieve students who have not enrolled in any course.
SELECT 	s.first_name, 
		s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- 5, Find the average grade of students in a specific course.
SELECT 	c.course_code, 
		c.course_name, 	
        AVG(e.grade) AS avg_grade
FROM Enrollments e
JOIN Courses c ON e.course_code = c.course_code
WHERE c.course_code = 'APL';

-- Create StoredProcedures
-- 1. Retrieve all students who enrolled in a specific course
DELIMITER //
CREATE PROCEDURE GetStudentsByCourse(IN courseCode VARCHAR(10))
BEGIN
    SELECT s.first_name, 
           s.last_name, 
           e.course_code, 
           e.enrollment_date 
    FROM Students s
    JOIN Enrollments e ON s.student_id = e.student_id
    WHERE e.course_code = courseCode;
END //
DELIMITER ;

-- 2. Find all faculty members in a particular department
DELIMITER //
CREATE PROCEDURE GetFacultyByDepartment(IN departmentName VARCHAR(50))
BEGIN
    SELECT f.faculty_name, 
           d.department_name
    FROM Faculty f
    JOIN Departments d ON f.department_id = d.department_id
    WHERE d.department_name = departmentName;
END //
DELIMITER ;

-- 3. List all courses a particular student is enrolled in
DELIMITER //
CREATE PROCEDURE GetCoursesByStudent(IN studentId INT)
BEGIN
    SELECT c.course_code, 
           c.course_name
    FROM Courses c
    JOIN Enrollments e ON c.course_code = e.course_code
    WHERE e.student_id = studentId;
END //
DELIMITER ;

-- 4. Retrieve students who have not enrolled in any course
DELIMITER //
CREATE PROCEDURE GetStudentsWithoutEnrollment()
BEGIN
    SELECT s.first_name, 
           s.last_name
    FROM Students s
    LEFT JOIN Enrollments e ON s.student_id = e.student_id
    WHERE e.student_id IS NULL;
END //
DELIMITER ;

-- 5. Find the average grade of students in a specific course
DELIMITER //
CREATE PROCEDURE GetAverageGradeByCourse(IN courseCode VARCHAR(10))
BEGIN
    SELECT c.course_code, 
           c.course_name, 	
           AVG(e.grade) AS avg_grade
    FROM Enrollments e
    JOIN Courses c ON e.course_code = c.course_code
    WHERE c.course_code = courseCode;
END //
DELIMITER ;


-- Call StoredProcedure
-- 1, Retrieve all students who enrolled in a specific course.
CALL GetStudentsByCourse('APL');

-- 2, Find all faculty members in a particular department.
CALL GetFacultyByDepartment('ITE');

-- 3, List all courses a particular student is enrolled in.
CALL GetCoursesByStudent(3);

-- 4, Retrieve students who have not enrolled in any course
CALL GetStudentsWithoutEnrollment();

-- 5, Find the average grade of students in a specific course.
CALL GetAverageGrade('MATH');

-- Get All Data
SELECT * FROM Students;

SELECT * FROM Enrollments;

SELECT * FROM Courses;

SELECT * FROM Faculty;

SELECT * FROM Departments;
