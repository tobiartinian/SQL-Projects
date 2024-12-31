USE AdventureWorks2022

-- 1) Lista los nombres de los productos y sus precios de la tabla Production.Product.
SELECT Name, ListPrice 
FROM Production.Product;

-- 2) Encuentra los productos cuyo precio (ListPrice) sea mayor a 500.
SELECT Name, ListPrice 
FROM Production.Product
WHERE ListPrice >500;

-- 3) Obt�n los 10 productos m�s caros y ord�nalos de mayor a menor.
SELECT TOP 10 Name, ListPrice
FROM Production.Product
ORDER BY Listprice DESC

-- 4) Encuentra el precio promedio de todos los productos y el precio m�s alto.
SELECT AVG(LISTPRICE) AS AVG_PRICE, MAX(LISTPRICE) AS MAX_PRICE
FROM Production.Product

-- 5) Muestra los nombres de los productos y las categor�as a las que pertenecen.
SELECT p.Name AS ProductName, pc.Name AS CategoryName
FROM Production.Product p
INNER JOIN Production.ProductCategory pc
ON p.ProductSubcategoryID = pc.ProductCategoryID;

-- 6) Encuentra todos los productos cuyo nombre contenga "Mountain".
SELECT Name, ListPrice 
FROM Production.Product
WHERE Name LIKE '%Mountain%'

-- 7) Lista los productos que tienen un precio mayor al precio promedio de todos los productos.
SELECT Name, ListPrice 
FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product);

-- 8) Muestra los 5 productos m�s caros de cada subcategor�a.
SELECT Name, ProductSubcategoryID, ListPrice, 
       ROW_NUMBER() OVER (PARTITION BY ProductSubcategoryID ORDER BY ListPrice DESC) AS Rank
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
ORDER BY ProductSubcategoryID, Rank;

