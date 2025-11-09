-- =========================================
-- UNIVERSITY MANAGEMENT SYSTEM (DDL SCRIPT)
-- =========================================

-- Step 1: Drop database if it already exists (clean start)
DROP DATABASE IF EXISTS UniversityDB;

-- Step 2: Create new database
CREATE DATABASE UniversityDB;
USE UniversityDB;

-- =========================================
-- Step 3: Create Tables
-- =========================================

-- 1. Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL
);

-- 2. Professors Table
CREATE TABLE Professors (
    ProfessorID INT PRIMARY KEY AUTO_INCREMENT,
    ProfessorName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 3. Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Credits INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 4. Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(100) NOT NULL,
    Age INT,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 5. Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- =========================================
-- Step 4: ALTER TABLE Operations
-- =========================================

-- A. Add a new column PhoneNumber (VARCHAR, 15) to Students table
ALTER TABLE Students
ADD PhoneNumber VARCHAR(15);

-- B. Modify CourseName column in Courses to allow up to 150 characters
ALTER TABLE Courses
MODIFY CourseName VARCHAR(150);

-- C. Remove the Salary column from Professors table
ALTER TABLE Professors
DROP COLUMN Salary;

-- =========================================
-- Step 5: Verify Structure (Optional)
-- =========================================
SHOW TABLES;
DESC Students;
DESC Professors;
DESC Courses;
