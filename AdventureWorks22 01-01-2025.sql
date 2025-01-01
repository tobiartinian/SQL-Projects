USE AdventureWorks2022

-- 1) Encuentra los 10 primeros productos de la tabla Production.Product ordenados alfabéticamente por su nombre. Muestra las columnas ProductID, Name y ListPrice
SELECT ProductID, Name, ListPrice
FROM Production.Product
ORDER BY Name ASC

-- 2) En la tabla Sales.SalesOrderDetail, encuentra todas las órdenes donde el precio unitario (UnitPrice) sea mayor a 1,000. Muestra las columnas SalesOrderID, ProductID, UnitPrice, y OrderQty.
SELECT SalesOrderID, ProductID, UnitPrice, OrderQty
FROM Sales.SalesOrderDetail
WHERE UnitPrice>1000

-- 3) En la tabla Sales.SalesOrderHeader, calcula el total de ventas (SubTotal) y el promedio de ventas para cada año (OrderDate). Muestra las columnas Year, TotalSales y AverageSales.
SELECT 
    YEAR(OrderDate) AS Year,
    SUM(SubTotal) AS TotalSales,
    AVG(SubTotal) AS AverageSales
FROM 
    Sales.SalesOrderHeader
GROUP BY 
    YEAR(OrderDate)
ORDER BY 
    Year;

-- 4) Obtén los nombres de los empleados y sus departamentos correspondientes. Usa las tablas HumanResources.Employee y HumanResources.Department. Muestra EmployeeID, FirstName, LastName y DepartmentName.
SELECT p.BusinessEntityID as EmployeeID, p.FirstName, p.LastName, d.Name as DepartmentName
FROM PERSON.PERSON p
INNER JOIN HumanResources.Employee e
ON e.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory edh
ON e.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Department d
ON edh.DepartmentID = d.DepartmentID
WHERE 
    edh.EndDate IS NULL

--5) Encuentra los nombres de los productos (Name) de la tabla Production.Product cuyo precio de lista (ListPrice) sea mayor al precio promedio de todos los productos.
SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice> (SELECT AVG(ListPrice) FROM Production.Product)

--6) En la tabla Person.Person, actualiza el campo Title de todos los empleados que actualmente tienen el título Mr. a Dr.. Muestra la cantidad de filas afectadas. 
UPDATE Person.Person
SET Title = 'Dr.'
WHERE Title = 'Mr.';

-- Mostrar el número de filas afectadas
SELECT @@ROWCOUNT AS RowsAffected;

--7) En la tabla Sales.SalesOrderDetail, calcula el total acumulado (running total) del precio unitario (UnitPrice) por cada producto (ProductID). Muestra ProductID, OrderQty, UnitPrice y RunningTotal.
SELECT 
    ProductID,
    OrderQty,
    UnitPrice,
    SUM(UnitPrice * OrderQty) OVER (PARTITION BY ProductID ORDER BY SalesOrderID) AS RunningTotal
FROM 
    Sales.SalesOrderDetail;