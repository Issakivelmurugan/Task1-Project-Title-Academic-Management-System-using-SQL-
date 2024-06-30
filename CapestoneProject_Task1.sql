Create Database Project1;
USE Project1;
/* Creating the StudentInfo table */
CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(255),
    DOB DATE,
    PHONE_NO VARCHAR(20),
    EMAIL_ID VARCHAR(255),
    ADDRESS VARCHAR(255)
);
SELECT * FROM StudentInfo;
/* Creating the CoursesInfo table */
CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(255),
    COURSE_INSTRUCTOR_NAME VARCHAR(255)
);
SELECT * FROM CoursesInfo;
/* Creating the EnrollmentInfo table */
CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);
SELECT * FROM EnrollmentInfo;
/* Inserting values into StudentInfo table */
INSERT INTO StudentInfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS)
VALUES
    (1, 'Rajesh Kumar', '1998-03-10', '9876543210', 'rajesh.kumar@example.com', '123, Gandhi Nagar'),
    (2, 'Priya Sharma', '1999-07-15', '8765432109', 'priya.sharma@example.com', '456, Jaipur Road');
SELECT * FROM StudentInfo;
/* Inserting values into CoursesInfo table */
INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME)
VALUES
    (101, 'Mathematics', 'Prof. Gupta'),
    (102, 'Computer Science', 'Prof. Verma');
SELECT * FROM CoursesInfo;
/* Inserting values into EnrollmentInfo table */
INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS)
VALUES
    (1001, 1, 101, 'Enrolled'),
    (1002, 1, 102, 'Enrolled'),
    (1003, 2, 101, 'Enrolled');
SELECT * FROM EnrollmentInfo;
/* To retrieve student details, including their name, contact information, and enrollment status */
SELECT
    s.STU_NAME,
    s.PHONE_NO,
    s.EMAIL_ID,
    e.ENROLL_STATUS
FROM
    StudentInfo s
JOIN
    EnrollmentInfo e ON s.STU_ID = e.STU_ID;
/* To retrieve a list of courses in which a specific student (with STU_ID = 1) is enrolled */
SELECT
    c.COURSE_NAME
FROM
    CoursesInfo c
JOIN
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE
    e.STU_ID = 1;
/* To retrieve course information, including course name and instructor details */
SELECT
    c.COURSE_NAME,
    c.COURSE_INSTRUCTOR_NAME
FROM
    CoursesInfo c;
/* To retrieve course information for a specific course (with COURSE_ID = 101) */
SELECT
    c.COURSE_NAME,
    c.COURSE_INSTRUCTOR_NAME
FROM
    CoursesInfo c
WHERE
    c.COURSE_ID = 101;
/* To retrieve information for specific courses (with course IDs 101, 102, and 103) */
SELECT COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_ID IN (101, 102, 103);
/* To retrieve the number of students enrolled in each course */
SELECT
    c.COURSE_NAME,
    COUNT(e.STU_ID) AS Enrolled_Students
FROM
    CoursesInfo c
LEFT JOIN
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
GROUP BY
    c.COURSE_NAME
ORDER BY
    Enrolled_Students DESC;
/* To retrieve the list of students enrolled in a specific course (with COURSE_ID = 101) */
SELECT
    s.STU_NAME
FROM
    StudentInfo s
JOIN
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
WHERE
    e.COURSE_ID = 101;
/* To retrieve the count of enrolled students for each instructor */
SELECT
    c.COURSE_INSTRUCTOR_NAME,
    COUNT(e.STU_ID) AS Enrolled_Students
FROM
    CoursesInfo c
LEFT JOIN
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
GROUP BY
    c.COURSE_INSTRUCTOR_NAME
ORDER BY
    Enrolled_Students DESC;
/* To retrieve the list of students who are enrolled in multiple courses */
SELECT
    s.STU_NAME
FROM
    StudentInfo s
JOIN
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
GROUP BY
    s.STU_NAME
HAVING
    COUNT(DISTINCT e.COURSE_ID) > 1;
/* To retrieve the courses with the highest number of enrolled students (arranged from highest to lowest) */
SELECT
    c.COURSE_NAME,
    COUNT(e.STU_ID) AS Enrolled_Students
FROM
    CoursesInfo c
LEFT JOIN
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
GROUP BY
    c.COURSE_NAME
ORDER BY
    Enrolled_Students DESC;