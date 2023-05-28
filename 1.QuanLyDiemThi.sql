drop database quanlydiemthi;
create database quanlydiemthi;
use quanlydiemthi;
-- HocSinh(MaHS, TenHS, NgaySinh, NgaySinh, Lop, GT)-- 
create table HocSinh(
	MaHS varchar(50) primary key,
    TenHS varchar(50),
    NgaySinh datetime,
    Lop varchar (20),
    GioiTinh varchar(20)
);

-- MonHoc(MaMH, TenMH, MaGV)--
create table MonHoc(
	MaMH varchar(20) primary key,
    TenMH varchar (50)
);

-- BangDiem(MaHS, MaMH, DiemThi, NgayKT)
create table BangDiem (
	MaHS varchar(50),
    MaMH varchar(50),
    DiemThi int,
    NgayKT datetime,
    primary key (MaHS, MaMH),
    foreign key(MaHS) references hocsinh(MaHS),
    foreign key(MaMH) references MonHoc(MaMH)
);

-- GiaoVien(MaGV, TenGV, SDT)--
create table GiaoVien (
	MaGV varchar(50) primary key,
    TenGV varchar(50),
    SDT int
);
alter table MonHoc ADD MaGV varchar(50);
alter table MonHoc ADD CONSTRAINT FK_MaGV FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV);