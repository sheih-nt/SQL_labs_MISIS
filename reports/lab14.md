# Лабораторная работа 14 - Продвинутые техники программирования на T-SQL

---

## Задача 1: Использование триггеров

### 1. Создание триггера для автоматической записи изменений

Запрос для создания триггера, который автоматически записывает изменения в таблице `SalesLT.Product` в таблицу аудита `ProductAudit`:

```sql
CREATE TRIGGER trg_Product_Audit
ON SalesLT.Product
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @Action NVARCHAR(10);
    DECLARE @ProductID INT;
    DECLARE @Name NVARCHAR(50);
    DECLARE @ListPrice DECIMAL(10, 2);
    DECLARE @OldPrice DECIMAL(10, 2);

    IF EXISTS (SELECT * FROM inserted)
        SET @Action = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM deleted)
        SET @Action = 'DELETE';
    ELSE
        SET @Action = 'UPDATE';

    IF @Action = 'INSERT'
    BEGIN
        SELECT @ProductID = ProductID, @Name = Name, @ListPrice = ListPrice FROM inserted;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        SELECT @ProductID = ProductID, @Name = Name, @OldPrice = ListPrice FROM deleted;
    END
    ELSE
    BEGIN
        SELECT @ProductID = ProductID, @Name = Name, @OldPrice = ListPrice FROM deleted;
        SELECT @ListPrice = ListPrice FROM inserted;
    END

    INSERT INTO SalesLT.ProductAudit (Action, ProductID, Name, OldPrice, NewPrice, ActionDate)
    VALUES (@Action, @ProductID, @Name, @OldPrice, @ListPrice, GETDATE());
END;
```

Этот триггер будет записывать изменения в таблице `Product` в таблицу `ProductAudit` при добавлении, обновлении или удалении записи.

![Task 14.1.1](image/task14_1_1.png)

---

### 2. Тестирование работы триггера

Запрос для тестирования работы триггера при вставке и обновлении данных:

```sql
-- Вставка нового товара
INSERT INTO SalesLT.Product (Name, ProductNumber, ListPrice, ProductCategoryID, SellStartDate)
VALUES ('New Bike', 'NB-123', 300.00, 1, GETDATE());

-- Обновление цены товара
UPDATE SalesLT.Product
SET ListPrice = 350.00
WHERE ProductNumber = 'NB-123';
```

Проверка данных в таблице `ProductAudit` для подтверждения, что триггер сработал корректно:

```sql
SELECT * FROM SalesLT.ProductAudit
ORDER BY ActionDate DESC;
```

![Task 14.1.2](image/task14_1_2.png)

---

## Задача 2: Использование курсоров

### 1. Создание курсора для обработки каждой записи

Запрос для создания и использования курсора для выборки данных из таблицы `SalesLT.Product` и их обработки:

```sql
DECLARE @ProductID INT, @Name NVARCHAR(50), @ListPrice DECIMAL(10, 2);

DECLARE product_cursor CURSOR FOR
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE ListPrice > 1000;

OPEN product_cursor;

FETCH NEXT FROM product_cursor INTO @ProductID, @Name, @ListPrice;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'ProductID: ' + CAST(@ProductID AS NVARCHAR) + ', Name: ' + @Name + ', ListPrice: ' + CAST(@ListPrice AS NVARCHAR);
    
    FETCH NEXT FROM product_cursor INTO @ProductID, @Name, @ListPrice;
END

CLOSE product_cursor;
DEALLOCATE product_cursor;
```

Этот курсор извлекает товары с ценой больше $1000 и выводит их информацию.

![Task 14.2.1](image/task14_2_1.png)

---

## Задача 3: Использование динамического SQL

### 1. Создание динамического SQL для выборки данных

Запрос для создания динамического SQL-запроса, который позволяет выбирать данные из таблицы в зависимости от переданных параметров:

```sql
DECLARE @SQL NVARCHAR(MAX);
DECLARE @TableName NVARCHAR(50) = 'SalesLT.Product';
DECLARE @ColumnName NVARCHAR(50) = 'Name';

SET @SQL = 'SELECT ' + @ColumnName + ' FROM ' + @TableName;

EXEC sp_executesql @SQL;
```

Этот запрос генерирует строку SQL на основе переданных параметров и выполняет ее через `sp_executesql`.

![Task 14.3.1](image/task14_3_1.png)

---

### 2. Применение динамического SQL для фильтрации

Запрос для применения динамического SQL с параметрами фильтрации:

```sql
DECLARE @SQL NVARCHAR(MAX);
DECLARE @TableName NVARCHAR(50) = 'SalesLT.Product';
DECLARE @ColumnName NVARCHAR(50) = 'Name';
DECLARE @SearchString NVARCHAR(50) = 'Bike';

SET @SQL = 'SELECT ' + @ColumnName + ' FROM ' + @TableName + ' WHERE ' + @ColumnName + ' LIKE ''%' + @SearchString + '%''';

EXEC sp_executesql @SQL;
```

![Task 14.3.2](image/task14_3_2.png)
