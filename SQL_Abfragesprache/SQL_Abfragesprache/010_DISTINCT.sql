-- DISTINCT


-- wie bekomme ich eine Liste von allen Ländern, in die geliefert wird?
SELECT ShipCountry
FROM Orders
-- wir bekommen einen Treffer pro Bestellung (830)

SELECT Country
FROM Customers
-- wir bekommen einen Treffer pro Kunde (91)

-- in beiden Fällen haben wir das Problem, dass es mehrere Kunden/Bestellungen gibt und somit Länder mehrfach vorkommen

-- Lösung: DISTINCT

SELECT DISTINCT ShipCountry
FROM Orders
-- 21 Ergebnisse


-- so bekommen wir alle Länder
SELECT DISTINCT ShipCountry
FROM Orders
ORDER BY ShipCountry
-- 21


-- so viele, wie Customers, die schon etwas bestellt haben; Länder können mehrfach vorkommen
SELECT DISTINCT CustomerID, ShipCountry
FROM Orders
-- 89

-- bringt genau gar nix - die OrderID ist schon eindeutig, daher bekommen wir jetzt alle Bestellungen heraus
SELECT DISTINCT OrderID, CustomerID, ShipCountry
FROM Orders


-- Liste von allen Städten, in denen wir Kunden haben?
SELECT DISTINCT City
FROM Customers


SELECT DISTINCT Country
FROM Customers
-- 21


SELECT DISTINCT Country, City
FROM Customers
-- so viele Ergebnisse, wie Cities


-- Liste von allen Ländern, in denen wir Angestellte haben?
SELECT DISTINCT Country
FROM Employees
-- USA, UK


-- zur Kontrolle:
SELECT EmployeeID, Country
FROM Employees