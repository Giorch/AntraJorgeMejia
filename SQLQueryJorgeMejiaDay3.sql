
--1
SELECT DISTINCT C.City
FROM Customers c join Employees e ON c.City = e.City

--2A
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN (SELECT City FROM Employees)

--2B
SELECT DISTINCT c.City
FROM Customers c left join Employees e ON c.City = e.City
WHERE e.EmployeeID is null

--3
SELECT p.ProductName, COUNT(od.Quantity) NumOfProducts
FROM Products p join [Order Details] od ON p.ProductID = od.ProductID join Orders o ON o.OrderID = od.OrderID
GROUP BY p.ProductName

--4
SELECT c.City, COUNT(od.Quantity) NumOfProducts
FROM Customers c join Orders o on c.CustomerID = o.CustomerID join [Order Details] od on o.OrderID = od.OrderID
GROUP BY c.City

--5A
SELECT City, COUNT(CustomerID) NumOfCustomers
FROM Customers
GROUP BY City
UNION
SELECT City, COUNT(CustomerID)
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) != 0
EXCEPT
SELECT City, COUNT(CustomerID)
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) = 1

--5B
SELECT c.City, COUNT(c.CustomerID) NumOfCustomers
FROM (SELECT City, CustomerID FROM Customers) c
GROUP BY c.City
HAVING COUNT(c.CustomerID) >= 2

--6
SELECT c.City, COUNT(DISTINCT p.CategoryID) NumOfOrders
FROM Customers c join Orders o on c.CustomerID = o.CustomerID 
join [Order Details] od on od.OrderID = o.OrderID
join Products p on p.ProductID = od.ProductID
GROUP BY c.City
HAVING COUNT(DISTINCT p.CategoryID) > 1

--7
SELECT DISTINCT c.ContactName
FROM Customers c join Orders o on c.CustomerID = o.CustomerID 
WHERE o.ShipCity != c.City

--8
SELECT TOP 5 p.ProductName, c.City, SUM(od.Quantity) QuantitiesSold, AVG(od.UnitPrice) AvgPrice
FROM Products p join [Order Details] od on p.ProductID = od.ProductID 
join Orders o ON o.OrderID = od.OrderID join Customers c ON o.CustomerID = c.CustomerID
GROUP BY p.ProductName, c.City
ORDER BY QuantitiesSold DESC

--9A
SELECT City
FROM Employees
WHERE City NOT IN (SELECT ShipCity FROM Orders)

--9B
SELECT DISTINCT e.City
FROM Employees e left join Orders o ON e.City = o.ShipCity
WHERE o.ShipCity is null

--10
SELECT TOP 1 o.ShipCity, COUNT(e.EmployeeID) NumOfOrders
FROM Employees e join Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.ShipCity IN (SELECT TOP 1 o.ShipCity
FROM Orders o join [Order Details] od ON od.OrderID = o.OrderID 
GROUP BY o.ShipCity
ORDER BY COUNT(od.Quantity) DESC)
GROUP BY o.ShipCity
ORDER BY NumOfOrders desc

--11
--When creating the table add the UNIQUE constraint to the collumn
--When selecting use the DISTINCT clause