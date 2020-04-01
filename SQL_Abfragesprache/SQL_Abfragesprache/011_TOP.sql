-- TOP
-- ORDER BY zwingend notwendig!
-- ohne ORDER BY -> was ist die erste Zeile??



SELECT TOP 1 *
FROM Customers
-- aber was genau ist jetzt meine erste Zeile?


SELECT TOP 1 *
FROM Customers
ORDER BY PostalCode
-- was meine erste Zeile ist, ist abhängig vom ORDER BY!


SELECT TOP 3 *
FROM Customers
ORDER BY PostalCode
-- die ersten 3 Zeilen 



SELECT TOP 3 *
FROM Customers
WHERE Country = 'Germany'
ORDER BY PostalCode
-- die ersten 3 nur von den deutschen Kunden


SELECT TOP 3 PERCENT *
FROM Customers
ORDER BY PostalCode
-- Top 3 %


-- wie bekommen wir die letzten 3?
SELECT TOP 3 *
FROM Customers
WHERE Country = 'Germany'
ORDER BY PostalCode DESC
-- mit DESC



-- Gib das teuerste Produkt aus.
SELECT TOP 1 *
FROM Products
ORDER BY UnitPrice DESC

-- überprüfen:
SELECT *
FROM Products
ORDER BY UnitPrice DESC



SELECT TOP 11 *
FROM Products
ORDER BY UnitPrice DESC



SELECT TOP 11 WITH TIES *
FROM Products
ORDER BY UnitPrice DESC


--Suche die Top 10% der Produkte mit den größten Verkaufsmengen (ProductName, Quantity).
--Einschließlich Produkte mit der gleichen Einkaufsmenge wie das letzte in der ursprünglichen Ausgabe.

-- Welche Tabellen brauche ich?
-- Products, Order Details
-- Was brauche ich noch alles?
-- größte Verkaufsmenge: ORDER BY Quantity DESC
-- was kommt ins SELECT?
-- ProductName, Quantity
-- wie bekomme ich die TOP 10%?
-- SELECT TOP 10 PERCENT
-- wie bekomme ich Produkte mit gleicher Einkaufsmenge?
-- WITH TIES

SELECT TOP 10 PERCENT WITH TIES Products.ProductName, [Order Details].Quantity
FROM [Order Details] INNER JOIN Products ON Products.ProductID = [Order Details].ProductID
ORDER BY [Order Details].Quantity DESC


-- Gib die drei Mitarbeiter, die als erste eingestellt wurden, aus (die schon am längsten beim Unternehmen sind).
-- Wähle nicht alle, sondern nur einige in diesem Zusammenhang sinnvolle Spalten aus.

SELECT TOP 3	  HireDate
				, EmployeeID
				, LastName
FROM Employees
ORDER BY HireDate

-- überprüfen
SELECT *
FROM Employees

-- Datum schöner:
SELECT TOP 3	  FORMAT(HireDate, 'dd.MM.yyyy') AS HireDate
				, EmployeeID
				, LastName
FROM Employees
ORDER BY HireDate

-- oder so:
SELECT TOP 3	  CONVERT(varchar, HireDate, 104) AS HireDate
				, EmployeeID
				, LastName
FROM Employees
ORDER BY HireDate

-- oder so:
SELECT TOP 3	  FORMAT(HireDate, 'd', 'de-de') AS HireDate
				, EmployeeID
				, LastName
FROM Employees
ORDER BY HireDate


-- und FullName:
SELECT TOP 3	  FORMAT(HireDate, 'd', 'de-de') AS HireDate
				, EmployeeID
				, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees
ORDER BY HireDate



-- 13 Kunden mit den geringsten Frachtkosten bekommen Bonus (Annahme)
-- wer sind die Glücklichen?
SELECT TOP 13 WITH TIES   c.CustomerID
						, c.CompanyName
						, o.Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY o.Freight ASC
-- 13
-- with ties 14