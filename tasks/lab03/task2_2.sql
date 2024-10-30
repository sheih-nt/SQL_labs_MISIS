SELECT C.CustomerID, C.CompanyName, C.FirstName, C.LastName, C.Phone
FROM SalesLT.Customer C
LEFT JOIN SalesLT.CustomerAddress CA
    ON C.CustomerID = CA.CustomerID
WHERE CA.CustomerID IS NULL;
