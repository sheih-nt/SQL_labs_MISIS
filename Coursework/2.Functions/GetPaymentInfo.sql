CREATE FUNCTION GetPaymentInfo (@PayID INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @PaymentInfo NVARCHAR(MAX);

    SELECT @PaymentInfo = CONCAT('Сумма: ', p.Sum, ', Дата: ', p.PayDate, ', Способ: ', p.Way)
    FROM Payment p
    WHERE p.PayID = @PayID;

    RETURN @PaymentInfo;
END;
