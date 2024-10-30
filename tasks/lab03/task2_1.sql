SELECT C.CompanyName, C.FirstName, C.LastName, SOH.SalesOrderID, SOH.TotalDue
FROM SalesLT.Customer C
LEFT JOIN SalesLT.SalesOrderHeader SOH
    ON C.CustomerID = SOH.CustomerID
ORDER BY SOH.SalesOrderID;
