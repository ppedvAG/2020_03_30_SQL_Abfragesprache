-- Aggregatfunktionen (aggregate functions)

-- COUNT(), AVG(), SUM(), MIN(), MAX()


SELECT Country
FROM Customers

SELECT DISTINCT Country
FROM Customers

-- zählen:
-- COUNT(*): Alles, in dem Fall wieviele Kunden gibts?
SELECT COUNT(*) AS Kundenanzahl
FROM Customers


-- wenn wir hier nur COUNT(Country) machen, bekommen wir wieder 91 raus - ein Land pro Kunde
-- wollen wir zählen, wie viele Länder es gibt, kombinieren wir das mit einem DISTINCT
SELECT COUNT(DISTINCT Country) AS Länderanzahl
FROM Customers


-- wie viele Produkte gibt es?
SELECT COUNT(*)
FROM Products
-- 77

-- oder:
SELECT COUNT(ProductID)
FROM Products
-- 77


-- Durchschnittswerte berechnen mit AVG()  (average)
-- durchschnittlicher UnitPrice?
SELECT AVG(UnitPrice)
FROM Products
-- 28,8663


-- niedrigster UnitPrice
SELECT MIN(UnitPrice)
FROM Products
-- 2.50

-- höchster UnitPrice
SELECT MAX(UnitPrice)
FROM Products
-- 263,50


-- Summe aller Frachtkosten:
SELECT SUM(Freight)
FROM Orders
-- 64942,69


-- nicht alle Frachtkosten, sondern Summe der Frachtkosten PRO Kunde
SELECT SUM(Freight) AS Freight, CustomerID
FROM Orders
GROUP BY CustomerID

-- mit zwei Spalten:
SELECT SUM(Freight) AS Freight, CustomerID, ShipCountry
FROM Orders
GROUP BY CustomerID, ShipCountry
ORDER BY CustomerID


-- mehrere Spalten:
SELECT SUM(Freight) AS Freight, CustomerID, ShipCountry, OrderID
FROM Orders
GROUP BY CustomerID, ShipCountry, OrderID
-- bringt NIX! Weil jetzt ist es die Summe der Frachtkosten PRO Bestellung, also wieder genau die eigentlichen Frachtkosten



-- wieviele Kunden gibts pro Stadt im jeweiligen Land?
-- Country, City, Anzahl Kunden
SELECT Country, City, COUNT(CustomerID) AS Companies
FROM Customers
GROUP BY Country, City
ORDER BY Country


-- wie bekomme ich die Rechnungssumme?
SELECT OrderID, SUM(UnitPrice*Quantity-Discount)
FROM [Order Details]
GROUP BY OrderID


SELECT OrderID, CAST(SUM(UnitPrice*Quantity-Discount) AS money)
FROM [Order Details]
GROUP BY OrderID