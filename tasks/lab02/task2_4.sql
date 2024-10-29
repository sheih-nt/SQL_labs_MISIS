SELECT ProductNumber, Name, ListPrice
FROM Product
WHERE ProductNumber LIKE 'BK-[^R]%-__';
