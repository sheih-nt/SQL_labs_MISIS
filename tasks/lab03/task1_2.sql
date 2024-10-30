SELECT C.CompanyName, SOH.SalesOrderID, SOH.TotalDue, A.AddressLine1, A.AddressLine2, A.City, 
       A.StateProvince, A.PostalCode, A.CountryRegion
FROM SalesLT.Customer C
JOIN SalesLT.SalesOrderHeader SOH
    ON C.CustomerID = SOH.CustomerID
JOIN SalesLT.CustomerAddress CA
    ON C.CustomerID = CA.CustomerID
JOIN SalesLT.Address A
    ON CA.AddressID = A.AddressID
WHERE CA.AddressType = 'Main Office';
