-- Тестируем функцию для получения общей стоимости услуг клиента:
SELECT dbo.GetTotalAmountForCustomer(1) AS TotalAmount;

-- Тестируем представление PaidServices:
SELECT * FROM PaidServices;

-- Тестируем хранимую процедуру для получения услуг клиента (например, для клиента с ID=1):
EXEC GetCustomerServices @CustomerID = 1;

-- Тестируем триггер, вставив новый платеж с большой суммой:
INSERT INTO Payment (CustomersID, ResultID, PayDate, Sum, Way)
VALUES (1, 1, '2024-12-19', 6000.00, 'card');
