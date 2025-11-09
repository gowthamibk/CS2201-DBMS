-- ================================================
-- 🛒 PART 1: ONLINE SHOPPING SYSTEM (DML OPERATIONS)
-- ================================================

-- Step 1: Drop & Create Database
DROP DATABASE IF EXISTS OnlineShoppingDB;
CREATE DATABASE OnlineShoppingDB;
USE OnlineShoppingDB;

-- Step 2: Create Tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Stores (
    StoreID INT PRIMARY KEY AUTO_INCREMENT,
    StoreName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    StoreID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    PaymentMode VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert Records (5 each)
INSERT INTO Customers (CustomerName, Email, Phone) VALUES
('Ravi Kumar', 'ravi@example.com', '9876543210'),
('Sneha Rao', 'sneha@example.com', '9123456789'),
('Aman Gupta', 'aman@example.com', '9988776655'),
('Priya Sharma', 'priya@example.com', '9000011111'),
('Karan Patel', 'karan@example.com', '9090909090');

INSERT INTO Products (ProductName, Category, Price, Stock) VALUES
('Laptop', 'Electronics', 55000.00, 10),
('Office Chair', 'Furniture', 8000.00, 15),
('Table Lamp', 'Home Decor', 1200.00, 20),
('Sofa Set', 'Furniture', 25000.00, 5),
('Smartphone', 'Electronics', 35000.00, 8);

INSERT INTO Stores (StoreName, Location) VALUES
('TechZone', 'Bangalore'),
('FurniWorld', 'Mumbai'),
('HomeStyle', 'Delhi'),
('MegaMart', 'Pune'),
('SmartBuy', 'Chennai');

INSERT INTO Orders (CustomerID, StoreID, OrderDate) VALUES
(1, 1, '2025-11-01'),
(2, 2, '2025-11-02'),
(3, 3, '2025-11-03'),
(4, 4, '2025-11-04'),
(5, 5, '2025-11-05');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1);

INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMode) VALUES
(1, '2025-11-01', 55000.00, 'Credit Card'),
(2, '2025-11-02', 16000.00, 'Cash'),
(3, '2025-11-03', 1200.00, 'UPI'),
(4, '2025-11-04', 25000.00, 'Debit Card'),
(5, '2025-11-05', 35000.00, 'Net Banking');

-- Step 4: Update Operations
-- Decrease stock after a sale
UPDATE Products
SET Stock = Stock - 1
WHERE ProductID = 1;

-- Increase Furniture category prices by 10%
SET SQL_SAFE_UPDATES = 0;
UPDATE Products
SET Price = Price * 1.10
WHERE Category = 'Furniture';
SET SQL_SAFE_UPDATES = 1;

-- Step 5: Retrieve all records
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Stores;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Payments;

-- ================================================
-- 🎓 PART 2: UNIVERSITY DATABASE (PRIMARY & FOREIGN KEYS)
-- ================================================

DROP DATABASE IF EXISTS UniversityDB;
CREATE DATABASE UniversityDB;
USE UniversityDB;

-- Department Table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY AUTO_INCREMENT,
    DeptName VARCHAR(100) NOT NULL
);

-- Student Table
CREATE TABLE Student (
    USN VARCHAR(10) PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Course Table
CREATE TABLE Course (
    CourseID VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Course Registration Table
CREATE TABLE CourseReg (
    USN VARCHAR(10),
    CourseID VARCHAR(10),
    PRIMARY KEY (USN, CourseID),
    FOREIGN KEY (USN) REFERENCES Student(USN),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Marks Table
CREATE TABLE Marks (
    USN VARCHAR(10),
    CourseID VARCHAR(10),
    Marks INT,
    FOREIGN KEY (USN) REFERENCES Student(USN),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Insert Records
INSERT INTO Department (DeptName) VALUES
('Physics'),
('Computer Science'),
('Mathematics');

INSERT INTO Student (USN, StudentName, DeptID) VALUES
('24BSC101', 'Ravi Kumar', 1),
('24BSC102', 'Sneha Rao', 2),
('24BSC103', 'Aman Gupta', 2),
('24BSC104', 'Priya Sharma', 3),
('24BSC105', 'Karan Patel', 1);

INSERT INTO Course (CourseID, CourseName, DeptID) VALUES
('PH201', 'Quantum Mechanics', 1),
('CS202', 'Database Systems', 2),
('MA203', 'Linear Algebra', 3),
('CS204', 'Operating Systems', 2),
('PH205', 'Thermodynamics', 1);

INSERT INTO CourseReg (USN, CourseID) VALUES
('24BSC101', 'PH201'),
('24BSC102', 'CS202'),
('24BSC103', 'CS204'),
('24BSC104', 'MA203'),
('24BSC105', 'PH205');

INSERT INTO Marks (USN, CourseID, Marks) VALUES
('24BSC101', 'PH201', 87),
('24BSC102', 'CS202', 90),
('24BSC103', 'CS204', 78),
('24BSC104', 'MA203', 85),
('24BSC105', 'PH205', 88);

-- Retrieve all data
SELECT * FROM Department;
SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM CourseReg;
SELECT * FROM Marks;
