CREATE PROCEDURE AddNewCustomer
    @FirstName NVARCHAR(50),
    @SecondName NVARCHAR(50),
    @ThirdName NVARCHAR(50),
    @Number NVARCHAR(20),
    @Email NVARCHAR(100),
    @Address NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO Customers (FirstName, SecondName, ThirdName, Number, Email, Address)
    VALUES (@FirstName, @SecondName, @ThirdName, @Number, @Email, @Address);
END;
