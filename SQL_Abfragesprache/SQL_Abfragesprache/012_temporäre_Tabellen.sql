-- temporäre Tabellen
-- temporary tables

/*
	
	-- lokale temporäre Tabellen
	-- existieren nur in der aktuellen Session
	-- #Tabellenname

	-- globale temporäre Tabellen
	-- Zugriff auch von anderen Sessions aus
	-- ##Tabellenname


	-- hält nur so lange, wie Verbindung da ist / solage wie Session
	-- kann auch gelöscht werden

*/


SELECT CustomerID, Freight
INTO #t1
FROM Orders


SELECT *
FROM #t1

SELECT EmployeeID, LastName
INTO ##t2
FROM Employees

SELECT *
FROM ##t2



-- Variablen

/*
	-- lokale Variablen
	-- Zugriff nur in der Session, wo sie erstellt worden ist
	-- @Name


	-- globale Variablen
	-- @@Name


	-- Lebenszeit: solange, wie der Batch läuft


	-- Variable muss deklariert werden
	DECLARE @Name AS Datentyp


	-- Wert zuweisen
	
	-- Bsp.:
	DECLARE @var1 AS int
	@var1 = 100


	DECLARE @var2 AS int = 100


	-- Bsp.:
	
	DECLARE @var1 AS int = 100

	SELECT *
	FROM Orders
	WHERE Freight > @var1
*/

