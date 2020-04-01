-- Einfache Tabellenabfragen
-- SELECT auf bestimmte Tabellen

-- immer zuerst überprüfen: bin ich in der richtigen Datenbank??


/*
	Syntax:

	SELECT	  Spaltenname1
			, Spaltenname2
			, Spaltenname3
			, ...
	FROM Tabellenname

*/

USE Northwind


-- * heißt: alle Spalten dieser Tabelle
-- * ist keine schöne Schreibweise!
-- wir sollten IMMER ALLE Spalten aufführen, die wir ausgeben wollen!
SELECT *
FROM Customers



SELECT	  CustomerID
		, CompanyName
		, ContactName
--		, ...
FROM Customers




-- Nachschauen im Datenbank-Diagramm hilft, um sich einen Überblick über die Datenbank zu verschaffen
-- Datenbank-Diagramm erstellen:
-- Object Explorer -> Databases -> Northwind -> Database Diagrams -> Rechtsklick -> New Database Diagram -> alle gewünschten Tabellen auswählen



-- Die Kontaktdaten aller Kunden
-- CustomerID, CompanyName,...
-- Spaltenüberschriften auf Deutsch

SELECT	  CustomerID AS KundenID
		, CompanyName AS Firmenname
		, ContactName AS Kontaktname
		, Phone AS Telefon
		, Fax
		, Address AS Straße
		, City AS Stadt
FROM Customers


-- ProduktID, Produktname, Stückpreis
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
