-- 1. Таблица Services
CREATE TABLE Services (
    ServicesID INT PRIMARY KEY IDENTITY,
    ServicesName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    BaseRate DECIMAL(10, 2) NOT NULL
);

-- 2. Таблица Tariffs
CREATE TABLE Tariffs (
    RateID INT PRIMARY KEY IDENTITY,
    ServicesID INT NOT NULL,
    Rate DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ServicesID) REFERENCES Services(ServicesID)
);

-- 3. Таблица Customers
CREATE TABLE Customers (
    CustomersID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(50) NOT NULL,
    SecondName NVARCHAR(50),
    ThirdName NVARCHAR(50),
    Number NVARCHAR(20),
    Email NVARCHAR(100),
    Address NVARCHAR(MAX)
);

-- 4. Таблица Executor
CREATE TABLE Executor (
    ExecutorID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(50) NOT NULL,
    SecondName NVARCHAR(50),
    ThirdName NVARCHAR(50),
    Number NVARCHAR(20),
    Email NVARCHAR(100),
    Address NVARCHAR(MAX)
);

-- 5. Таблица InProcess
CREATE TABLE InProcess (
    InProcessID INT PRIMARY KEY IDENTITY,
    ServicesID INT NOT NULL,
    CustomersID INT NOT NULL,
    ExecutorID INT NOT NULL,
    FOREIGN KEY (ServicesID) REFERENCES Services(ServicesID),
    FOREIGN KEY (CustomersID) REFERENCES Customers(CustomersID),
    FOREIGN KEY (ExecutorID) REFERENCES Executor(ExecutorID)
);

-- 6. Таблица Result
CREATE TABLE Result (
    ResultID INT PRIMARY KEY IDENTITY,
    CustomersID INT NOT NULL,
    PayID INT NOT NULL,
    AllTariffs NVARCHAR(MAX),
    AllRent DECIMAL(10, 2),
    FOREIGN KEY (CustomersID) REFERENCES Customers(CustomersID)
);

-- 7. Таблица Payment
CREATE TABLE Payment (
    PayID INT PRIMARY KEY IDENTITY,
    CustomersID INT NOT NULL,
    ResultID INT NOT NULL,
    PayDate DATE NOT NULL,
    Sum DECIMAL(10, 2) NOT NULL,
    Way NVARCHAR(10) CHECK (Way IN ('cash', 'card')),
    FOREIGN KEY (CustomersID) REFERENCES Customers(CustomersID),
    FOREIGN KEY (ResultID) REFERENCES Result(ResultID)
);

-- 8. Таблица AllResult
CREATE TABLE AllResult (
    AllResultID INT PRIMARY KEY IDENTITY,
    ServiceID INT NOT NULL,
    Status NVARCHAR(50),
    FOREIGN KEY (ServiceID) REFERENCES Services(ServicesID)
);
