--1
SELECT Count(*) CountedProducts
FROM Production.Product

--2
SELECT Count(ProductID) CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID is not null

--3
SELECT ProductSubCategoryID, Count(ProductID) CountedProducts
FROM Production.Product
GROUP BY ProductSubcategoryID

--4
SELECT Count(ProductID)
FROM Production.Product
WHERE ProductSubcategoryID is null

--5
SELECT SUM(Quantity)
FROM Production.ProductInventory

--6
SELECT ProductID, SUM(Quantity) TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 and Quantity < 100
GROUP BY ProductID

--7
SELECT Shelf, ProductID, SUM(Quantity) TheSum	
FROM Production.ProductInventory
WHERE Shelf != 'N/A' and LocationID = 40 and Quantity < 100
GROUP BY Shelf, ProductID

--8
SELECT AVG(Quantity) TheAvg	
FROM Production.ProductInventory
WHERE LocationID = 10

--9
SELECT ProductID, Shelf, AVG(Quantity) TheAvg	
FROM Production.ProductInventory
GROUP BY Shelf, ProductID

--10
SELECT ProductID, Shelf, AVG(Quantity) TheAvg	
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY Shelf, ProductID

--11
--unfinished/not done according to instructions
SELECT Color, Class, Count(ProductID) TheCount, AVG(ListPrice) AvgPrice
FROM Production.Product
WHERE Color is not null and Class is not null
GROUP BY Color, Class

--12
Select c.Name Country , s.Name Province
FROM Person.CountryRegion c JOIN Person.StateProvince s
ON c.CountryRegionCode = s.CountryRegionCode

--13
Select c.Name Country  , s.Name Province
FROM Person.CountryRegion c JOIN Person.StateProvince s
ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name IN ('Canada', 'Germany')


USE Northwind
GO

--14
SELECT p.ProductID, p.ProductName, o.OrderDate
FROM Products p join [Order Details] od ON p.ProductID = od.ProductID join Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate > '1997-01-01 00:00:00.000'

--15
SELECT TOP 5 o.ShipPostalCode, Count(p.ProductID) ProductsSold
FROM Orders o join [Order Details] od 
ON o.OrderID = od.OrderID join Products p ON od.ProductID = p.ProductID
WHERE o.ShipPostalCode is not null
GROUP BY o.ShipPostalCode 
ORDER BY ProductsSold DESC

--16
SELECT TOP 5 o.ShipPostalCode, Count(p.ProductID) ProductsSold
FROM Orders o join [Order Details] od 
ON o.OrderID = od.OrderID join Products p ON od.ProductID = p.ProductID
WHERE o.ShipPostalCode is not null and o.OrderDate > '1997-01-01 00:00:00.000'
GROUP BY o.ShipPostalCode 
ORDER BY ProductsSold DESC

--17
SELECT DISTINCT c.City, COUNT(c.CustomerID) NumOfCustomers
FROM Orders o join Customers c ON o.ShipCity = c.City
GROUP BY c.City

--18
SELECT DISTINCT c.City, COUNT(c.CustomerID) NumOfCustomers
FROM Orders o join Customers c ON o.ShipCity = c.City
GROUP BY c.City
HAVING COUNT(c.CustomerID) > 2

--19
SELECT c.ContactName, o.OrderDate
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate > '1998-01-01 00:00:00.000'

--20
SELECT c.ContactName, o.OrderDate
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY OrderDate DESC

--21
SELECT c.ContactName, Count(p.ProductID) NumOfProducts
FROM Products p join [Order Details] od ON p.ProductID = od.ProductID 
join Orders o ON od.OrderID = o.OrderID
join Customers c ON o.CustomerID = c.CustomerID
GROUP BY ContactName

--22
SELECT c.CustomerID, Count(p.ProductID) NumOfProducts
FROM Products p join [Order Details] od ON p.ProductID = od.ProductID 
join Orders o ON od.OrderID = o.OrderID
join Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID
HAVING Count(p.ProductID) > 100

--23
SELECT s.CompanyName "Supplier Company Name", sh.CompanyName "Shipping Company Name"
FROM Suppliers s CROSS JOIN Shippers sh

--24
SELECT p.ProductName, o.OrderDate
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
ORDER BY o.OrderDate ASC

--25
SELECT e.FirstName + ' ' + e.LastName + ': ' + e.Title "Employee A", a.FirstName + ' ' + a.LastName + ': ' + a.Title "Employee B"
FROM Employees e join Employees a ON e.Title = a.Title
WHERE e.FirstName != a.FirstName and e.LastName != a.LastName

--26
SELECT a.Title, COUNT(e.ReportsTo) NumOfEmployees
FROM Employees e join Employees a ON e.ReportsTo = a.EmployeeID
GROUP by a.Title
HAVING COUNT(e.ReportsTo) > 2

--27
SELECT c.City, c.CompanyName Name, c.ContactName "Contact Name"
FROM Customers c full JOIN Suppliers s ON C.City = s.City