use studentmanagementsystem;

-- 1.	Active Course Enrollment List
SELECT s.student_id, 
       CONCAT(s.first_name, ' ', s.last_name) AS student_name,
       c.course_title,
       co.schedule,
       f.first_name AS faculty_first_name
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN CourseOffering co ON e.offering_id = co.offering_id
JOIN Course c ON co.course_id = c.course_id
JOIN Faculty f ON co.faculty_id = f.faculty_id
WHERE e.status = 'Active'
LIMIT 10;
 
-- 2.	Department-wise Faculty Count (Shows all departments)
SELECT d.dept_name, 
       COUNT(f.faculty_id) AS faculty_count
FROM Department d
LEFT JOIN Faculty f ON d.dept_id = f.dept_id
GROUP BY d.dept_id
ORDER BY faculty_count DESC;

-- 3.	Course Popularity Ranking (Uses existing offerings)
SELECT c.course_id, c.course_title, 
       COUNT(e.enrollment_id) AS enrollment_count
FROM CourseOffering co
JOIN Course c ON co.course_id = c.course_id
LEFT JOIN Enrollment e ON co.offering_id = e.offering_id
GROUP BY co.course_id
ORDER BY enrollment_count DESC
LIMIT 5;
 
-- 4.	Count courses taught by each faculty per semester
SELECT f.faculty_id, CONCAT(f.first_name, ' ', f.last_name) AS faculty_name,
       co.semester_id,
       COUNT(co.offering_id) AS courses_taught,
       SUM(c.credits) AS total_credits
FROM Faculty f
JOIN CourseOffering co ON f.faculty_id = co.faculty_id
JOIN Course c ON co.course_id = c.course_id
GROUP BY f.faculty_id, co.semester_id
ORDER BY co.semester_id, total_credits DESC;
 
-- 5.	List of all students.
SELECT S.student_id, S.first_name, S.last_name
  from Student as S;
 
-- 6.	List of all faculty.
SELECT F.faculty_id, F.first_name, F.last_name
  from Faculty as F;
  


  
