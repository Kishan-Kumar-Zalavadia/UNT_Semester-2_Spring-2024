# Practice Database

-- Select the Database
use practice;

-- Create Department table
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Insert 10 tuples into Department table
INSERT INTO Department (department_id, department_name) VALUES
(1, 'Computer Science'),
(2, 'Electrical Engineering'),
(3, 'Mechanical Engineering'),
(4, 'Civil Engineering'),
(5, 'Mathematics'),
(6, 'Physics'),
(7, 'Biology'),
(8, 'Chemistry'),
(9, 'History'),
(10, 'English');


-- Create Student table
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Insert 10 tuples into Student table
INSERT INTO Student (student_id, student_name, department_id) VALUES
(1, 'Alice', 1),
(2, 'Bob', 2),
(3, 'Charlie', 3),
(4, 'David', 4),
(5, 'Eve', 5),
(6, 'Frank', 6),
(7, 'Grace', 7),
(8, 'Henry', 8),
(9, 'Ivy', 9),
(10, 'Jack', 10);

-- Create Instructor table
CREATE TABLE Instructor (
    instructor_id INT PRIMARY KEY,
    instructor_name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Insert 10 tuples into Instructor table
INSERT INTO Instructor (instructor_id, instructor_name, department_id) VALUES
(1, 'Prof. Smith', 1),
(2, 'Prof. Johnson', 2),
(3, 'Prof. Williams', 3),
(4, 'Prof. Brown', 4),
(5, 'Prof. Davis', 5),
(6, 'Prof. Miller', 6),
(7, 'Prof. Wilson', 7),
(8, 'Prof. Moore', 8),
(9, 'Prof. Taylor', 9),
(10, 'Prof. Anderson', 10);

-- Create Course table
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    instructor_id INT,
    department_id INT,
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Insert 10 tuples into Course table
INSERT INTO Course (course_id, course_name, instructor_id, department_id) VALUES
(1, 'Introduction to Programming', 1, 1),
(2, 'Circuit Theory', 2, 2),
(3, 'Mechanics', 3, 3),
(4, 'Structural Analysis', 4, 4),
(5, 'Calculus', 5, 5),
(6, 'Quantum Mechanics', 6, 6),
(7, 'Biology 101', 7, 7),
(8, 'Chemistry Basics', 8, 8),
(9, 'World History', 9, 9),
(10, 'English Literature', 10, 10);


-- Practice Queries

use assignment1;

SELECT 'Hello, World!' AS greeting;

select 'English' from course;

select salary*12 from instructor;

-- Cross product
select * from instructor, course;

-- % (string), _ (character)
select * from department where department_name like '_isto%';

-- Accending Order
select * from department order by department_name;

-- Descnding order
select * from department order by department_name desc;

select * from instructor where salary between 30000 and 45000;

select * from instructor where salary is not null;

select * from instructor where not salary<40000;

select * from instructor where not salary<40000 and instructor_id>=8;

select * from instructor where not salary<40000 or instructor_id<=2;

select avg(salary) from instructor;

select sum(salary) from instructor;

select count(salary) from instructor;

select count(distinct(salary)) from instructor;

select salary from instructor group by salary;

select salary,count(salary) from instructor group by salary;

select salary,count(salary) as count from instructor group by salary;

select salary,count(salary) as count from instructor group by salary having count(salary)>1;

select * from department where department_id in (select department_id from instructor where salary>30000);

-- Change the database;
use assignment1;

-- Find courses offered in Fall 2017 and in Spring 2018
select course_id from section where semester = "Fall" and year = 2017 and course_id in (select course_id from section where semester = "Spring" and year = 2018);

-- Find courses offered in Fall 2017 and in Spring 2018
select course_id from section where semester = "Fall" and year = 2017 and course_id not in (select course_id from section where semester = "Spring" and year = 2018);

-- Name all instructors whose name is neither “Mozart” nor Einstein”
select distinct name from instructor where name not in ("Mozart", "Einstein");

-- Find the total number of (distinct) students who have taken course sections taught by the instructor with ID 10101
select count(distinct ID) from takes where (course_id, sec_id, semester, year) in (select course_id, sec_id, semester, year from teaches where teaches.ID= 10101);

-- Find names of instructors with salary greater than that of some (at least one) instructor in the Biology department.
select * from instructor where salary > some (select salary from instructor where dept_name = "Biology");
select * from instructor T, instructor S where T.salary > S.salary and S.dept_name = 'Biology';

-- Find the names of all instructors whose salary is greater than the salary of all instructors in the Biology department.
select * from instructor where salary > all (select salary from instructor where dept_name = "Biology");

-- Yet another way of specifying the query “Find all courses taught in both the Fall 2017 semester and in the Spring 2018 semester”
select course_id
       from section as S
       where semester = 'Fall' and year = 2017 and 
       exists  (select *
       from section as T
       where semester = 'Spring' and year= 2018 
       and S.course_id = T.course_id);

-- Find all students who have taken all courses offered in the Biology department.
select distinct S.ID, S.name
from student as S
where not exists ( (select course_id
                                 from course
                                 where dept_name = 'Biology')
                               except
                                 (select T.course_id
                                   from takes as T
                                   where S.ID = T.ID));


select distinct S.ID, S.name
from student as S
where not exists  (select course_id
                                 from course
                                 where dept_name = 'Biology' and 
                               course_id not in
                                 (select T.course_id
                                   from takes as T
                                   where S.ID = T.ID));

-- Find all courses that were offered at most once in 2017
SELECT T.course_id
	FROM course AS T
	WHERE T.course_id IN (
		SELECT DISTINCT R.course_id
		FROM section AS R
		WHERE T.course_id = R.course_id
		AND R.year = 2017
);

-- Find the average instructors’ salaries of those departments where the average salary is greater than $42,000.”
select dept_name, avg_salary from (select dept_name, avg(salary) as avg_salary from instructor group by dept_name) as AvgSalaryByDept where avg_salary>42000;


-- Find all departments with the maximum budget 
with max_budget (value) as 
             (select max(budget) from department)
             select dept_name
             from department, max_budget
             where department.budget = max_budget.value;
             
-- Find all departments where the total salary is greater than the average of the total salary at all departments
with dept_total (dept_name, value) as
        (select dept_name, sum(salary)
         from instructor
         group by dept_name),
dept_total_avg(value) as
       (select avg(value)
       from dept_total)
select dept_name
from dept_total, dept_total_avg
where dept_total.value > dept_total_avg.value;

-- List all departments along with the number of instructors in each department
select dept_name, 
             ( select count(*) 
             from instructor
             where department.dept_name = instructor.dept_name)
             as num_instructors
             from department;