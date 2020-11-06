/* 
-------------------------------
School Management Database
-------------------------------
Name -  Md. Mahmodul Hasa
Student ID- 1251168
Batch ID- ESAD-CS/GNSL-M/41/01

*/

--use master
use master;

--Drop database shifaHospital
if db_Id('SchoolManagement') is not null
		drop database SchoolManagement

--create new database
CREATE DATABASE SchoolManagement
on (
	name = schoolmanagement_data,
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\SchoolManagement.mdf',
	size = 15 mb,
	maxsize = 100 mb,
	filegrowth = 10%
	)
Log on (
	name = shifaHospital_log,
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\SchoolManagement_log.ldf',
	size = 10 mb,
	maxsize = 50 mb,
	filegrowth = 5%
	)
go
use SchoolManagement;
go
create table Student(
	studentId int primary key,
	sName varchar(50) not null,
	sEmail varchar(50) ,
	sPhone varchar(11),
	sDoB date,
	sStatus bit default 0,
	sAdmissionDate date default(getdate())
)


go
create table Teacher(
	teacherId int primary key,
	teacherName varchar(50) not null,
	teacherEmail varchar(50) ,
	teacherPhone varchar(11),
	teacherDoB date,
	teacherStatus bit
)

go
create table Subjects(
	subjectsId int primary key,
	subjectsName varchar(50),
	
)

go
create table Class(
	classId int primary key,
	className varchar(50),
	classFee money default 0,
	classExamFee money default 0,
	classMaxStudent int not null
)

go
Create table ClassSubject(
	classId int references Class(classId) not null,
	subjectId int references Subjects(subjectsId) not null,
	subjectsTeacher int references  Teacher(teacherId) not null,


)

								
go
Create table ClassStudent(
	csId int primary key,
	classId int references Class(classId) not null,
	studentId int references Student(studentId) not null,
	joinDate date default(getdate()),
	isPass bit default 0,
	gpa decimal default 0
)

go
create table Fee(
	feeId int primary key,
	feePayDate date default(getdate()),
	feeType varchar(10) not null,
	feeAmount money default 0
)
go
create table Notice(
	noticeId int primary key,
	noticeTitle varchar(200) not null,
	noticeDescriptiion varchar(max),
	noticeDate date
)
go
/*////////////////////////////////////////////////
//////////// STORE PROCEDURE \\\\\\\\\\\\\\\\\\\\
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ */

create proc sp_student	
	@studentName varchar(50) not null,
	@studentEmail varchar(50) ,
	@studentPhone varchar(11),
	@studentDoB date,
	@studentStatus bit ,
	@studentAdmissionDate date 
as
	begin
		insert into dbo.Student(sName,sEmail,sPhone,sDoB,sStatus,sAdmissionDate)
		values(@studentName,@studentEmail,@studentPhone,@studentDoB,@studentStatus,@studentAdmissionDate)
	end

go
create proc sp_subjects
	@subjectsName varchar(50)
as
	begin
		insert into dbo.Subjects(subjectsName)
		values(@subjectsName)
	end
go
/*////////////////////////////////////////////////
//////////// Nonclustered Index \\\\\\\\\\\\\\\\\\\\
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ */

create index in_teacher
on dbo.Teacher(teacherName);

go

/*////////////////////////////////////////////////
//////////// Insert Data \\\\\\\\\\\\\\\\\\\\
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ */

--using STORE PROCEDURE
exec sp_student 'Kamal','kamal@mail.com','01777777777','07-15-2010','0','07-15-2019'
exec sp_student 'Kamal','jamal@mail.com','01777777770','07-15-2011','1','07-15-2018'
exec sp_student 'Sadek','sadek@mail.com','01777777772','07-15-2000','0','07-15-2015'
go
exec sp_subjects 'English'
exec sp_subjects 'Bangla'
exec sp_subjects 'Mathematics'

go
insert into Teacher values('Razzak','razzak@mail.com','01555555555','07-15-1990',1),
							('Nasrin','nasrin@mail.com','01555555550','07-15-1958',1),
							('Jalal','jalal@mail.com','01555555558','07-15-1980',1)

go
insert into Class values('One',250,500,20),
						('Two',250,500,20),
						('Three',300,500,20)
						
go
insert into ClassSubject values(1,1,1),
								(1,2,2),
								(1,3,3),
								(2,1,1),
								(2,2,2),
								(2,2,2),
								(3,1,1),
								(3,2,2),
								(3,3,3)
go

