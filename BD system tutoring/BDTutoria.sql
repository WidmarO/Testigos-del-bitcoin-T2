use Master
go
----creacion de la base de datos
if exists (select * from sysdatabases where name ='BDTutoria')
begin
	drop database BDTutoria
end
go
create database BDTutoria
go

------creacion de las tablas---------
use BDTutoria
go
------------------------------------------------
create table tutoring_programs
(
	cod_tutoring_program varchar(8) not null,
	title varchar(100) not null,
	i_date datetime not null,
	f_date datetime not null,
	semester varchar(10) not null,
	condition bit not null,
	primary key(cod_tutoring_program)
)

create table teachers
(
	cod_teacher varchar(8),
	name varchar(40),
	f_lastname varchar(20),
	m_lastname varchar(20),
	phone varchar(20),
	mail varchar(100),
	cod_tutoring_program varchar(8),
	primary key(cod_teacher),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)

create table principals
(
	cod_principal varchar(8),
	cod_teacher varchar(8),
	cod_tutoring_program varchar(8),
	primary Key(cod_principal),
	foreign key(cod_teacher) references teachers(cod_teacher),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)
go
	
create table tutors
(
	cod_tutor varchar(8),
	cod_teacher varchar(8),
	cod_tutoring_program varchar(8),
	schedule varchar(20),
	place varchar(100),
	primary Key(cod_tutor),
	foreign key(cod_teacher) references teachers(cod_teacher),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)

create table coordinators
(
	cod_coordinator varchar(8),
	cod_teacher varchar(8),
	cod_tutoring_program varchar(8)
	primary Key(cod_coordinator),
	foreign key(cod_teacher) references teachers(cod_teacher),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)
go

create table students
(
	cod_student varchar(8),
	name varchar(40),
	f_lastname varchar(20),
	m_lastname varchar(20),
	phone varchar(20),
	mail varchar(100),
	cod_tutoring_program varchar(8),
	primary key(cod_student),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)

create table student_helpers
(
	cod_student_helper varchar(8),
	cod_student varchar(8),
	cod_tutoring_program varchar(8),
	primary key(cod_student_helper),
	foreign key(cod_student) references students(cod_student),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)

create table quotes
(
	cod_quote varchar(8),
	cod_tutor varchar(8),
	cod_student varchar(8),
	date_time datetime,
	g_description varchar(100),
	p_description varchar(100),
	diagnosis varchar(100),
	cod_tutoring_program varchar(8),
	primary key(cod_quote),
	foreign key(cod_student) references students(cod_student),
	foreign key(cod_tutor) references tutors(cod_tutor),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)

create table tutor_students
(
	cod_tutor varchar(8),
	cod_tutoring_program varchar(8),
	cod_student varchar(8),
	foreign key(cod_student) references students(cod_student),
	foreign key(cod_tutor) references tutors(cod_tutor),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)


create table workshops 
(
	cod_workshop varchar(8),
	cod_student_helper varchar(8),
	classroom varchar(50),
	schedule varchar(20),
	cod_tutoring_program varchar(8),
	primary key(cod_workshop),
	foreign key(cod_student_helper) references student_helpers(cod_student_helper),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)

create table workshop_attendances
(
	cod_attendance varchar(8),
	cod_workshop varchar(8),
	date_time datetime,
	cod_tutoring_program varchar(8),
	primary key(cod_attendance),
	foreign key(cod_workshop) references workshops(cod_workshop),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)

create table news
(
	cod_new varchar(8),
	title varchar(100),
	g_description varchar(100),
	whom varchar(20),
	date_time datetime,
	cod_tutoring_program varchar(8),
	primary key(cod_new),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)

create table description_workshop_attendances
(
	cod_student varchar(8),
	attendance bit not null,
	cod_attendance varchar(8)
	foreign key(cod_student) references students(cod_student),
	foreign key(cod_attendance) references workshop_attendances(cod_attendance)
)

create table workshop_students
(
	cod_workshop varchar(8),
	cod_student varchar(8),
	cod_tutoring_program varchar(8),
	foreign key(cod_student) references students(cod_student),
	foreign key(cod_workshop) references workshops(cod_workshop),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)

create table student_helper_tutors
(
	cod_tutor varchar(8),
	cod_student_helper varchar(8),
	cod_tutoring_program varchar(8),
	foreign key(cod_student_helper) references student_helpers(cod_student_helper),
	foreign key(cod_tutor) references tutors(cod_tutor),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)

create table curricular_advancements
(
	cod_advancement varchar(8),
	cod_student varchar(8),
	advancement varchar(200),
	cod_tutoring_program varchar(8),
	foreign key(cod_student) references students(cod_student),
	foreign key(cod_tutoring_program) references tutoring_programs(cod_tutoring_program)
)

create table users
(
	id int identity(1,1),
	usarname varchar(20),
	password varchar(20),
	primary Key(id)
)

create table roles
(
	cod_role varchar(8),
	role varchar(20),
	primary key(cod_role)
)

create table user_roles
(
	cod_user_role varchar(8),
	id int identity(1,1),
	cod_role varchar(8),
	primary key(cod_user_role),
	foreign key(id) references users(id),
	foreign key(cod_role) references roles(cod_role)
)