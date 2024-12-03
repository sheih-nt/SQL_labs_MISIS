# Лабораторная работа 12 - Программирование на Transact-SQL

Эта лабораторная работа выполнена в базе данных **AdventureWorksLT**. Задания включают использование курсоров, хранимых процедур и работу с системными представлениями для реализации поиска данных в таблицах и во всей базе данных.

---

## Задача 1: Поиск значения в таблице

### 1. Получите все текстовые столбцы в таблице `SalesLT.Product`

Скрипт для получения списка текстовых столбцов таблицы:

```sql
DECLARE @SchemaName NVARCHAR(50) = 'SalesLT';
DECLARE @TableName NVARCHAR(50) = 'Product';

SELECT 
    COLUMN_NAME AS ColumnName, 
    DATA_TYPE AS Type
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_SCHEMA = @SchemaName
    AND TABLE_NAME = @TableName
    AND DATA_TYPE IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext');
```

![Task 12.1.1](image/task12_1_1.png)

---

### 2. Поиск значения в текстовых столбцах таблицы

Скрипт для поиска значения в текстовых столбцах таблицы:

```sql
DECLARE @SchemaName NVARCHAR(50) = 'SalesLT';
DECLARE @TableName NVARCHAR(50) = 'Product';
DECLARE @SearchString NVARCHAR(2000) = 'Bike';

DECLARE @SQL NVARCHAR(MAX);
SET @SQL = '';

SELECT @SQL = @SQL + 
    'SELECT * FROM ' + @SchemaName + '.' + @TableName + 
    ' WHERE ' + COLUMN_NAME + ' LIKE ''%' + @SearchString + '%'' UNION ALL '
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_SCHEMA = @SchemaName
    AND TABLE_NAME = @TableName
    AND DATA_TYPE IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext');

-- Удаляем последний UNION ALL
SET @SQL = LEFT(@SQL, LEN(@SQL) - 10);

PRINT @SQL;
EXEC sp_executesql @SQL;
```

![Task 12.1.2](image/task12_1_2.png)

---

## Задача 2: Поиск значения во всей базе данных

### 1. Создание хранимой процедуры

Создание хранимой процедуры для поиска подстроки в таблице:

```sql
CREATE PROCEDURE SalesLT.uspFindStringInTable
    @SchemaName SYSNAME,
    @TableName SYSNAME,
    @SearchString NVARCHAR(2000)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = '';

    SELECT @SQL = @SQL + 
        'SELECT * FROM ' + @SchemaName + '.' + @TableName + 
        ' WHERE ' + COLUMN_NAME + ' LIKE ''%' + @SearchString + '%'' UNION ALL '
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE 
        TABLE_SCHEMA = @SchemaName
        AND TABLE_NAME = @TableName
        AND DATA_TYPE IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext');

    -- Удаляем последний UNION ALL
    SET @SQL = LEFT(@SQL, LEN(@SQL) - 10);

    PRINT @SQL; -- Для отладки
    EXEC sp_executesql @SQL;

    RETURN @@ROWCOUNT;
END;
```

Проверка хранимой процедуры:

```sql
EXEC SalesLT.uspFindStringInTable 
    @SchemaName = 'SalesLT', 
    @TableName = 'Product', 
    @SearchString = 'Bike';
```

![Task 12.2.1](image/task12_2_1.png)

---

### 2. Поиск по всем таблицам в базе данных

Скрипт для поиска значения во всех таблицах базы данных:

```sql
DECLARE @SearchString NVARCHAR(2000) = 'Bike';
DECLARE @SchemaName SYSNAME, @TableName SYSNAME;
DECLARE @Message NVARCHAR(MAX);

DECLARE TableCursor CURSOR FOR
SELECT 
    TABLE_SCHEMA, 
    TABLE_NAME
FROM 
    INFORMATION_SCHEMA.TABLES
WHERE 
    TABLE_TYPE = 'BASE TABLE';

OPEN TableCursor;

FETCH NEXT FROM TableCursor INTO @SchemaName, @TableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRY
        DECLARE @RowCount INT;
        EXEC @RowCount = SalesLT.uspFindStringInTable @SchemaName, @TableName, @SearchString;

        IF @RowCount > 0
            SET @Message = 'В таблице ' + @SchemaName + '.' + @TableName + ' найдено строк: ' + CAST(@RowCount AS NVARCHAR);
        ELSE
            SET @Message = 'В таблице ' + @SchemaName + '.' + @TableName + ' не найдено строк совпадений';

        PRINT @Message;
    END TRY
    BEGIN CATCH
        PRINT 'Ошибка при обработке таблицы ' + @SchemaName + '.' + @TableName + ': ' + ERROR_MESSAGE();
    END CATCH;

    FETCH NEXT FROM TableCursor INTO @SchemaName, @TableName;
END;

CLOSE TableCursor;
DEALLOCATE TableCursor;
```

![Task 12.2.2](image/task12_2_2.png)
