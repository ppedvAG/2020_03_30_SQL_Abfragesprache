-- Datentypen

/*
	int - Ganzzahlen
	float - Nachkommastellen
	decimal(10,2) - 10 Stellen, davon 2 Nachkommastellen

	money - auf 4 Nachkommastellen genau

	char(50) - genau 50 Stellen
	varchar(50) - maximal 50 Stellen
	
	nchar, nvarchar - wie char und varchar, aber Unicode, daher doppelt so viel Speicherplatz
	
	datetime - auf mehrere ms genau
	datetime2 - auf mehrere nanosec genau
	date - nur Datum
	time - nur Zeit 

*/


-- CREATE


CREATE DATABASE MyTestCompany

-- DROP DATABASE MyTestCompany
-- NEEEEIIIIINNNN!!!
-- die gesamte Datenbank inlusive Inhalt wäre unwiederbringlich weg!!!

USE MyTestCompany

CREATE TABLE Produkte 
	(
		ProduktID int identity(1000, 1) PRIMARY KEY,
		ProduktName varchar(20) NOT NULL, -- nicht schlau! größerer Puffer!
		Preis money
--      ....,
--		....			
			
	)
	
-- DROP TABLE Produkte
-- NICHT verwenden... die Tabelle ist inklusive Inhalt unwiederbringlich weg!!


SELECT *
FROM Produkte


INSERT INTO Produkte (ProduktName, Preis)
VALUES ('Spaghetti', 1.90) -- Komma -> englische Schreibweise! 1.9 statt 1,9



INSERT INTO Produkte (Preis, ProduktName)
VALUES (4.50, 'Profiterols')



-- mehrere Werte auf einmal einfügen:
INSERT INTO Produkte (ProduktName, Preis)
VALUES ('Carbonara', 2.90),
	   ('Tiramisu', 4.90),
	   ('Penne', 2.10),
	   ('Tagliatelle', 1.80),
	   ('Tartufo', 3.90)


DELETE FROM Produkte
-- DELETE FROM Produkte löscht den kompletten Inhalt der Tabelle!
-- im Gegensatz zu DROP ist die Tabelle selbst aber noch da


-- DELETE: ganz genau sagen, WAS weggelöscht werden soll
DELETE FROM Produkte
WHERE ProduktName = 'Spaghetti'
-- löscht ALLE Einträge, wo der ProduktName 'Spaghetti' ist!

-- eindeutiges Feld auswählen!
DELETE FROM Produkte
WHERE ProduktID = 1010


SELECT *
FROM Produkte


-- Werte mit UPDATE verändern
-- SET gilt für alle... wieder mit WHERE einschränken!!!

UPDATE Produkte
SET Preis = 1.99
WHERE ProduktID = 1009



--UPDATE Produkte
--SET ProduktID = 1010
--WHERE ProduktID = 1009
-- Cannot update identity column 'ProduktID'.


-- an Tabelle selbst etwas verändern mit ALTER
ALTER TABLE Produkte
ALTER COLUMN ProduktName varchar(255)


-- neue Spalte hinzufügen
ALTER TABLE Produkte
ADD AnzahlLagernd smallint


-- Spalten löschen
ALTER TABLE Produkte
DROP COLUMN AnzahlLagernd


CREATE TABLE Lieferanten
	(
		LID int identity PRIMARY KEY,
		Firmenname varchar(50),
		Kontaktperson varchar(50),
		Telefon varchar(50)
		--...
		--...
	)


ALTER TABLE Produkte
ADD LID int

ALTER TABLE Produkte
ADD CONSTRAINT FK_Produkte_Lieferanten FOREIGN KEY (LID) REFERENCES Lieferanten(LID)