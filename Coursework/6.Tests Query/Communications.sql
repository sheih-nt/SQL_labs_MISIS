--Посмотреть, какие услуги заказаны конкретным клиентом:
SELECT  c.FirstName,
		c.SecondName,
		s.ServicesName, 
		t.Rate
FROM Customers c
JOIN InProcess ip ON c.CustomersID = ip.CustomersID
JOIN Services s ON ip.ServicesID = s.ServicesID
JOIN Tariffs t ON s.ServicesID = t.ServicesID
WHERE c.CustomersID = 10;  

--Посмотреть, какие исполнители выполняют заказы для клиентов
SELECT c.FirstName AS CustomerFirstName,
	   c.SecondName AS CustomerSecondName, 
       e.FirstName AS ExecutorFirstName,
	   e.SecondName AS ExecutorSecondName,
       s.ServicesName
FROM InProcess ip
JOIN Customers c ON ip.CustomersID = c.CustomersID
JOIN Executor e ON ip.ExecutorID = e.ExecutorID
JOIN Services s ON ip.ServicesID = s.ServicesID;

--Посмотреть все результаты работы для конкретного клиента, включая его платежи:
SELECT  c.FirstName, 
		c.SecondName,
		r.AllTariffs,
		r.AllRent,
		p.PayDate, 
		p.Sum, 
		p.Way
FROM Result r
JOIN Customers c ON r.CustomersID = c.CustomersID
JOIN Payment p ON r.ResultID = p.ResultID
WHERE c.CustomersID = 1; 
