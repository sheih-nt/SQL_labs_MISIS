SELECT C.CompanyName, SOH.SalesOrderID, SOH.TotalDue
FROM SalesLT.Customer C
JOIN SalesLT.SalesOrderHeader SOH
    ON C.CustomerID = SOH.CustomerID;
