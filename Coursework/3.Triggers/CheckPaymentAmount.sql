CREATE TRIGGER CheckPaymentAmount
ON Payment
AFTER INSERT
AS
BEGIN
    DECLARE @Amount DECIMAL(10, 2);
    SELECT @Amount = Sum FROM INSERTED;
    
    IF @Amount > 5000
    BEGIN
        PRINT 'Ошибка: Сумма платежа не может превышать 5000!';
        ROLLBACK TRANSACTION;  -- Отменяет транзакцию
    END
END;
