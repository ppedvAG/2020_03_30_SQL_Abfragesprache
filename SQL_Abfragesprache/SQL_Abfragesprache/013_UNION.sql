-- UNION


-- bisher: Tabelle mit mehr Spalten

SELECT	  c.ContactName
		, c.ContactTitle
		, c.Phone
		, s.ContactName
		, s.ContactTitle
		, s.Phone
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
				 INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID



-- nur die Kontaktpersonen aus der Customers Tabelle:
SELECT	  ContactName
		, ContactTitle
		, Phone
FROM Customers

-- nur die Kontaktinformationen von den Suppliers:
SELECT	  ContactName
		, ContactTitle
		, Phone
FROM Suppliers


-- mit UNION k�nnen wir mehrere Abfragen miteinander kombinieren:
SELECT 'Testtext1'
UNION
SELECT 'Testtext2'



-- wir m�ssen bei UNION die gleiche Anzahl an Spalten haben!
-- geht NICHT:
SELECT CompanyName, Phone
FROM Customers
UNION
SELECT HomePhone
FROM Employees

-- das geht: (gleiche Anzahl an Spalten)
SELECT CompanyName, Phone
FROM Customers
UNION
SELECT LastName, HomePhone
FROM Employees



-- geht NICHT:
SELECT CustomerID, Country -- CustomerID sind keine Zahlen, sondern Buchstaben!
FROM Customers
UNION
SELECT OrderID, ShipCountry
FROM Orders
-- Conversion failed when converting the nvarchar value 'ALFKI' to data type int.
-- in einer Spalte muss der gleiche Datentyp stehen!!
-- (oder zumindest kompatible Datentypen)


-- geht nicht - Datentypen!
SELECT 100
UNION
SELECT 'Text'

-- geht NICHT - nicht die gleiche Anzahl an Spalten!
SELECT 100, 'Text'
UNION
SELECT 200


-- das geht: (gleiche Anzahl an Spalten, gleiche Datentypen)
SELECT 100, 'Text1'
UNION
SELECT 200, 'Text2'


-- geht, aber SINN?
SELECT 100, 'Text1'
UNION
SELECT 200, 'blabla'

-- geht, aber SINN? (gleiche Datentypen, aber jetzt mit sinnlosem Text aufgef�llt)
SELECT 100, LastName
FROM Employees
UNION
SELECT 200, 'blabla'


-- geht, aber SINN? (muss von Fall zu Fall entschieden werden, ob wir fehlende Spalten mit NULL auff�llen wollen)
SELECT EmployeeID, LastName
FROM Employees
UNION
SELECT SupplierID, NULL
FROM Suppliers



-- eine Liste von allen Kontaktpersonen aus Customers UND Suppliers:

SELECT	  ContactName
		, ContactTitle
		, Phone
FROM Customers
UNION
SELECT	  ContactName
		, ContactTitle
		, Phone
FROM Suppliers



-- Gib alle Regionen der Kunden und der Angestellten in einer Liste aus.
SELECT Region
FROM Customers
UNION
SELECT Region
FROM Employees


-- kann ich dazuschreiben, ob es Customers oder Employees sind?
SELECT EmployeeID, 'Hallo'
FROM Employees

-- Gib alle Regionen der Kunden und der Angestellten in einer Liste aus.
-- F�ge eine Kategorie hinzu
SELECT Region, 'C' AS Category
FROM Customers
UNION
SELECT Region, 'E' --AS Catogory
FROM Employees



--Gib den Firmennamen, die Kontaktperson und die Telefonnummern aller Kunden und aller Supplier in einer Liste aus.
--F�ge eine Kategorie �C� f�r Customer und �S� f�r Supplier hinzu.
SELECT	  CompanyName
		, ContactName
		, Phone
		, 'C' AS Category
FROM Customers
UNION
SELECT	  CompanyName
		, ContactName
		, Phone
		, 'S' AS Category
FROM Suppliers


-- ein UNION macht zugleich auch ein DISTINCT!!
SELECT 'Testtext'
UNION
SELECT 'Testtext'



-- wenn man das NICHT m�chte, machen wir ein UNION ALL:
SELECT 'Testtext'
UNION ALL
SELECT 'Testtext'
-- damit bekommen wir auch doppelte Eintr�ge/ Mehrfacheintr�ge




-- h�chste und niedrigste Frachtkosten in einer Liste?


-- langsam:
-- wie bekomme ich die h�chsten Frachtkosten:
SELECT TOP 1 Freight
FROM Orders
ORDER BY Freight DESC


-- �berpr�fen:
SELECT Freight
FROM Orders
ORDER BY Freight DESC
-- stimmt

-- wie bekomme ich die niedrigsten Frachtkosten:
SELECT TOP 1 Freight
FROM Orders
ORDER BY Freight


-- h�chste und niedrigste Frachtkosten in einer Liste
SELECT TOP 1 OrderID, Freight, 'niedrigste Frachtkosten'
FROM Orders
ORDER BY Freight -- das ORDER BY geht nicht!
UNION
SELECT TOP 1 OrderID, Freight, 'h�chste Frachtkosten'
FROM Orders
ORDER BY Freight DESC
-- das ORDER BY oben weglassen hilft auch nicht, dann bekommen wir einen falschen Wert heraus



-- mit tempor�ren Tabellen funktioniert es:

SELECT TOP 1 OrderID, Freight, 'niedrigste Frachtkosten' AS Wert
INTO #n
FROM Orders
ORDER BY Freight

-- DROP TABLE #n


SELECT TOP 1 OrderID, Freight, 'h�chste Frachtkosten' AS Wert
INTO #h
FROM Orders
ORDER BY Freight DESC


SELECT *
FROM #n
UNION
SELECT *
FROM #h


-- min/max?
-- solange wir nur eine Spalte verwenden, gehts auch mit min/max:
SELECT MIN(Freight) AS Freight
FROM Orders
UNION
SELECT MAX(Freight) AS Freight
FROM Orders

-- geht:
SELECT MIN(Freight) AS Freight, 'niedrigster Wert' AS Wert
FROM Orders
UNION
SELECT MAX(Freight) AS Freight, 'h�chster Wert' AS Wert
FROM Orders

-- geht NICHT:
SELECT OrderID, MIN(Freight) AS Freight, 'niedrigster Wert' AS Wert
FROM Orders
UNION
SELECT OrderID, MAX(Freight) AS Freight, 'h�chster Wert' AS Wert
FROM Orders
