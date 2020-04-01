-- Einfache Tabellenabfragen
-- SELECT auf bestimmte Tabellen

-- immer zuerst �berpr�fen: bin ich in der richtigen Datenbank??


/*
	Syntax:

	SELECT	  Spaltenname1
			, Spaltenname2
			, Spaltenname3
			, ...
	FROM Tabellenname

*/

USE Northwind


-- * hei�t: alle Spalten dieser Tabelle
-- * ist keine sch�ne Schreibweise!
-- wir sollten IMMER ALLE Spalten auff�hren, die wir ausgeben wollen!
SELECT *
FROM Customers



SELECT	  CustomerID
		, CompanyName
		, ContactName
--		, ...
FROM Customers




-- Nachschauen im Datenbank-Diagramm hilft, um sich einen �berblick �ber die Datenbank zu verschaffen
-- Datenbank-Diagramm erstellen:
-- Object Explorer -> Databases -> Northwind -> Database Diagrams -> Rechtsklick -> New Database Diagram -> alle gew�nschten Tabellen ausw�hlen



-- Die Kontaktdaten aller Kunden
-- CustomerID, CompanyName,...
-- Spalten�berschriften auf Deutsch

SELECT	  CustomerID AS KundenID
		, CompanyName AS Firmenname
		, ContactName AS Kontaktname
		, Phone AS Telefon
		, Fax
		, Address AS Stra�e
		, City AS Stadt
FROM Customers


-- ProduktID, Produktname, St�ckpreis
SELECT	  ProductID
		, ProductName
		, UnitPrice
FROM Products



-- Bestellungen: Bestellnummer, welcher Kunde, welcher Angestellte hat verkauft, in welches Land ist geliefert worden?

SELECT	  OrderID AS Bestellnummer -- ALIAS
		, CustomerID AS Kundennummer
		, EmployeeID AS Angestellter
		, ShipCountry AS Land
FROM Orders



SELECT	  OrderID Bestellnummer -- das AS darf weggelassen werden, sollte aber der Lesbarkeit halber verwendet werden!
		, CustomerID AS Kundennummer
		, EmployeeID AS Angestellter
		, ShipCountry AS Land
FROM Orders
