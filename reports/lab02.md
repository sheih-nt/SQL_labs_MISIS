# Лабораторная работа 2 - Запросы к таблицам SELECT

## Задача 1: Получение данных для транспортных отчетов

### 1. Получите список городов
Запрос, который извлекает уникальные города и регионы из таблицы `Address`.

```sql
SELECT DISTINCT City, StateProvince
FROM SalesLT.Address;
```

Результат выполнения запроса:
![Task 2.1.1](/image/task2_1_1.png)

### 2. Получите самые тяжелые товары
Запрос на выборку 10% самых тяжелых товаров из таблицы `Product`.

```sql
SELECT TOP 10 PERCENT Name, Weight
FROM SalesLT.Product
ORDER BY Weight DESC;
```

Результат выполнения запроса:
![Task 2.1.2](../image/task2_1_2.png)

### 3. Извлеките самые тяжелые 100 товаров, не включая десять самых тяжелых
Запрос для получения 100 самых тяжелых товаров, исключив первые 10.

```sql
SELECT Name, Weight
FROM SalesLT.Product
ORDER BY Weight DESC
OFFSET 10 ROWS FETCH NEXT 100 ROWS ONLY;
```

Результат выполнения запроса:
![Task 2.1.3](../image/task2_1_3.png)

## Задача 2: Получение данных о товаре

### 1. Получите информацию о товаре для модели 1
Запрос для получения наименований, цветов и размеров товаров с идентификатором модели 1.

```sql
SELECT Name, Color, Size
FROM SalesLT.Product
WHERE ProductModelID = 1;
```

Результат выполнения запроса:
![Task 2.2.1](../image/task2_2_1.png)

### 2. Отфильтруйте товары по цвету и размеру
Запрос для получения товаров, которые имеют цвета "black", "red" или "white", и размеры "S" или "M".

```sql
SELECT ProductNumber, Name
FROM SalesLT.Product
WHERE Color IN ('black', 'red', 'white')
AND Size IN ('S', 'M');
```

Результат выполнения запроса:
![Task 2.2.2](../image/task2_2_2.png)

### 3. Отфильтруйте товары по номерам товаров
Запрос для получения товаров, номера которых начинаются с "BK-".

```sql
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-%';
```

Результат выполнения запроса:
![Task 2.2.3](../image/task2_2_3.png)

### 4. Получите определенные товары по товарному номеру
Измените предыдущий запрос для получения товаров, номера которых начинаются с "BK-", содержат любой символ, кроме "R", и заканчиваются на "-XX".

```sql
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-[^R]%-__';
```

Результат выполнения запроса:
![Task 2.2.4](../image/task2_2_4.png)
