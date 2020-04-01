-- Simple SELECT, einfache Abfragen

/*
	Text, Zahlen, Berechnungen


*/

USE Northwind;
GO -- Batch Delimiter


-- Zahlen ausgeben
SELECT 100


-- Text ausgeben
SELECT 'Testtext'


-- Berechnungen machen
SELECT 100*3 -- 300


-- Spaltenüberschrift
SELECT 100 * 3 AS Berechnung



SELECT '100*3' -- '100*3' als Textausgabe! Datentyp!


SELECT 100, 'Testtext' -- zwei Spalten



-- FORMAT??

SELECT 100,
	   'Testtext',
	   'noch mehr Text',
--	   'noch mehr Text'

-- besser, dann kann man letztes noch ausblenden ohne Fehlermeldung

SELECT	  100
		, 'Testtext'
		, 'noch mehr Text'
--		, 'noch mehr Text'



-- Groß-/Kleinschreibung egal
select 100
SELECT 100
Select 100 -- nicht schön


SELECT 100 -- STRG + SHIFT + U (uppercase) in Großbuchstaben schreiben
select 100 -- STRG + SHIFT + L (lowercase) in Kleinbuchstaben schreiben



SELECT	  100 AS Zahl
		, 'Donaudampfschifffahrtsgesellschaft' AS Text
		, 100 * 2 AS Rechnung