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
- This query retrieves student information (first name and last name), course code, and enrollment date.
- It uses an `INNER JOIN` to connect the `Students` and `Enrollments` tables using the `student_id`.
- The query filters results to only show students enrolled in the course with code `'APL'`.

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
- This query fetches faculty names and their department names.
- It uses an `INNER JOIN` to match faculty members to their respective departments using `department_id`.
- The filter ensures only faculty members from the `'ITE'` department are returned.

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
- This query lists the course code and course name for a student with `student_id = 1`.
- It uses an `INNER JOIN` to link courses and enrollments using `course_code`.
- The query filters the results to display only the courses the specified student is enrolled in.

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
- This query finds students who have not enrolled in any course.
- A `LEFT JOIN` is used to retain all records from `Students`, even if there is no matching record in `Enrollments`.
- The `WHERE e.student_id IS NULL` condition identifies students with no enrollment records.

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
- This query calculates the average grade of students enrolled in a course with the code `'APL'`.
- It uses an `INNER JOIN` to connect `Enrollments` and `Courses` using `course_code`.
- The `AVG()` function computes the average grade and labels the result as `avg_grade`.

