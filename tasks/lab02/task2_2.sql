SELECT ProductNumber, Name
FROM SalesLT.Product
WHERE Color IN ('black', 'red', 'white')
AND Size IN ('S', 'M');
