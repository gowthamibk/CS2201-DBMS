-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Lab Experiment 03: Implementation of different types of SQL functions.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Gowthami B K
-- USN: RVUN24SCS038
-- SECTION: 'A'
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------
-- Create and Select Database
-- -------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS CompanyDB;
USE CompanyDB;

-- -------------------------------------------------------------------------
-- Drop Tables if Already Exist (to avoid errors on re-run)
-- -------------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Employees;

-- -------------------------------------------------------------------------
-- Create Employees Table
-- -------------------------------------------------------------------------
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2),
    BirthDate DATE,
    HireDate DATE
);

-- Insert Employee Records
INSERT INTO Employees (FirstName, LastName, Salary, BirthDate, HireDate) VALUES
('John', 'Doe', 55000.30, '1985-06-15', '2010-01-20'),
('Jane', 'Smith', 65000.50, '1990-08-22', '2012-07-10'),
('Alice', 'Johnson', 72000.10, '1982-11-30', '2015-05-25'),
('Bob', 'Brown', 48000.90, '1978-03-12', '2018-09-15');

-- -------------------------------------------------------------------------
-- Create Orders Table
-- -------------------------------------------------------------------------
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert Order Records
INSERT INTO Orders (OrderDate, TotalAmount, EmployeeID) VALUES
('2024-07-15', 250.00, 1),
('2024-08-10', 175.50, 2),
('2024-09-01', 300.00, 3),
('2024-09-10', 450.75, 1),
('2024-08-25', 123.40, 4);

-- -------------------------------------------------------------------------
-- Verify Tables
-- -------------------------------------------------------------------------
SELECT * FROM Employees;
SELECT * FROM Orders;

-- -------------------------------------------------------------------------
-- Number Functions Section
-- -------------------------------------------------------------------------
-- a. Round Salaries
SELECT FirstName, Salary, ROUND(Salary) AS Rounded_Salary
FROM Employees;

-- b. Absolute Values
SELECT FirstName, Salary, ABS(Salary) AS Absolute_Salary
FROM Employees;

-- c. Ceiling Values
SELECT OrderID, TotalAmount, CEIL(TotalAmount) AS Ceiling_Amount
FROM Orders;

-- -------------------------------------------------------------------------
-- Aggregate Functions Section
-- -------------------------------------------------------------------------
-- a. Count of Employees
SELECT COUNT(*) AS Total_Employees
FROM Employees;

-- b. Sum of Salaries
SELECT SUM(Salary) AS Total_Salary_Expense
FROM Employees;

-- c. Average Order Amount
SELECT AVG(TotalAmount) AS Average_Order_Value
FROM Orders;

-- d. Max/Min Salary
SELECT MAX(Salary) AS Highest_Salary, MIN(Salary) AS Lowest_Salary
FROM Employees;

-- -------------------------------------------------------------------------
-- Character Functions Section
-- -------------------------------------------------------------------------
-- a. Case Conversion
SELECT FirstName, UPPER(FirstName) AS Upper_Name, LOWER(FirstName) AS Lower_Name
FROM Employees;

-- b. Concatenate Names
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;

-- c. Extract Substring
SELECT FirstName, SUBSTRING(FirstName, 1, 3) AS Short_Name
FROM Employees;

-- -------------------------------------------------------------------------
-- Conversion Functions Section
-- -------------------------------------------------------------------------
-- Convert String to Date
SELECT STR_TO_DATE('2024-12-25', '%Y-%m-%d') AS Converted_Date;

-- -------------------------------------------------------------------------
-- Date Functions Section
-- -------------------------------------------------------------------------
-- a. Current Date/Time (safe alias)
SELECT NOW() AS CurrentTime;

-- b. Extract Year from Order Dates
SELECT OrderID, YEAR(OrderDate) AS Order_Year
FROM Orders;

-- c. Add Months to Order Dates
SELECT OrderID, OrderDate, DATE_ADD(OrderDate, INTERVAL 3 MONTH) AS New_Date
FROM Orders;

-- d. Days Since Order
SELECT OrderID, OrderDate, DATEDIFF(NOW(), OrderDate) AS Days_Since_Order
FROM Orders;

-- -------------------------------------------------------------------------
-- END of the Task
-- -------------------------------------------------------------------------
