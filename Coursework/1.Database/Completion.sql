-- 1. Таблица Services
INSERT INTO Services (ServicesName, Description, BaseRate)
VALUES 
('Уборка помещений', 'Профессиональная уборка офисов и квартир', 1000.00),
('Ремонт техники', 'Обслуживание и ремонт бытовой техники', 1500.00),
('Доставка грузов', 'Курьерская доставка товаров', 500.00),
('Ремонт автомобилей', 'Комплексное техобслуживание авто', 2000.00),
('Настройка компьютеров', 'Диагностика и настройка ПК', 800.00),
('Прачечная', 'Химчистка и стирка', 600.00),
('Ремонт мебели', 'Восстановление мебели', 1800.00),
('Курсы английского', 'Обучение английскому языку', 1200.00),
('Ремонт сантехники', 'Устранение неисправностей', 1000.00),
('Озеленение участка', 'Услуги ландшафтного дизайна', 3000.00);

-- 2. Таблица Tariffs
INSERT INTO Tariffs (ServicesID, Rate)
VALUES 
(1, 1100.00), (2, 1600.00), (3, 550.00),
(4, 2200.00), (5, 850.00), (6, 650.00),
(7, 1900.00), (8, 1300.00), (9, 1050.00),
(10, 3100.00);

-- 3. Таблица Customers
INSERT INTO Customers (FirstName, SecondName, ThirdName, Number, Email, Address)
VALUES 
('Иван', 'Иванов', 'Иванович', '+79000000001', 'ivanov1@example.com', 'г. Москва, ул. Пушкина, д. 1'),
('Мария', 'Сидорова', 'Петровна', '+79000000002', 'maria1@example.com', 'г. Москва, ул. Лермонтова, д. 2'),
('Алексей', 'Попов', 'Дмитриевич', '+79000000003', 'popov@example.com', 'г. Казань, ул. Баумана, д. 3'),
('Ольга', 'Кузнецова', 'Сергеевна', '+79000000004', 'olga@example.com', 'г. Санкт-Петербург, ул. Мира, д. 4'),
('Дмитрий', 'Васильев', 'Иванович', '+79000000005', 'dmitri@example.com', 'г. Екатеринбург, ул. Карла Маркса, д. 5'),
('Анна', 'Морозова', 'Алексеевна', '+79000000006', 'anna@example.com', 'г. Новосибирск, ул. Ленина, д. 6'),
('Сергей', 'Волков', 'Владимирович', '+79000000007', 'sergey@example.com', 'г. Самара, ул. Гагарина, д. 7'),
('Юлия', 'Соколова', 'Петровна', '+79000000008', 'julia@example.com', 'г. Нижний Новгород, ул. Советская, д. 8'),
('Елена', 'Фёдорова', 'Игоревна', '+79000000009', 'elena@example.com', 'г. Челябинск, ул. Молодёжная, д. 9'),
('Максим', 'Андреев', 'Николаевич', '+79000000010', 'maksim@example.com', 'г. Уфа, ул. Крупская, д. 10');

-- 4. Таблица Executor
INSERT INTO Executor (FirstName, SecondName, ThirdName, Number, Email, Address)
VALUES 
('Виктор', 'Иванов', 'Сергеевич', '+79000000011', 'victor@example.com', 'г. Москва, ул. Вавилова, д. 11'),
('Светлана', 'Петрова', 'Алексеевна', '+79000000012', 'sveta@example.com', 'г. Казань, ул. Тургенева, д. 12'),
('Григорий', 'Попов', 'Павлович', '+79000000013', 'grigory@example.com', 'г. Санкт-Петербург, ул. Пушкина, д. 13'),
('Татьяна', 'Сидорова', 'Викторовна', '+79000000014', 'tanya@example.com', 'г. Москва, ул. Ленина, д. 14'),
('Роман', 'Васильев', 'Денисович', '+79000000015', 'roman@example.com', 'г. Новосибирск, ул. Крупская, д. 15'),
('Ирина', 'Кузнецова', 'Николаевна', '+79000000016', 'irina@example.com', 'г. Екатеринбург, ул. Мира, д. 16'),
('Олег', 'Морозов', 'Александрович', '+79000000017', 'oleg@example.com', 'г. Самара, ул. Гагарина, д. 17'),
('Екатерина', 'Соколова', 'Юрьевна', '+79000000018', 'ekaterina@example.com', 'г. Нижний Новгород, ул. Советская, д. 18'),
('Михаил', 'Фёдоров', 'Степанович', '+79000000019', 'mikhail@example.com', 'г. Челябинск, ул. Молодёжная, д. 19'),
('Наталья', 'Андреева', 'Александровна', '+79000000020', 'natalya@example.com', 'г. Уфа, ул. Советская, д. 20');

-- 5. Таблица InProcess
INSERT INTO InProcess (ServicesID, CustomersID, ExecutorID)
VALUES 
(1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4), (5, 5, 5), 
(6, 6, 6), (7, 7, 7), (8, 8, 8), (9, 9, 9), (10, 10, 10);

-- 6. Таблица Result
INSERT INTO Result (CustomersID, PayID, AllTariffs, AllRent)
VALUES 
(1, 1, 'Уборка помещений', 1200.00), 
(2, 2, 'Ремонт техники', 1600.00),
(3, 3, 'Доставка грузов', 550.00),
(4, 4, 'Ремонт автомобилей', 2200.00),
(5, 5, 'Настройка компьютеров', 850.00),
(6, 6, 'Прачечная', 650.00),
(7, 7, 'Ремонт мебели', 1900.00),
(8, 8, 'Курсы английского', 1300.00),
(9, 9, 'Ремонт сантехники', 1050.00),
(10, 10, 'Озеленение участка', 3100.00);

-- 7. Таблица Payment
INSERT INTO Payment (CustomersID, ResultID, PayDate, Sum, Way)
VALUES 
(1, 1, '2024-12-18', 1200.00, 'card'),
(2, 2, '2024-12-18', 1600.00, 'cash'),
(3, 3, '2024-12-18', 550.00, 'card'),
(4, 4, '2024-12-18', 2200.00, 'cash'),
(5, 5, '2024-12-18', 850.00, 'card'),
(6, 6, '2024-12-18', 650.00, 'cash'),
(7, 7, '2024-12-18', 1900.00, 'card'),
(8, 8, '2024-12-18', 1300.00, 'cash'),
(9, 9, '2024-12-18', 1050.00, 'card'),
(10, 10, '2024-12-18', 3100.00, 'cash');

-- 8. Таблица AllResult
INSERT INTO AllResult (ServiceID, Status)
VALUES 
(1, 'Completed'), (2, 'Completed'), (3, 'In Progress'), (4, 'Completed'),
(5, 'In Progress'), (6, 'Completed'), (7, 'In Progress'), (8, 'Completed'),
(9, 'In Progress'), (10, 'Completed');
