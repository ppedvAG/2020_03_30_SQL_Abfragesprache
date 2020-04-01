-- VIEW

CREATE VIEW vTest200
AS
SELECT CustomerID, CompanyName
FROM Customers


SELECT *
FROM vTest200
WHERE CompanyName LIKE '[a-c]%'


CREATE VIEW vRechnungen
AS
SELECT	  c.CustomerID
		, c.CompanyName
		, c.Address
		, c.City
		, c.PostalCode
		, c.Country
		, o.OrderID
		, o.OrderDate
		, o.ShippedDate
		, od.Quantity
		, od.UnitPrice
		, p.ProductID
		, p.ProductName
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID



SELECT OrderID, CompanyName, SUM(UnitPrice*Quantity) AS Rechnungssumme
FROM vRechnungen
GROUP BY OrderID, CompanyName