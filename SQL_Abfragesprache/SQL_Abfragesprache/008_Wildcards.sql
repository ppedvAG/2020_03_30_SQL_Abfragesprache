-- Wildcards
-- beim LIKE


-- % steht für beliebig viele unbekannte Zeichen (0 - ?)

-- im Like steht [] für genau 1 Zeichen aus einem vordefinierten Bereich

-- | steht für ODER

-- _ (Unterstrich) steht für genau 1 unbekanntes Zeichen

-- ^ steht für NICHT


SELECT *
FROM Customers
WHERE CustomerID = 'ALFKI'


-- beginnt mit ALF
SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALF%'

-- mögliche Treffer
-- ALF
-- ALFX
-- ALFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


-- endet mit MI
SELECT *
FROM Customers
WHERE CustomerID LIKE '%MI'

-- CompanyName enthält ein "kiste"
SELECT *
FROM Customers
WHERE CompanyName LIKE '%kiste%'


-- alle Kunden, deren Firmenname mit D beginnt?
SELECT		CompanyName
FROM Customers
WHERE CompanyName LIKE 'D%'
-- 3

-- alle Kunden, deren Firmenname mit D enden
SELECT		CompanyName
FROM Customers
WHERE CompanyName LIKE '%D'



-- alle Kunden, deren Firmenname ein D enthält
SELECT		CompanyName
FROM Customers
WHERE CompanyName LIKE '%D%'



-- Wertebereiche [] angeben

-- im Like steht [] für genau 1 Zeichen aus einem vordefinierten Bereich
-- funktioniert auch mit Sonderzeichen


-- alle Kunden, deren Firmenname mit a, b oder c beginnt
SELECT *
FROM Customers
WHERE CompanyName LIKE '[a-c]%'


-- wie würden wir nach einem %-Zeichen suchen?
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[%]%'



-- wie bekomme ich alle Kunden, die ein Hochkomma im Namen haben?
SELECT *
FROM Customers
WHERE CompanyName LIKE '%''%' -- Trick: 2 '', sonst Anweisungsabschluss und Fehler!



-- alle, die mit a ODER c beginnen
-- entweder so:
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%' OR CompanyName LIKE 'c%'

-- oder so:
SELECT *
FROM Customers
WHERE CompanyName LIKE'[ac]%'


-- alle, die mit a, b oder c beginnen und mit e, f oder g enden
SELECT *
FROM Customers
WHERE CompanyName LIKE '[a-c]%' AND CompanyName LIKE '%[e-g]'
--oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[a-c]%[e-g]'


-- alle, die mit a, b oder c oder e, f oder g enden
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c]' OR CompanyName LIKE '%[e-g]'

-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c|e-f]'
-- aus dem Wertebereich a-c ODER e-f (der Trennstrich | steht für OR)


-- alle, die mit a oder c beginnen und mit m oder e enden
SELECT *
FROM Customers
WHERE CompanyName LIKE '[ac]%' AND CompanyName LIKE '%[me]'

-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[ac]%[me]'

-- Gib alle Produkte aus, deren Name mit „coffee“ endet.
SELECT *
FROM Products
WHERE ProductName LIKE '%coffee'


-- Gib alle Produkte aus, deren Name mit 'L' beginnt.
SELECT *
FROM Products
WHERE ProductName LIKE 'L%'


-- Gib alle Produkte aus, die ein 'ost' im Namen haben.
SELECT *
FROM Products
WHERE ProductName LIKE '%ost%'


-- Gib alle Produkte aus, deren Name mit D-L beginnt und mit a, b, c, d oder m, n, o endet.

SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND (ProductName LIKE '%[a-d]' OR ProductName LIKE '%[m-o]')

-- oder:
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND ProductName LIKE '%[a-d|m-o]'

-- oder:
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%[a-d|m-o]'



 
SELECT Phone
FROM Suppliers
WHERE Phone LIKE '(503) 555-993%'
-- mit Prozent könnten hier noch beliebig viele unbekannte Zeichen kommen
-- (503) 555-993
-- (503) 555-9931123456789098765432123456789098765432
-- (503) 555-9931a
-- (503) 555-9931abcde


-- genau 1 unbekanntes Zeichen
SELECT Phone
FROM Suppliers
WHERE Phone LIKE '(503) 555-993_'



-- alle Kunden, die mit d, e oder f beginnen, der letzte Buchstabe ist ein l und der drittletzte ist ein d

SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE '[d-f]%d_l'

/*
	mögliche Ergebnisse:

	dxxxxxxxxxxxxxxxxxxxxxdxl
	ddxl
	edel
	fdyl

	Ernst Handel
	e........d.l
	
*/


-- alle Kunden, die NICHT mit a-c beginnen
SELECT *
FROM Customers
WHERE CompanyName LIKE '[^a-c]%' -- ^ steht hier für NICHT das, was in der Klammer steht














-- Gib alle Produkte aus, die vom Anbieter (SupplierID) 5, 10 oder 15 stammen, von denen mehr als 10 Stück vorrätig sind und deren Stückpreis unter 100 liegt.
-- Ordne das Ergebnis absteigend vom höchsten zum niedrigsten Stückpreis.
SELECT *
FROM Products 
WHERE SupplierID IN(5, 10, 15) AND UnitsInStock > 10 AND UnitPrice < 100
ORDER BY UnitPrice DESC




