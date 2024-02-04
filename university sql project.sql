
use university;
create table classroom
(building		varchar(15),
room_number		varchar(7) primary key,
capacity		numeric(4,0)
);
create table department
(dept_name		varchar(20),
building		varchar(15),
budget		        numeric(12,2) check (budget > 0),
primary key (dept_name)
);

create table course
(course_id		varchar(8),
title			varchar(50),
dept_name		varchar(20),
credits		numeric(2,0) check (credits > 0),
primary key (course_id),
foreign key (dept_name) references department (dept_name)
on delete set null
);

create table instructor
(ID			varchar(5),
name			varchar(20) not null,
dept_name		varchar(20),
salary			numeric(8,2) check (salary > 29000),
primary key (ID),
foreign key (dept_name) references department (dept_name)
on delete set null
);

create table time_slot
	(id int primary key,
	time_slot_id		varchar(4),
	 day			varchar(1),
	 start_hr		numeric(2) check (start_hr >= 0 and start_hr < 24),
	 start_min		numeric(2) check (start_min >= 0 and start_min < 60),
	 end_hr			numeric(2) check (end_hr >= 0 and end_hr < 24),
	 end_min		numeric(2) check (end_min >= 0 and end_min < 60)
	);

create table section
	(course_id		varchar(8), 
         sec_id			varchar(8),
	 semester		varchar(6)
		check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
	 year			numeric(4,0) check (year > 1701 and year < 2100), 
	 building		varchar(15),
	 room_number		varchar(7),
	 time_slot_id		varchar(4),
	 id int,
	 primary key (course_id, sec_id, semester, year),
	 foreign key (course_id) references course (course_id)
		on delete cascade,
	 foreign key (room_number) references classroom (room_number)
		on delete set null,
	 foreign key (id) references time_slot (id)
		on delete set null
	);

create table teaches
(ID			varchar(5),
course_id		varchar(8),
sec_id			varchar(8),
semester		varchar(6),
year			numeric(4,0),
primary key (ID, course_id, sec_id, semester, year),
foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
on delete cascade,
foreign key (ID) references instructor (ID)
on delete cascade
);

create table student
(ID			varchar(5),
name			varchar(20) not null,
dept_name		varchar(20),
tot_cred		numeric(3,0) check (tot_cred >= 0),
primary key (ID),
foreign key (dept_name) references department (dept_name)
on delete set null
);

create table takes
(ID			varchar(5),
course_id		varchar(8),
sec_id			varchar(8),
semester		varchar(6),
year			numeric(4,0),
grade		        varchar(2),
primary key (ID, course_id, sec_id, semester, year),
foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
on delete cascade,
foreign key (ID) references student (ID)
on delete cascade
);

create table advisor
(s_ID			varchar(5),
i_ID			varchar(5),
primary key (s_ID),
foreign key (i_ID) references instructor (ID)
on delete set null,
foreign key (s_ID) references student (ID)
on delete cascade
);



create table prereq
(course_id		varchar(8),
prereq_id		varchar(8),
primary key (course_id, prereq_id),
foreign key (course_id) references course (course_id)
on delete cascade,
foreign key (prereq_id) references course (course_id)
);

insert into classroom values ('Packard', '101', '500');
insert into classroom values ('Painter', '514', '10');
insert into classroom values ('Taylor', '3128', '70');
insert into classroom values ('Watson', '100', '30');
insert into classroom values ('Watson', '120', '50');
insert into classroom values ('Taylor', '112', '30');
insert into classroom values ('Painter', '234', '50');
insert into classroom values ('Packard', '303', '56');

insert into department values ('Biology', 'Watson', '90000');
insert into department values ('Comp. Sci.', 'Taylor', '100000');
insert into department values ('Elec. Eng.', 'Taylor', '85000');
insert into department values ('Finance', 'Painter', '120000');
insert into department values ('History', 'Painter', '50000');
insert into department values ('Music', 'Packard', '80000');
insert into department values ('Physics', 'Watson', '70000');

