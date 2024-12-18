CREATE VIEW PaidServices AS
SELECT c.FirstName AS CustomerFirstName, c.SecondName AS CustomerSecondName, 
       s.ServicesName, t.Rate, p.PayDate, p.Sum, p.Way
FROM Payment p
JOIN Result r ON p.ResultID = r.ResultID
JOIN Customers c ON r.CustomersID = c.CustomersID
JOIN InProcess ip ON c.CustomersID = ip.CustomersID
JOIN Services s ON ip.ServicesID = s.ServicesID
JOIN Tariffs t ON s.ServicesID = t.ServicesID
WHERE p.Sum > 0;
