create database assessment04Db
use assessment04Db
create table Products
(PId int primary key IDENTITY(500,1) ,
PName nvarchar(50) not null,
 PPrice float,
    PTax as(PPrice*0.1)Persisted,
    PCompany nvarchar(50) NOT NULL,
    PQty int  CHECK (PQty >= 1),
    CONSTRAINT CK_PPrice CHECK (PPrice >= 1),
    CONSTRAINT CK_PCompany CHECK (PCompany IN ('SamSung', 'Apple', 'Redmi', 'HTC', 'RealMe', 'Xiaomi'))
)
insert into Products values('Fridge',9900.90,'SamSung',10)
insert into Products values('Tab',8900.90,'Apple',20)
insert into Products values('Mobile',4500.90,'SamSung',30)
insert into Products values('AC',3300.90,'RealMe',40)
insert into Products values('Cooler',2300.90,'Xiaomi',60)
insert into Products values('Fan',7800.90,'SamSung',50)
insert into Products values('Invetor',8800.90,'SamSung',70)
insert into Products values('TV',2400.90,'HTC',80)
insert into Products values('Laptop',9400.90,'Apple',90)
insert into Products values('BlueTooth',7400.90,'Readme',100)

select *from Products

create proc usp_ProductDetails
as
begin
select PId,PName,PPrice+PTax as PriceWithTax,PCompany,(PQty*(PPrice+PTax)) as TotalPrice from Products
end

---------------------------------------------------
create proc GetTotalTax
@company varchar(50),
@TotalTax float output
with encryption
as 
select @TotalTax=sum(PTax) from Products where PCompany=@company


declare @TaxCount float
exec GetTotalTax 'Apple',@TaxCount output
print @TaxCount
drop proc GetTotalTax