-- CAST, CONVERT, FORMAT


-- ********************************* CAST ***********************************
-- Umwandeln von Datentypen

-- Syntax:
-- SELECT CAST(expression AS datatype)

-- geht:
SELECT '123' + 3 -- 126


-- geht nicht:
SELECT '123.5' + 3 -- Conversion failed when converting the varchar value '123.5' to data type int.

-- das funktioniert:
SELECT CAST('123.5' AS float) + 3


/*
	implizite und explizite Konvertierung in der Microsoft-Dokumentation:
	https://docs.microsoft.com/de-de/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver15
*/


-- geht auch mit Datum, aber mit CAST allein haben wir keinen Einfluss auf das Format:
SELECT CAST(SYSDATETIME() AS varchar)

-- VORSICHT mit Anzahl der Stellen!!
SELECT CAST(SYSDATETIME() AS varchar(3)) -- 202 - erste drei Stellen vom Jahr - sinnlos!

-- mit Information aus der Datenbank:
SELECT CAST(HireDate AS varchar)
FROM Employees

-- VORSICHT!! umgekehrt kann es Probleme geben:
SELECT CAST('2020-03-30' AS datetime) -- was ist Tag, was Monat?? Systemabhängig!!



-- ************************* CONVERT *******************************************
-- auch mit CONVERT können wir von einem Datentyp in einen anderen umwandeln, aber CONVERT kann noch ein bisschen mehr
-- Syntax:
-- SELECT CONVERT(datatype[(length)], expression[, style])
-- 1 Datentyp, in den konvertiert werden soll
-- 2 das, was konvertiert werden soll
-- 3 (optional): Style Parameter - wie soll die Ausgabe aussehen


-- Bsp.:

SELECT CONVERT(varchar(10), 12345.5)

-- funktioniert auch mit Datum:
SELECT CONVERT(varchar, SYSDATETIME())

-- auch hier wieder aufpassen mit Länge:
SELECT CONVERT(varchar(3), SYSDATETIME())
-- faaaaalsch!!!



-- über den Style-Parameter geben wir das Format an, in dem die Datumsausgabe erfolgen soll:
SELECT CONVERT(varchar, SYSDATETIME(), 104) -- 30.03.2020 (deutsche Schreibweise)
SELECT CONVERT(varchar, SYSDATETIME(), 4) -- 30.03.20 (ohne century)


SELECT	  CONVERT(varchar, SYSDATETIME(), 104) AS DE
		, CONVERT(varchar, SYSDATETIME(), 101) AS US
		, CONVERT(varchar, SYSDATETIME(), 103) AS GB



-- Date und Time Styles in der Microsoft Dokumentation:
/*
	https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles
*/



-- ********************************** FORMAT *******************************
-- Ausgabe-Datentyp ist nvarchar

-- Syntax:
-- SELECT FORMAT(expression, format[, style])

SELECT FORMAT(1234567890, '###-###/##-##') -- 123-456/78-90

SELECT FORMAT(431234567890, '+' + '##/### ## ## ###') -- +43/123 45 67 890



-- mit Datum:
SELECT FORMAT(GETDATE(), 'dd.mm.yyyy') -- 30.44.2020 -- kleingeschrieben wird mm hier als Minute falsch interpretiert!!!


SELECT FORMAT(GETDATE(), 'dd.MM.yyyy') -- MM groß schreiben!! -- dann: 30.03.2020


SELECT FORMAT(GETDATE(), 'dd.MM.yyyy') AS Datum



-- funktioniert nicht!!
SELECT FORMAT('2020-03-30', 'dd.MM.yyyy')
-- Argument data type varchar is invalid for argument 1 of format function.


-- aus Datenbank:
SELECT FORMAT(HireDate, 'dd.MM.yyyy') AS HireDate
FROM Employees



-- Culture-Parameter:
SELECT	  FORMAT(SYSDATETIME(), 'd', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'd', 'en-gb') AS GB
		, FORMAT(SYSDATETIME(), 'd', 'en-us') AS US
		, FORMAT(SYSDATETIME(), 'd', 'sv') AS Schweden
-- mit kleinem "d": Ausgabe in Zahlen
-- 30.03.2020	30/03/2020	3/30/2020


SELECT	  FORMAT(SYSDATETIME(), 'D', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'D', 'en-gb') AS GB
		, FORMAT(SYSDATETIME(), 'D', 'en-us') AS US
-- mit großem "D": Ausgabe mit Text
-- Montag, 30. März 2020	30 March 2020	Monday, March 30, 2020



-- Supported Culture Codes in der Microsoft-Dokumentation:
/*
	https://docs.microsoft.com/de-de/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes
*/



-- Gib die Datumsdifferenz zwischen Lieferdatum und Wunschtermin der Bestellungen aus.
SELECT DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
		, ShippedDate
		, RequiredDate
FROM Orders



-- Gib die Mitarbeiternummer, den vollständigen Namen (in einer Spalte), die Anrede, das Geburtsdatum (ohne Zeitangabe) und die Telefonnummer aller Angestellten aus.

-- langsam:
-- vollständiger Name:
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees

-- Geburtsdatum ohne Zeitangabe:
SELECT FORMAT(BirthDate, 'dd.MM.yyyy') AS BirthDate
FROM Employees

-- oder:
SELECT CONVERT(varchar, BirthDate, 104) AS BirthDate
FROM Employees

-- zusammenfügen:
SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, TitleOfCourtesy
		, FORMAT(BirthDate, 'dd.MM.yyyy') AS BirthDate
		, HomePhone
FROM Employees


-- Gib die Nettofrachtkosten, Bruttofrachtkosten und die Mehrwertsteuer aus (Berechnung).

SELECT	  Freight AS Netto
		, Freight*1.19 AS Brutto
		, Freight*0.19 AS MwSt
FROM Orders


SELECT	  Freight AS Brutto
		, Freight/1.19 AS Netto
		, Freight-Freight/1.19 AS Steuer
FROM Orders


