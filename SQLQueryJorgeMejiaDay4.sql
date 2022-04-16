
--1
CREATE VIEW view_product_order_Mejia
AS 
SELECT p.ProductID, p.ProductName, COUNT(od.Quantity) Quantity
FROM Products p join [Order Details] od on od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductID

--2
CREATE PROC sp_product_order_quantity_Mejia
@PID int,
@Quantities int out
AS
SELECT @Quantities = COUNT(od.Quantity)
FROM Products p join [Order Details]od ON p.ProductID = od.ProductID
WHERE p.ProductID = @PID

--Execute proc
declare @Quantity int
SET @Quantity = 0
EXEC sp_product_order_quantity_Mejia 1, @Quantity out
print @Quantity

--3
CREATE PROC sp_product_order_city_Mejia
@ProductNameVar nvarchar(40)
AS
SELECT TOP 5 ShipCity, SUM(od.quantity) Quantities
FROM ORDERS o JOIN [Order Details] od on o.OrderID = od.OrderID join Products p on od.ProductID = p.ProductID
WHERE p.ProductName = @ProductNameVar
GROUP BY ShipCity
ORDER BY Quantities desc

--4
CREATE TABLE city_Mejia(
Id int Primary key,
City varchar(20) not null
)
CREATE TABLE people_Mejia(
Id int Primary key,
"Name" varchar(40) not null,
City int foreign key references city_Mejia(Id)
)

Insert into city_Mejia VALUES(1, 'Seattle')
Insert into city_Mejia VALUES(2, 'Green Bay')
Insert into people_Mejia VALUES(1, 'Aaron Rodgers', 2)
Insert into people_Mejia VALUES(2, 'Russel Wilson', 1)
Insert into people_Mejia VALUES(3, 'Jody Nelson', 2)

INSERT INTO city_Mejia VALUES (3, 'Madison')

UPDATE people_Mejia
SET City = 3
WHERE City = 1

DELETE FROM city_Mejia
WHERE City = 'Seattle'

SELECT * from people_Mejia
SELECT * from city_Mejia

--5
CREATE PROC sp_birthday_employees_Mejia
AS
BEGIN
CREATE TABLE birthday_employees_Mejia(
ID int Unique,
FullName varchar(50),
birthDate datetime
)
Insert into birthday_employees_Mejia
SELECT EmployeeID, FirstName + LastName, BirthDate 
FROM Employees 
WHERE CONVERT(varchar(25),BirthDate, 126) like '%-02-%'
END

--6
--use union and check if row count is the same as the separated tables