insert into course values ('BIO-101', 'Intro. to Biology', 'Biology', '4');
insert into course values ('BIO-301', 'Genetics', 'Biology', '4');
insert into course values ('BIO-399', 'Computational Biology', 'Biology', '3');
insert into course values ('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', '4');
insert into course values ('CS-190', 'Game Design', 'Comp. Sci.', '4');
insert into course values ('CS-315', 'Robotics', 'Comp. Sci.', '3');
insert into course values ('CS-319', 'Image Processing', 'Comp. Sci.', '3');
insert into course values ('CS-347', 'Database System Concepts', 'Comp. Sci.', '3');
insert into course values ('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', '3');
insert into course values ('FIN-201', 'Investment Banking', 'Finance', '3');
insert into course values ('HIS-351', 'World History', 'History', '3');
insert into course values ('MU-199', 'Music Video Production', 'Music', '3');
insert into course values ('PHY-101', 'Physical Principles', 'Physics', '4');

insert into instructor values ('10101', 'Srinivasan', 'Comp. Sci.', '65000');
insert into instructor values ('12121', 'Wu', 'Finance', '90000');
insert into instructor values ('15151', 'Mozart', 'Music', '40000');
insert into instructor values ('22222', 'Einstein', 'Physics', '95000');
insert into instructor values ('32343', 'El Said', 'History', '60000');
insert into instructor values ('33456', 'Gold', 'Physics', '87000');
insert into instructor values ('45565', 'Katz', 'Comp. Sci.', '75000');
insert into instructor values ('58583', 'Califieri', 'History', '62000');
insert into instructor values ('76543', 'Singh', 'Finance', '80000');
insert into instructor values ('76766', 'Crick', 'Biology', '72000');
insert into instructor values ('83821', 'Brandt', 'Comp. Sci.', '92000');
insert into instructor values ('98345', 'Kim', 'Elec. Eng.', '80000');

insert into time_slot values (1,'A', 'M', '8', '0', '8', '50');
insert into time_slot values (2,'A', 'W', '8', '0', '8', '50');
insert into time_slot values (3,'A', 'F', '8', '0', '8', '50');
insert into time_slot values (4,'B', 'M', '9', '0', '9', '50');
insert into time_slot values (5,'B', 'W', '9', '0', '9', '50');
insert into time_slot values (6,'B', 'F', '9', '0', '9', '50');
insert into time_slot values (7,'C', 'M', '11', '0', '11', '50');
insert into time_slot values (8,'C', 'W', '11', '0', '11', '50');
insert into time_slot values (9,'C', 'F', '11', '0', '11', '50');
insert into time_slot values (10,'D', 'M', '13', '0', '13', '50');
insert into time_slot values (11,'D', 'W', '13', '0', '13', '50');
insert into time_slot values (12,'D', 'F', '13', '0', '13', '50');
insert into time_slot values (13,'E', 'T', '10', '30', '11', '45 ');
insert into time_slot values (14,'E', 'R', '10', '30', '11', '45 ');
insert into time_slot values (15,'F', 'T', '14', '30', '15', '45 ');
insert into time_slot values (16,'F', 'R', '14', '30', '15', '45 ');
insert into time_slot values (17,'G', 'M', '16', '0', '16', '50');
insert into time_slot values (18,'G', 'W', '16', '0', '16', '50');
insert into time_slot values (19,'G', 'F', '16', '0', '16', '50');
insert into time_slot values (20,'H', 'W', '10', '0', '12', '30');

