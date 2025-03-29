## Querying the Database

### 1. Retrieve all students who enrolled in a specific course
```sql
SELECT s.first_name,
       s.last_name,
       e.course_code,
       e.enrollment_date
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.course_code = 'APL';
```
**Explanation:**
Select student information, course code and enrollment date from table Students, 
Coureses and Enrollments who enroll for any course base on course code.For example,
I had select student information for student who enroll course 'APL'.

---

### 2. Find all faculty members in a particular department
```sql
SELECT f.faculty_name,
       d.department_name
FROM Faculty f
JOIN Departments d ON f.department_id = d.department_id
WHERE d.department_name = 'ITE';
```
**Explanation:**
Select faculty's information and their department from table Faculty and Departments
where 'department_id' from Faculty are the same to 'department_id' from Departments.
For example,I had select faculty's information and their department for faculty who had 
from department 'ITE'.

---

### 3. List all courses a particular student is enrolled in
```sql
SELECT c.course_code,
       c.course_name
FROM Courses c
JOIN Enrollments e ON c.course_code = e.course_code
WHERE e.student_id = 1;
```
**Explanation:**
Select student's enrolled course from table Courses where 'course_code' 
from Courses are the same to 'course_code' from Enrollments base on any 'student_id'.
For example,I had select course's data from student who had 'student_id = 1'.

---

### 4. Retrieve students who have not enrolled in any course
```sql
SELECT s.first_name,
       s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;
```
**Explanation:**
Select some student's data who haven't enrolled for any courses from table student 
where 'student_id' isn't in Enrollment ( 'student_id IS NULL' ).For example,I had select 
'first_name' and 'last_name' who not enrolled for any course.

---

### 5. Find the average grade of students in a specific course
```sql
SELECT c.course_code,
       c.course_name,
       AVG(e.grade) AS avg_grade
FROM Enrollments e
JOIN Courses c ON e.course_code = c.course_code
WHERE c.course_code = 'APL';
```
**Explanation:**
select average grade of students who have enrolled for any courses base on courses_code 
from table Entrollments where 'course_code' from Enrollments are the same to 'course_code' 
from Courses when 'course_code' are real.For example,I had select average grade of students
who enrolled in 'course_code = APL';
