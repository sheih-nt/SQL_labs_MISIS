SELECT C.CustomerID, NULL AS ProductID
FROM SalesLT.Customer C
LEFT JOIN SalesLT.SalesOrderHeader SOH
    ON C.CustomerID = SOH.CustomerID
WHERE SOH.CustomerID IS NULL

UNION

SELECT NULL AS CustomerID, P.ProductID
FROM SalesLT.Product P
LEFT JOIN SalesLT.SalesOrderDetail SOD
    ON P.ProductID = SOD.ProductID
WHERE SOD.ProductID IS NULL;
