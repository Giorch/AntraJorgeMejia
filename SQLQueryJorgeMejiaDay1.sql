
--1
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product

--2
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice != 0

--3
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color is null

--4
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color is not null

--5
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color is not null and ListPrice > 0

--6
SELECT Name + '  ' + Color "Name Color"
FROM Production.Product
WHERE Color is not null

--7
SELECT 'NAME: ' + Name + ' -- COLOR: ' + Color "Name and Color"
FROM Production.Product
WHERE Color is not null

--8
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID BETWEEN 400 and 500

--9
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IN ('Black' , 'Blue')

--10
SELECT ProductID, Name
FROM Production.Product
WHERE Name like ('S%')

--11
SELECT Name, ListPrice
FROM Production.Product
WHERE Name like ('S%')
ORDER BY Name

--12
SELECT	Name, ListPrice
FROM Production.Product
WHERE Name like '[A S]%'
ORDER BY Name

--13
SELECT Name
FROM Production.Product
WHERE Name like('SPO[^K]%')

--14
SELECT DISTINCT Color
FROM Production.Product
ORDER BY Color DESC

--15
SELECT DISTINCT Color, ProductSubcategoryID
FROM Production.Product
WHERE Color is not null and ProductSubcategoryID is not null
ORDER BY ProductSubcategoryID