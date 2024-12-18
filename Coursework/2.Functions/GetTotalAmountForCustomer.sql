CREATE FUNCTION GetTotalAmountForCustomer (@CustomerID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(10, 2);

    SELECT @TotalAmount = SUM(t.Rate)
    FROM InProcess ip
    JOIN Tariffs t ON ip.ServicesID = t.ServicesID
    WHERE ip.CustomersID = @CustomerID;

    RETURN @TotalAmount;
END;