insert into section values ('BIO-101', '1', 'Summer', '2017', 'Painter', '514', 'B',1);
insert into section values ('BIO-301', '1', 'Summer', '2018', 'Painter', '514', 'A',2);
insert into section values ('CS-101', '1', 'Fall', '2017', 'Packard', '101', 'H',3);
insert into section values ('CS-101', '1', 'Spring', '2018', 'Packard', '101', 'F',4);
insert into section values ('CS-190', '1', 'Spring', '2017', 'Taylor', '3128', 'E',5);
insert into section values ('CS-190', '2', 'Spring', '2017', 'Taylor', '3128', 'A',6);
insert into section values ('CS-315', '1', 'Spring', '2018', 'Watson', '120', 'D',7);
insert into section values ('CS-319', '1', 'Spring', '2018', 'Watson', '100', 'B',8);
insert into section values ('CS-319', '2', 'Spring', '2018', 'Taylor', '3128', 'C',9);
insert into section values ('CS-347', '1', 'Fall', '2017', 'Taylor', '3128', 'A',10);
insert into section values ('EE-181', '1', 'Spring', '2017', 'Taylor', '3128', 'C',11);
insert into section values ('FIN-201', '1', 'Spring', '2018', 'Packard', '101', 'B',12);
insert into section values ('HIS-351', '1', 'Spring', '2018', 'Painter', '514', 'C',13);
insert into section values ('MU-199', '1', 'Spring', '2018', 'Packard', '101', 'D',14);
insert into section values ('PHY-101', '1', 'Fall', '2017', 'Watson', '100', 'A',15);


insert into teaches values ('10101', 'CS-101', '1', 'Fall', '2017');
insert into teaches values ('10101', 'CS-315', '1', 'Spring', '2018');
insert into teaches values ('10101', 'CS-347', '1', 'Fall', '2017');
insert into teaches values ('12121', 'FIN-201', '1', 'Spring', '2018');
insert into teaches values ('15151', 'MU-199', '1', 'Spring', '2018');
insert into teaches values ('22222', 'PHY-101', '1', 'Fall', '2017');
insert into teaches values ('32343', 'HIS-351', '1', 'Spring', '2018');
insert into teaches values ('45565', 'CS-101', '1', 'Spring', '2018');
insert into teaches values ('45565', 'CS-319', '1', 'Spring', '2018');
insert into teaches values ('76766', 'BIO-101', '1', 'Summer', '2017');
insert into teaches values ('76766', 'BIO-301', '1', 'Summer', '2018');
insert into teaches values ('83821', 'CS-190', '1', 'Spring', '2017');
insert into teaches values ('83821', 'CS-190', '2', 'Spring', '2017');
insert into teaches values ('83821', 'CS-319', '2', 'Spring', '2018');
insert into teaches values ('98345', 'EE-181', '1', 'Spring', '2017');

insert into student values ('00128', 'Zhang', 'Comp. Sci.', '102');
insert into student values ('12345', 'Shankar', 'Comp. Sci.', '32');
insert into student values ('19991', 'Brandt', 'History', '80');
insert into student values ('23121', 'Chavez', 'Finance', '110');
insert into student values ('44553', 'Peltier', 'Physics', '56');
insert into student values ('45678', 'Levy', 'Physics', '46');
insert into student values ('54321', 'Williams', 'Comp. Sci.', '54');
insert into student values ('55739', 'Sanchez', 'Music', '38');
insert into student values ('70557', 'Snow', 'Physics', '0');
insert into student values ('76543', 'Brown', 'Comp. Sci.', '58');
insert into student values ('76653', 'Aoi', 'Elec. Eng.', '60');
insert into student values ('98765', 'Bourikas', 'Elec. Eng.', '98');
insert into student values ('98988', 'Tanaka', 'Biology', '120');

