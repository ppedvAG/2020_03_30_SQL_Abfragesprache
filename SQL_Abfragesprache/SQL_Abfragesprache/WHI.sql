-- WH 1

-- SELECT
-- Berechnungen, Text, Zahlen

SELECT 123
SELECT 'Text'

SELECT	  CustomerID
		, CompanyName
		, Address
FROM Customers


SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees


SELECT GETDATE()

SELECT SYSDATETIME()


SELECT FORMAT(1234567890, '###-###-##-##')


SELECT FORMAT(GETDATE(), 'dd.MM.yyyy')

SELECT FORMAT(GETDATE(), 'd', 'de-de') AS DE
SELECT FORMAT(GETDATE(), 'd', 'en-us') AS US


SELECT CONVERT(varchar, GETDATE(), 104)


