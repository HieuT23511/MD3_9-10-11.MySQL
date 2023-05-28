drop database QuanLySinhVien;
create database QuanLySinhVien;
use QuanLySinhVien;
create table class (
	classID int primary key auto_increment,
    className varchar(60) not null,
    startDate datetime not null,
    status bit
);
create table Student (
	studentID int primary key auto_increment,
    studentName varchar (30) not null,
	address varchar (50),
    phone varchar(20),
    status bit,
    classID int not null,
    foreign key (classID) references class (classID)
);
create table Subject (
	subID int primary key auto_increment,
    subName varchar(30) not null,
    credit tinyint not null default 1 check (credit >=1),
    status bit default 1
);
create table Mark (
	markID int primary key auto_increment,
    subID int not null,
    studentID int not null,
    unique (subID, studentID),
    mark float default 0 check(mark between 0 and 100),
    examTimes tinyint default 1,
    foreign key (subID) references Subject(subID),
    foreign key (studentID) references Student(studentID)
);

INSERT INTO Class VALUES (1, 'A1', '2008-12-20', 1),
(2, 'A2', '2008-12-22', 1),
(3, 'B3', current_date, 0);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1),
('DucAnh', 'Ha Noi', '0962113113', 1, 1),
('Hoa', 'Hai phong',null, 1, 1),
('Manh', 'HCM', '0123123123', 0, 2);
INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 18, 1),
       (1, 2, 10, 2),
       (2, 3, 12, 1),
       (2, 1, 22, 1);
select*from Student; 
select*from Class;
-- select*from Student where status = true;
-- select * from Subject where credit <10
-- select Student.studentID,Student.studentName,Class.className from Class left join Student on Student.classID = Class.classID ;

-- Hiển thị tất cả các điểm đang có của học viên
select Student.studentName, Class.className, Mark.mark, Subject.subName from Student 
join Class on Class.classID = Student.classID
join Mark on Student.studentID = Mark.studentID 
join Subject on Mark.subID = Subject.subID 
where Subject.subName = 'CF';


-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select * from Student where StudentName like 'h%';


-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select  * from Class where month(startDate) = 12;


-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select * from Subject where Credit between 3 and 5;


-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
set sql_safe_updates = 1;
update Student set classID = 2 where studentID = 1;



-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select Student.studentName, Subject.subName, Mark.mark from Student 
join Mark on Mark.studentID = Student.studentID
join Subject on Mark.subID = Subject.subID
order by Mark.mark desc, Student.studentName asc;

-- Hiển thị số lượng sinh viên ở từng nơi
select address, count(studentID)
from Student
group by address;

-- Tính điểm trung bình các môn học của mỗi học viên
select s.studentName, s.studentID, avg(mark) 
from student s
join mark m on s.studentID = m.studentID
group by s.studentName, s.studentID;


-- Hiển thị những bạn học viên co điểm trung bình các môn học lớn hơn 15
select s.studentName, s.studentID, avg(mark)
from student s
join mark m on s.studentID = m.studentID 
group by s.studentID
having avg(mark)>15;

-- Hiển thị thông tin các học viên có điểm trung bình lớn nhất.
select s.studentName, s.studentID, avg(mark)
from student s
join mark m on s.studentID = m.studentID
group by s.studentID 
having avg(mark) >= all (select avg(mark) from mark group by mark.studentID);

-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select subName, credit
from subject sj
having sj.credit = (select max(credit) from subject);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select subName, mark 
from subject sj
join mark m on sj.subID = m.subID
having m.mark = (select max(mark) from mark);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần.
select s.*, avg(mark)
from student s 
join mark m on s.studentID = m.studentID
group by s.studentID 
order by avg(mark) desc; 