insert into takes values ('00128', 'CS-101', '1', 'Fall', '2017', 'A');
insert into takes values ('00128', 'CS-347', '1', 'Fall', '2017', 'A-');
insert into takes values ('12345', 'CS-101', '1', 'Fall', '2017', 'C');
insert into takes values ('12345', 'CS-190', '2', 'Spring', '2017', 'A');
insert into takes values ('12345', 'CS-315', '1', 'Spring', '2018', 'A');
insert into takes values ('12345', 'CS-347', '1', 'Fall', '2017', 'A');
insert into takes values ('19991', 'HIS-351', '1', 'Spring', '2018', 'B');
insert into takes values ('23121', 'FIN-201', '1', 'Spring', '2018', 'C+');
insert into takes values ('44553', 'PHY-101', '1', 'Fall', '2017', 'B-');
insert into takes values ('45678', 'CS-101', '1', 'Fall', '2017', 'F');
insert into takes values ('45678', 'CS-101', '1', 'Spring', '2018', 'B+');
insert into takes values ('45678', 'CS-319', '1', 'Spring', '2018', 'B');
insert into takes values ('54321', 'CS-101', '1', 'Fall', '2017', 'A-');
insert into takes values ('54321', 'CS-190', '2', 'Spring', '2017', 'B+');
insert into takes values ('55739', 'MU-199', '1', 'Spring', '2018', 'A-');
insert into takes values ('76543', 'CS-101', '1', 'Fall', '2017', 'A');
insert into takes values ('76543', 'CS-319', '2', 'Spring', '2018', 'A');
insert into takes values ('76653', 'EE-181', '1', 'Spring', '2017', 'C');
insert into takes values ('98765', 'CS-101', '1', 'Fall', '2017', 'C-');
insert into takes values ('98765', 'CS-315', '1', 'Spring', '2018', 'B');
insert into takes values ('98988', 'BIO-101', '1', 'Summer', '2017', 'A');
insert into takes values ('98988', 'BIO-301', '1', 'Summer', '2018', null);

insert into advisor values ('00128', '45565');
insert into advisor values ('12345', '10101');
insert into advisor values ('23121', '76543');
insert into advisor values ('44553', '22222');
insert into advisor values ('45678', '22222');
insert into advisor values ('76543', '45565');
insert into advisor values ('76653', '98345');
insert into advisor values ('98765', '98345');
insert into advisor values ('98988', '76766');

insert into prereq values ('BIO-301', 'BIO-101');
insert into prereq values ('BIO-399', 'BIO-101');
insert into prereq values ('CS-190', 'CS-101');
insert into prereq values ('CS-315', 'CS-101');
insert into prereq values ('CS-319', 'CS-101');
insert into prereq values ('CS-347', 'CS-101');
insert into prereq values ('EE-181', 'PHY-101');

#1. Display average salary given by each department.
select d.dept_name, avg(i.salary) from department d inner join instructor i 
on d.dept_name = i.dept_name 
group by d.dept_name;

#.2. Display the name of students and their corresponding course IDs.

select s.name, c.course_id from student s join department d 
on s.dept_name = d.dept_name join course c on d.dept_name = c.dept_name

#3. Display number of courses taken by each student.
select count(c.title) ,s.name from course c join department d 
on c.dept_name = d.dept_name join student s on d.dept_name = s.dept_name 
group by s.name;

--4. Get the prerequisites courses for courses in the Spring semester.

select p.prereq_id,t.course_id from prereq p join takes t 
on p.course_id = t.course_id 
where t.semester = "Spring";

#5. Display the instructor name who teaches student with highest 5 credits.
select i.name,s.name,s.tot_cred  from instructor i join  student s on i.dept_name = s.dept_name 
order by s.tot_cred desc
limit 5;

--6. Which semester and department offers maximum number of courses.
select b.semester,b.dept_name,max(coun) as max from 
(select s.semester,c.dept_name,count(c.course_id) as coun 
from section s join course c on s.course_id = c.course_id 
group by s.semester,c.dept_name) as b 
group by b.semester,b.dept_name
order by max desc
limit 1;

--7. Display course and department whose time starts at 8.
select s.course_id,t.start_hr,c.dept_name from course c join section s 
on c.course_id = s.course_id join time_slot t on s.time_slot_id = t.time_slot_id
where t.start_hr = 8  
group by s.course_id,c.dept_name;

--8. Display the salary of instructors from Watson building.
select i.name,i.salary,d.building from instructor i join department d
on i.dept_name = d.dept_name 
where d.building = "Watson";

