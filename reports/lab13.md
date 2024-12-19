# Лабораторная работа 13 - Оптимизация запросов и производительность

---

## Задача 1: Использование индексов

### 1. Создание индекса для ускорения поиска по полям

Для улучшения производительности запросов, которые часто используют столбцы в условиях поиска, был создан индекс на поле `Name` таблицы `SalesLT.Product`. Это позволяет ускорить выполнение запросов с фильтрацией по наименованию товара.

```sql
CREATE NONCLUSTERED INDEX IDX_Product_Name 
ON SalesLT.Product (Name);
```

Этот индекс ускоряет выполнение запросов, которые фильтруют данные по столбцу `Name`.

### 2. Использование включенных столбцов в индексах

Для ускорения выполнения запросов, которые выбирают столбцы `ProductID` и `ListPrice` для товаров с определенным названием, был создан индекс с включением этих столбцов:

```sql
CREATE NONCLUSTERED INDEX IDX_Product_Name_Include 
ON SalesLT.Product (Name) 
INCLUDE (ProductID, ListPrice);
```

Этот индекс позволяет избежать дополнительных обращений к таблице, если запрос выбирает только `ProductID` и `ListPrice`.

---

## Задача 2: Оптимизация запросов

### 1. Изучение плана выполнения запроса

Для того чтобы понять, как SQL Server обрабатывает запрос и какие индексы используются, можно исследовать план выполнения. Для этого используем команду `SET SHOWPLAN_ALL ON`:

```sql
SET SHOWPLAN_ALL ON;

SELECT ProductID, Name, ListPrice
FROM SalesLT.Product 
WHERE ListPrice > 1000;
```

Запуск этого запроса позволяет увидеть план выполнения, который помогает понять, какие операции выполняются SQL Server, и какие индексы используются.

### 2. Использование хранимых процедур для оптимизации

Создание хранимой процедуры для обработки часто выполняемых запросов позволяет избежать их компиляции каждый раз. Хранимая процедура позволяет повысить производительность, так как SQL Server кэширует планы выполнения.

```sql
CREATE PROCEDURE GetProductByPrice
    @MinPrice DECIMAL(10, 2)
AS
BEGIN
    SELECT ProductID, Name, ListPrice
    FROM SalesLT.Product
    WHERE ListPrice > @MinPrice;
END;
```

Запрос с вызовом хранимой процедуры:

```sql
EXEC GetProductByPrice @MinPrice = 1000;
```

Хранимая процедура компилируется и выполняется быстрее, чем обычный запрос, так как план выполнения кэшируется.

---

## Задача 3: Анализ и устранение проблем с производительностью

### 1. Проблемы с производительностью из-за неэффективных запросов

Пример запроса, который может быть медленным из-за отсутствия индекса на `ProductCategoryID`:

```sql
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE ProductCategoryID = 37 
AND ListPrice > 5000;
```

Для улучшения производительности создается индекс на `ProductCategoryID`:

```sql
CREATE NONCLUSTERED INDEX IDX_Product_Category
ON SalesLT.Product (ProductCategoryID);
```

Индекс позволяет ускорить выполнение запроса, особенно при большом объеме данных.

### 2. Использование индексов для агрегации данных

Запрос для получения средней цены товаров в каждой категории, где создается индекс на столбце `ProductCategoryID` для ускорения агрегации:

```sql
SELECT ProductCategoryID, AVG(ListPrice) AS AvgPrice
FROM SalesLT.Product
GROUP BY ProductCategoryID;
```

Для ускорения запроса создается индекс на `ProductCategoryID`:

```sql
CREATE NONCLUSTERED INDEX IDX_Product_Category_Avg
ON SalesLT.Product (ProductCategoryID);
```
