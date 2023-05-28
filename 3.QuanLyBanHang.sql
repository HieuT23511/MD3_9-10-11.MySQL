drop database quanlybanhang;
create database quanlybanhang;
use quanlybanhang;

create table Customer(
	cID int primary key auto_increment,
    cName varchar(20) not null,
    cAge int check(cAge between 0 and 150)
);

create table `Order`(
	oID int primary key auto_increment,
    cID int,
    oDate date,
    oTotalPrice float default null check(oTotalPrice >= 0),
    foreign key (cID) references Customer(cID)
);

create table Product(
	pID int primary key auto_increment,
    pName varchar(50) not null,
    pPrice float not null check(pPrice >= 0)
);

create table OrderDetail(
	oID int,
    pID int,
    primary key (oID, pID),
    odQTY int not null check(odQTY >= 0),
    foreign key (oID) references `Order`(oID),
    foreign key (pID) references Product(pID)
);

insert into Customer(cName,cAge) 
values ('Minh Quan',10),
('Ngoc Oanh',20),
('Hong Ha',50);

insert into `Order` (cID,oDate) 
values (1,'2006-03-21'),
(2,'2006-03-26'),
(1,'2006-3-21');

insert into Product (pName,pPrice) 
values ('May Giat',3),
('Tu Lanh',5),
('Dieu Hoa',7),
('Quat',1),
('Bep Dien',2);

insert into OrderDetail (oID,pID,odQTY) 
values (1,1,3), (1,3,7),(1,4,2),(2,1,1),(3,1,8),(2,5,4),(2,3,3);

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select (oID,oDate,oTotalPrice) `Order`;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select Customer.cName, Product.pName from Customer 
join `Order` on Customer.cID = `Order`.cID 
join OrderDetail on `Order`.oID = OrderDetail.oID
join Product on OrderDetail.pID = Product.pID;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT cName
FROM Customer
LEFT JOIN `Order` ON Customer.cID = `Order`.cID
where `Order`.oID is null
;

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. 
-- Giá bán của từng loại được tính = odQTY*pPrice)
select o.oID as MaHoaDon, o.oDate as NgayBan, sum(od.odQTY * p.pPrice) as GiaTien
from `Order` as o
join OrderDetail as od on o.oID = od.oID
join Product as p on od.pID = p.pID
group by o.oID, o.oDate;