--9  Show the title of courses available on Monday.
select c.title,t.day from  course c join section s
on c.course_id = s.course_id join time_slot t on s.time_slot_id = t.time_slot_id 
where t.day = "M";

==10. Find the number of courses that start at 8 and end at 8.
select count(c.course_id) from course c join section s on c.course_id = s.course_id 
join time_slot t on  s.time_slot_id = t.time_slot_id 
where t.start_hr = 8 and t.end_hr = 8;

--11. Find instructors having salary more than 90000.
select name ,salary from instructor 
where salary > 90000;

--12. Find student records taking courses before 2018.
select * from takes where year < 2018;

--13. Find student records taking courses in the fall semester and coming under first section.
select * from section where semester = "Fall" and sec_id = 1;

--14. Find student records taking courses in the fall semester and coming under second section.
select * from section where semester = "Fall" and sec_id = 2;

---15. Find student records taking courses in the summer semester, coming under first section in the year 2017.
select * from takes where semester = "Summer" and sec_id = 1 and year = 2017;

--16. Find student records taking courses in the fall semester and having A grade.
select * from takes where semester = "Fall" and grade = "A";

--17. Find student records taking courses in the summer semester and having A grade.
select * from takes where semester = "summer" and grade = "A";

--18. Display section details with B time slot, room number 514 and in the Painter building.
select * from section;

select * from section where time_slot_id = "B" and room_number = 514 and building = "Painter";

--19. Find all course titles which have a string "Intro.".
select title from course
where title like "%Intro.%";

---20. Find the titles of courses in the Computer Science department that have 3 credits.
select title , credits from course 
where dept_name = "Comp. Sci." and credits = 3;
select * from course;

--21. Find IDs and titles of all the courses which were taught by an instructor named Einstein. Make sure there are no duplicates in the result.
select c.course_id , c.title , i.name from course c join instructor i on c.dept_name = i.dept_name 
where i.name = "Einstein"; 

--22. Find all course IDs which start with CS
select course_id  from course 
where course_id  like "CS%"

--23. For each department, find the maximum salary of instructors in that department.
select dept_name ,max(salary ) from instructor 
group by dept_name;

--24. Find the enrollment (number of students) of each section that was offered in Fall 2017.

select sec_id , count(id) as coun , semester, year 
from takes where semester = "Fall" and year = 2017 
group by sec_id;

--25. Increase(update) the salary of each instructor by 10% if their current salary is between 0 and 90000.
Update instructor set salary = salary * 1.1
 WHERE salary between 0 and 90000;
 
--- 26. Find the names of instructors from Biology department having salary more than 50000.
select name from instructor 
where dept_name = "Biology" and salary > 50000;

--27. Find the IDs and titles of all courses taken by a student named Shankar.

select c.course_id,c.title from course c join student s on c.dept_name = s.dept_name 
where s.name = "Shankar";

---28. For each department, find the total credit hours of courses in that department.
select dept_name,sum(credits) as total_credits from course group by dept_name;

#29. Find the number of courses having A grade in each building.

select count(c.course_id), t.grade,d.building from takes t join course c on t.course_id = c.course_id 
join department d on c.dept_name = d.dept_name 
where t.grade = "A" 
group by d.building;
 
#30. Display number of students in each department having total credits divisible by course credits.
select count(s.ID) , s.dept_name ,sum(s.tot_cred)/sum(c.credits) 
from student s join course c on s.dept_name = c.dept_name 
group by s.dept_name; 

#31. Display number of courses available in each building.
select count(c.course_id), d.building from course c join department d 
on c.dept_name = d.dept_name
group by d.building;

#32. Find number of instructors in each department having 'a' and 'e' in their name.

select count(ID),name, dept_name
from instructor 
where name like "%a%e%"
group by name,dept_name;

#33. Display number of courses being taught in classroom having capacity more than 20.
select count(c.course_id),cl.capacity from classroom cl join department d on cl.building = d.building 
join course c on d.dept_name = c.dept_name 
where cl.capacity > 20
group by cl.capacity;

