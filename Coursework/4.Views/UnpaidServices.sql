CREATE VIEW UnpaidServices AS
SELECT c.FirstName AS CustomerFirstName, c.SecondName AS CustomerSecondName, 
       s.ServicesName
FROM InProcess ip
JOIN Customers c ON ip.CustomersID = c.CustomersID
JOIN Services s ON ip.ServicesID = s.ServicesID
WHERE NOT EXISTS (
    SELECT 1 FROM Payment p WHERE p.CustomersID = c.CustomersID AND p.ResultID = ip.ServicesID
);
