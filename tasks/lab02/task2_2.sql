SELECT ProductNumber, Name
FROM Product
WHERE Color IN ('black', 'red', 'white')
AND Size IN ('S', 'M');
