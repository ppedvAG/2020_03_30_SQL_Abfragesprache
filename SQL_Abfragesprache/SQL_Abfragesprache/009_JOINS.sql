-- Tabellen miteinander verknüpfen: JOINS

-- INNER JOIN


-- OUTER JOINS:
		-- LEFT JOIN
		-- RIGHT JOIN





SELECT *
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID


-- einschränken, welche Spalten angezeigt werden sollen
-- wenn Spaltenname in beiden Tabellen, MUSS angegeben werden, wo sie herkommt
SELECT	  OrderID
		, Customers.CustomerID -- aus Customer-Tabelle
		, CompanyName
		, Address
		, Freight
--		, ...
FROM Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID



-- ich DARF, muss aber nicht, bei allen angeben, aus welcher Tabelle sie kommen
-- wenn Name in mehreren Tabellen vorkommt, also nicht eindeutig ist, MUSS ich Tabelle angeben
-- empfohlen: angeben!
SELECT	  Orders.OrderID
		, Customers.CustomerID -- aus Customer-Tabelle
		, Customers.CompanyName
		, Customers.Address
		, Orders.Freight
--		, ...
FROM Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID


-- bisschen kürzere Schreibweise:
SELECT	  o.OrderID
		, c.CustomerID -- aus Customer-Tabelle
		, c.CompanyName
		, c.Address
		, o.Freight
--		, ...
FROM Orders AS o INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID


-- das AS dürfen wir auch weglassen:
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, c.Address
		, o.Freight
--		, ...
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID



-- auch hier können wir weiter einschränken mit WHERE:
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, c.Address
		, o.Freight
--		, ...
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE Country = 'Germany'


-- auch hier können wir natürlich mit ORDER BY die Ausgabereihenfolge angeben
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, c.Address
		, o.Freight
--		, ...
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE Country = 'Germany'
ORDER BY CustomerID



-- Gib die Namen der Anbieter (Supplier), die Sauce verkaufen, aus. (CompanyName, ProductName, Ansprechperson, Telefonnummer). 
-- Achtung: Wie heißt das Produkt/die Produkte? Verschiedene Möglichkeiten?
SELECT	  s.SupplierID
		, s.CompanyName
		, p.ProductName
		, s.ContactName
		, s.Phone
FROM Suppliers s INNER JOIN Products p ON s.SupplierID = p.SupplierID
WHERE p.ProductName LIKE '%sauce%'

-- 2 Treffer


-- alle Kunden
SELECT	  CustomerID
		, CompanyName
FROM Customers


-- gibt es Kunden, die noch nichts bestellt haben?
SELECT	  OrderID
		, CustomerID
FROM Orders
WHERE OrderID IS NULL
-- das bringt uns nix, weil OrderID gibt es nur, wenn schon eine Bestellung getätigt wurde



SELECT	  c.CustomerID
		, o.OrderID
		, c.CompanyName
--		, ...
FROM Customers c RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
-- da kommt nix raus


SELECT	  c.CustomerID
		, o.OrderID
		, c.CompanyName
		, c.Country
--		, ...
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
-- 2 Treffer: die Kunden, die noch nichts bestellt haben

-- Achtung: wo steht welche Tabelle?
SELECT	  c.CustomerID
		, o.OrderID
		, c.CompanyName
--		, ...
FROM Orders o LEFT JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
-- wieder kein Ergebnis

SELECT	  c.CustomerID
		, o.OrderID
		, c.CompanyName
--		, ...
FROM Orders o RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
-- wieder die zwei Kunden, die noch nichts bestellt haben



-- alle Kunden aus den USA und den UK und ihre Frachtkosten
-- CustomerID, CompanyName, Country, Freight, ...
-- geordnet nach Land
SELECT	  c.CustomerID
		, c.CompanyName
		, c.Country
		, o.Freight
--		, ...
FROM Orders o INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' OR c.Country = 'UK'
ORDER BY c.Country

-- LEFT JOIN 178
-- RIGHT JOIN 178
-- INNER JOIN 178
-- warum überall gleich??
-- die aus den USA und den UK haben alle schon etwas bestellt
-- in diesem Fall wollen wir ein INNER JOIN, da uns die Frachtkosten interessieren, und wir somit nur Kunden brauchen, die schon etwas bestellt haben



-- Bestellnummer, OrderDate, EmployeeID, FirstName, LastName   
--                   Datum?                   FullName?
-- Bestellungen von den Angestellten Nr. 3, 5, 7

SELECT	  o.OrderID
		, o.OrderDate
		, o.EmployeeID
		, e.FirstName
		, e.LastName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE e.EmployeeID IN(3, 5, 7)

-- Bonusübungen:
SELECT	  o.OrderID
		, FORMAT(o.OrderDate, 'dd.MM.yyyy') AS OrderDate
		, o.EmployeeID
		, CONCAT(e.FirstName, ' ', e.LastName) AS FullName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE e.EmployeeID IN(3, 5, 7)
ORDER BY OrderID -- oder EmployeeID, oder ........



--Gib alle Kunden (Firmenname) aus Brasilien und deren Frachtkosten aus.
--Ordne die Ausgabe aufsteigend nach Frachtkosten.
SELECT	  c.CompanyName
		, c.CustomerID
		, o.Freight
		, c.Country
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'Brazil'
ORDER BY o.Freight
-- 83 Zeilen



-- nach mehr als einer Spalte ordnen
SELECT	  CustomerID
		, CompanyName
		, Country
		, City
FROM Customers
ORDER BY Country, City



-- mehrere Tabellen miteinander verknüpfen:
SELECT *
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID



-- Bestellnummer, OrderDate, CustomerID, CompanyName, EmployeeID, FirstName, LastName
--                   Datum?                   FullName?
-- Bestellungen von den Angestellten Nr. 3, 5, 7

SELECT	  o.OrderID
		, o.OrderDate
		, c.CustomerID
		, c.CompanyName
		, o.EmployeeID
		, e.FirstName
		, e.LastName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
			  INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE e.EmployeeID IN(3, 5, 7)
ORDER BY e.EmployeeID, CustomerID



--Welche Kunden haben Chai Tee gekauft und wieviel?
--(OrderID, CustomerID, CompanyName, ProductName, Quantity)

-- langsam:
-- Welche Tabellen brauche ich denn überhaupt?
-- Customers, Orders, Order Details, Products

-- Wie heißt das Produkt tatsächlich?
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%chai%'
ORDER BY ProductName


-- zusammenstückeln:
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, p.ProductName
		, od.Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductName LIKE '%chai%'
ORDER BY c.CustomerID, Quantity

-- 38 Zeilen


-- Gib den Namen des Anbieters, der Chai Tee verkauft, aus.
--  ProductName, CompanyName, Ansprechperson, Telefonnummer

-- langsam:
-- Welche Tabellen brauche ich dafür?
-- Products, Suppliers

-- Chai Tee??
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%chai%'
ORDER BY ProductName


-- zusammenstückeln:
SELECT	  p.ProductName
		, s.CompanyName
		, s.ContactName
		, s.Phone
FROM Suppliers s INNER JOIN Products p ON s.SupplierID = p.SupplierID
WHERE ProductName LIKE '%chai%'
-- Chai	Exotic Liquids	Charlotte Cooper	(171) 555-2222