#34. Update the budget of each department by Rs. 1000
update department set budget = budget + 1000 

#35. Find number of students in each room.
select count(s.ID), c.room_number from student s join department d on s.dept_name = d.dept_name 
join classroom c on d.building = c.building
group by c.room_number;

##36. Give the prerequisite course for each student.
select s.name,p.prereq_id from student s join takes  t  on s.ID = t.ID 
join prereq p on t.course_id = p.course_id
group by s.name,p.prereq_id;

#37. Display number of students attending classes on Wednesday.
select count (s.name), t.day from student s join time_slot t on s.id = t.id 
where t.day = "Wednesday"
group by t.day;

#38. Display number of students and instructors in each department
select count(s.id),count(i.id),s.dept_name from student s join instructor i 
on s.dept_name = i.dept_name
group by s.dept_name;

#39. Display number of students in each semester and their sum of credits.
select count(s.ID),sum(s.tot_cred),t.semester from student s join takes t on s.ID = t.ID
group by t.semester;

#40. Give number of instructors in each building.
select count(i.ID), d.building from instructor i join department d 
on i.dept_name = d.dept_name 
group by d.building;

#41. Display advisor IDs for instructors in Painter building.
select a.i_ID, i.ID,d.building from advisor a join instructor i on a.i_ID = i.ID
join department d on i.dept_name  = d.dept_name
where d.building = "Painter";

#42. Find total credits earned by students coming at 9am
select s.tot_cred,s.name, t.start_hr from student s join time_slot t 
on s.id = t.id 
where t.start_hr = 9;

#43. Display student names ordered by room number
select s.name,c.room_number from student s join department d on s.dept_name = d.dept_name
join classroom c on d.building = c.building 
order by c.room_number;

#44. Find the number of capacity left after occupying all the students.
select c.room_number,c.capacity - count(t.id) as remaining_capacity from takes t join student s on t.ID = s.ID
join department d on s.dept_name = d.dept_name join classroom c on d.building = c.building
group by c.room_number;

#45. Find the duration for which each student has to attend each lecture.
select s.name , c.course_id,(t.end_hr-t.start_hr )as duration , (t.end_min-t.start_min) as duration_min 
from course c  join student s on c.dept_name = s.dept_name join time_slot t  on s.id = t.id
group by s.name,c.course_id,t.end_hr,t.start_hr,t.end_min,t.start_min; 

#46. Create a timetable for the university.
select 

#47. Find the average salary that's distributed to teachers for each course and sort them in descending order
select c.title,avg(i.salary) as average from course c join instructor i on c.dept_name = i.dept_name 
group by c.title
order by average desc;

#48. Find the average duration of classes for each course id
with time_duration as(
select time_slot_id , end_min-start_min as duration from time_slot )
select s.course_id , avg(t.duration) from section s join time_duration t 
on s.time_slot_id = t.time_slot_id 
group by s.course_id;

#49 Get the name of the instructor with highest salary from each department.
select name,max(salary),dept_name from instructor 
group by dept_name,name;

#50. Get the sum of the total credits of students that is dealt by the instructors along with their names
SELECT i.name AS instructor_name, SUM(c.credits) AS total_credits_taught
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN course c ON t.course_id = c.course_id
JOIN student s ON c.dept_name = s.dept_name
GROUP BY i.name;


#51. Perform division between student credits and department total credits
with dept_cred as (
select dept_name,sum(credits) as tot_dept_cred 
from course group by dept_name
) 
select s.name, s.tot_cred/dc.tot_dept_cred
from student s join dept_cred dc
on s.dept_name = dc.dept_name;



#52. If the department budget was to be distributed among the buildings, how much amount can be allocated to each room in a building
with building_room_data as (
select building,count(room_number) as num_rooms 
from classroom
group by building )
select bb.building,bb.building_budget/num_rooms as room_budget 
from building_room_data as brd
join (
select building,sum(budget) as building_budget 
from department 
group by building ) as bb
on bb.building = brd.building;
  










