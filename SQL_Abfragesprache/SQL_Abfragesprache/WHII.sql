-- WH 2


-- WHERE
-- Einschränkungen; Bedingungen abfragen
-- Vergleiche
-- Operatoren: =, >, <, <=, >=, !=; <>

-- Spaltenname LIKE '...'
-- LIKE?
-- "Wildcards"
-- LIKE '%c' -- beliebig viele Zeichen, endet mit c
-- LIKE '_c' -- genau ein unbekanntes Zeichen vor dem c
-- LIKE '[a-c]%' -- Wertebereich a-c, danach beliebig viele Zeichen
-- LIKE '[a-c | m-o]%' -- | steht für ODER
-- LIKE '[^a-c]%' -- darf NICHT mit a-c beginnen

-- IN, BETWEEN
-- WHERE ProductID IN(3, 5, 15) - Wo ProduktID 3, 5 oder 15 ist
-- WHERE Country IN('Germany', 'Austria')
-- WHERE ProductID BETWEEN 20 AND 25
-- AND, OR
-- NOT, NOT LIKE, NOT IN, NOT BETWEEN 


-- JOINS
-- INNER JOIN, OUTER JOIN
-- OUTER JOIN: LEFT JOIN, RIGHT JOIN


-- OrderID, CustomerID, CompanyName, Freight
SELECT	  OrderID
		, Customers.CustomerID
		, CompanyName
		, Freight
FROM Orders INNER JOIN Customers ON Customers.CustomerID = Orders.CustomerID


SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, o.Freight
FROM Orders o INNER JOIN Customers c ON c.CustomerID = o.CustomerID



-- Gib OrderID, KundenID, Firmenname, Kontaktperson und Telefonnummer, Lieferadresse und Frachtkosten aller Kunden aus

-- Welche Tabellen brauche ich?
-- Customers, Orders 

SELECT OrderID
		, c.CustomerID
		, CompanyName
		, ContactName
		, Phone
		, Address
		, Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID



--Suche alle Bestellungen, bei denen Bier verkauft wurde. Welcher Kunde? Wieviel? Welches Bier?
--Tipp: Der Produktname kann „Bier“ oder „Lager“ enthalten oder mit „Ale“ enden.
--Nach Menge und Kundenname geordnet:
--	Menge absteigend (größte zuerst), 	Kundenname aufsteigend (A-Z)


-- Welche Tabellen brauche ich?
-- Customers, Orders, Order Details, Products

SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, p.ProductName
		, d.Quantity
FROM [Order Details] d INNER JOIN Products p ON d.ProductID = p.ProductID
					   INNER JOIN Orders o ON o.OrderID = d.OrderID
					   INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE p.ProductName LIKE '%bier%' OR p.ProductName LIKE '%lager%' OR ProductName LIKE '%ale'
ORDER BY d.Quantity DESC, c.CompanyName 



-- nach mehreren Spalten ordnen
SELECT	  CustomerID
		, CompanyName
		, Country
		, City
FROM Customers
ORDER BY Country, City



-- Welche Angestellten haben Chai Tee verkauft und an wen?
-- OrderID, CustomerID, CompanyName, EmployeeID, Name des Angestellten (Vor- und Nachname), optional: ProductName

SELECT	  e.EmployeeID
		, CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName
		, o.OrderID
		, c.CustomerID
		, c.CompanyName
		, p.ProductName
FROM Employees e INNER JOIN Orders o On e.EmployeeID = o.EmployeeID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
				 INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE p.ProductName LIKE '%chai%'
