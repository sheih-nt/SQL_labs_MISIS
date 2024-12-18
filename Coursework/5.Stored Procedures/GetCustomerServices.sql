CREATE PROCEDURE GetCustomerServices
    @CustomerID INT
AS
BEGIN
    SELECT s.ServicesName, t.Rate
    FROM Services s
    JOIN InProcess ip ON s.ServicesID = ip.ServicesID
    JOIN Tariffs t ON s.ServicesID = t.ServicesID
    WHERE ip.CustomersID = @CustomerID;
END;
