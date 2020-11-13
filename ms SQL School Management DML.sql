
use SchoolManagement;
go
Select * from Class
select * from ClassStudent
select * from ClassSubject
select * from Fee
select * from Notice
select * from Student
select * from Subjects
select * from Teacher

--finde Teacher whos name start at R 
select * from Teacher 
where teacherName like 'R%' 

--
go
--Count Total active student 
select COUNT(studentId) from Student
where sStatus =1

--Total active student
select * from Student
where sStatus =1

--student with class 
select sName from Student s
inner join ClassStudent cs
on s.studentId=cs.studentId
left join Class c on c.classId=cs.classId
where cs.isPass =0