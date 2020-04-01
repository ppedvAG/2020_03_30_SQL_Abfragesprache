-- WHERE
-- WHERE clause, WHERE-Klausel, WHERE-Bedingung

/*
	SELECT	  Spalte1
			, Spalte2
			, ...
	FROM Tabellenname
	WHERE Bedingung



	WHERE Operatoren

		=, <, >, <=, >=
		!=, <> -- darf NICHT einem bestimmten Wert entsprechen


	AND -- es müssen zwingend BEIDE Bedingungen erfüllt sein
	OR -- es muss das eine ODER das andere ODER aber auch beide erfüllt sein (es muss mindestens eine der beiden Bedingungen zutreffen)


*/


-- damit bekommen wir ALLE Spalten
-- und ALLE Kunden (91)
SELECT *
FROM Customers


-- nur bestimmte Spalten:
-- aber immer noch ALLE Kunden (91 Zeilen)
SELECT	  CustomerID
		, CompanyName
		, ContactName
		, Phone
FROM Customers


-- wir wollen nicht mehr alle Kunden, sondern nur noch bestimmte:
SELECT	  CustomerID
		, CompanyName
		, ContactName
		, Phone
		, Country
FROM Customers
WHERE Country = 'Germany'
-- 11 Kunden in Deutschland


-- die Kunden, die in Deutschland in Berlin sind
SELECT	  CustomerID
		, CompanyName
		, ContactName
		, Phone
		, Country
FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'
-- 1 Kunde in Berlin: ALFKI	Alfreds Futterkiste	Maria Anders	030-0074321	Germany


-- alle deutschen und österreichischen Kunden?
SELECT	  CustomerID
		, CompanyName
		, ContactName
		, Phone
		, Country
FROM Customers
WHERE Country = 'Germany' OR Country = 'Austria'
-- 13 Kunden


-- alle Bestellungen, wo Frachtkosten unter 100 sind
SELECT Freight
FROM Orders
WHERE Freight < 100


-- alle Bestellungen, wo Frachtkosten NICHT 148.33 sind
SELECT Freight
FROM Orders
WHERE Freight != 148.33


-- Ausgabe anordnen
SELECT Freight
FROM Orders
WHERE Freight != 148.33
ORDER BY Freight ASC -- ascending (aufsteigend, vom kleinsten zum größten Wert; bei Text von A-Z) - Default; wir können es dazuschreiben, müssen aber nicht


SELECT Freight
FROM Orders
WHERE Freight != 148.33
ORDER BY Freight DESC -- descending (absteigend, vom größten zum kleinsten Wert; bei Text von Z-A)



-- Gib nur die Kunden aus, die in Frankreich ansässig sind.
SELECT *
FROM Customers
WHERE Country = 'France'



-- Gib alle Kunden aus, die in Buenos Aires in Argentinien ansässig sind.
SELECT CustomerID, ContactName, City, Country
FROM Customers
WHERE Country = 'Argentina' AND City = 'Buenos Aires'

--SELECT CustomerID, ContactName, City, Country
--FROM Customers
--WHERE Country = 'Germany' OR City = 'Berlin'
-- dieses OR bedeutet, dass wir auch alle anderen Kunden aus Deutschland herausbekommen, nicht nur die aus Berlin



-- Gib alle portugiesischen und spanischen Kunden aus.
SELECT *
FROM Customers
WHERE Country = 'Spain' OR Country = 'Portugal'
ORDER BY Country


-- Gib alle Produkte aus, von denen mehr als 100 vorhanden sind.
SELECT ProductID, UnitsInStock, ProductName
FROM Products
WHERE UnitsInStock > 100
ORDER BY ProductName


-- alle Bestellungen, wo Frachtkosten größer als 100, aber kleiner als 200
SELECT	  OrderID
		, Freight
FROM Orders
WHERE Freight < 200 AND Freight > 100
ORDER BY Freight -- 100,22  / 197,30




SELECT	  OrderID
		, Freight
FROM Orders
WHERE Freight <= 200 AND Freight >= 100
ORDER BY Freight

-- ODER:


-- Bereiche abfragen mit BETWEEN
SELECT	  OrderID
		, Freight
FROM Orders
WHERE Freight BETWEEN 100 AND 200  -- BETWEEN macht <= und >=
ORDER BY Freight



-- alle Bestellungen, die vom Angestellten Nr. 3, 4, 7 bearbeitet worden sind
SELECT	  OrderID
		, Freight
		, EmployeeID
FROM Orders
WHERE EmployeeID = 3 OR EmployeeID = 4 OR EmployeeID = 7
ORDER BY EmployeeID


-- ODER:
SELECT	  OrderID
		, Freight
		, EmployeeID
FROM Orders
WHERE EmployeeID IN(3, 4, 7)
ORDER BY EmployeeID



-- Gib alle Produkte aus, deren ProduktID zwischen 10 und 15 (inklusive) liegt.
SELECT ProductID, ProductName
FROM Products
WHERE ProductID BETWEEN 10 AND 15
ORDER BY ProductName

-- geht auch, da haben wir aber keinen Produktnamen dabei
SELECT ProductID, UnitPrice
FROM [Order Details]
WHERE ProductID BETWEEN 10 AND 15
ORDER BY ProductID


-- alle Produkte wo der Stückpreis zwischen 10 und 15 liegt
SELECT ProductID, UnitPrice
FROM [Order Details]
WHERE UnitPrice BETWEEN 10 AND 15


-- Gib alle Produkte aus, die vom Anbieter (SupplierID) 2, 7 oder 15 geliefert werden.
SELECT	  ProductID
		, ProductName
		, SupplierID
FROM Products
WHERE SupplierID IN(2, 7, 15)
ORDER BY SupplierID

