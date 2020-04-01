-- Datumsfunktionen



/*
	Intervalle:

	year, yyyy, yy = Jahr
	quarter, qq, q = Quartal
	month, MM, M = Monat
	week, ww, wk = Woche
	day, dd, d = Tag
	hour, hh = Stunde
	minute, mi, n = Minute
	second, ss, s = Sekunde
	millisecond, ms = Millisekunde -- nicht ganz exakt; auch abhängig von Datentyp
	nanosecond, ns = Nanosekunde -- nicht ganz exakt

	weekday, dw, w = Wochentag
	dayofyear, dy, y = Tag des Jahres

*/

-- ************************** DATUM abfragen *********************************

-- returns DATETIME (Datentyp): auf 3-4 Millisekunden genau, 8 byte
SELECT GETDATE()

-- returns DATETIME2: auf mehrere Nanosekunden genau; 6-8 byte
SELECT SYSDATETIME()


-- *********************** Datumsberechnungen: DATEADD ***************************

SELECT DATEADD(hh, 10, '2020-03-30')
-- wenn wir keine Uhrzeit angeben, gehen wir von 0:00 Uhr aus --> 10:00


SELECT DATEADD(hh, 10, '2020-03-30 14:12:27')
-- 2020-03-31 00:12:27.000 -- das ist dann schon der nächste Tag!


-- Vorsicht mit Format:
SELECT DATEADD(hh, 10, '30.03.2020')
-- The conversion of a varchar data type to a datetime data type resulted in an out-of-range value.


-- wegzählen geht auch: negatives Vorzeichen setzen:
SELECT DATEADD(hh, -10, '2020-03-30 14:12')



SELECT DATEADD(dd, 10, SYSDATETIME()) -- 2020-04-09 14:17:15.9095363



-- **************************** DATEDIFF: Datumsdifferenz *********************
-- Differenz zwischen zwei Daten

-- SELECT DATEDIFF(Intervall, Startdatum, Enddatum)

SELECT DATEDIFF(dd, '2020-03-30', '2020-04-09') -- 10
SELECT DATEDIFF(dd, '2020-04-09', '2020-03-30') -- -10 (negatives Vorzeichen)

-- auch hier können wir mit dem aktuellen Datum rechnen:
-- wie lange dauert es bis zum nächsten Feiertag:
SELECT DATEDIFF(dd, GETDATE(), '2020-04-10') -- 11 Tage



-- Welches Datum haben wir in 38 Tagen?
SELECT DATEADD(dd, 38, SYSDATETIME()) -- 2020-05-07 14:29:56.6552982


-- Vor wie vielen Jahren kam der erste Star Wars Film in die Kinos? (25. Mai 1977)
SELECT DATEDIFF(yy, GETDATE(), '1977-05-25') -- -43 (negatives Vorzeichen)


SELECT DATEDIFF(yy, '1977-05-25', GETDATE()) -- 43


SELECT DATEDIFF(yy, '1977', GETDATE()) -- 43
-- in diesem Fall haben wir ja nur nach den Jahren gefragt, ich muss also nicht das vollständige Datum hinschreiben



-- ****************************** DATUMSTEILE ausgeben: DATEPART *******************

SELECT DATEPART(dd, '2020-03-30')
SELECT DATEPART(dd, SYSDATETIME())



-- ****************************** DATENAME ********************************
-- bringt nix:
SELECT DATENAME(dd, '2020-03-30') -- 30 (Datum)

-- macht Sinn für genau zwei Abfragen: dw (day of the week; month)
SELECT DATENAME(dw, '2020-03-30') -- Monday (Name des Tages)

SELECT DATENAME(MM, '2020-03-30') -- March


-- Welcher Wochentag war Dein Geburtstag?
SELECT DATENAME(dw, '1981-04-22') -- Wednesday


-- In welchem Quartal liegt der österreichische Nationalfeiertag (26.10.)?
SELECT DATEPART(qq, '2019-10-26') AS Quartal -- 4



-- Gib Tag, Monat und Jahr Deines Geburtstages in einer eigenen Spalte mit der jeweils entsprechenden Überschrift an
-- Tag   Monat   Jahr
--  22     04    1981

SELECT	  DATEPART(dd, '1981-04-22') AS Tag
		, DATEPART(MM, '1981-04-22') AS Monat
		, DATEPART(yyyy, '1981-04-22') AS Jahr

-- oder:

SELECT	  DAY('1981-04-22') AS Tag
		, MONTH('1981-04-22') AS Monat
		, YEAR('1981-04-22') AS Jahr

-- bei beiden Varianten gleiches Ergebnis
-- returns int
-- Speicherplatz 4 byte


-- Bsp. mit Northwind-DB:
SELECT *
FROM Employees


-- Das Einstellungsjahr aller unserer Mitarbeiter?
SELECT	  EmployeeID
		, LastName
		, DATEPART(yy, HireDate) AS HireDate
FROM Employees

-- mit vollständigen Namen in einer Spalte
SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS [vollständiger Name]
		, DATEPART(yy, HireDate) AS HireDate
FROM Employees



--SELECT *
--FROM [Order Details]

