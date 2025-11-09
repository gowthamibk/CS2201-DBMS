-- ======================================================================
-- LAB EXPERIMENT – Implementation of Triggers in SQL
-- ======================================================================

-- Objective:
-- 1. To understand and create triggers in MySQL.
-- 2. To implement BEFORE and AFTER triggers for INSERT, UPDATE, and DELETE operations.
-- ======================================================================

-- Step 1: Create Database
DROP DATABASE IF EXISTS SchoolDB;
CREATE DATABASE SchoolDB;
USE SchoolDB;

-- ======================================================================
-- Step 2: Create Tables
-- ======================================================================

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(50),
    Age INT,
    Marks DECIMAL(5,2)
);

CREATE TABLE StudentLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    ActionType VARCHAR(50),
    ActionDate DATETIME,
    Description VARCHAR(200)
);

-- Verify structure
DESC Students;
DESC StudentLogs;

-- ======================================================================
-- Task 1: BEFORE INSERT Trigger
-- Prevent inserting students with Marks greater than 100
-- ======================================================================

DELIMITER //
CREATE TRIGGER before_student_insert
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
    IF NEW.Marks > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Marks cannot exceed 100.';
    END IF;
END //
DELIMITER ;

-- Test the BEFORE INSERT Trigger
-- This should FAIL (Marks > 100)
-- INSERT INTO Students (StudentName, Age, Marks) VALUES ('John Doe', 18, 105);

-- This should PASS
INSERT INTO Students (StudentName, Age, Marks) VALUES ('Alice Smith', 19, 90);

-- ======================================================================
-- Task 2: AFTER INSERT Trigger
-- Log new student additions
-- ======================================================================

DELIMITER //
CREATE TRIGGER after_student_insert
AFTER INSERT ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentLogs (ActionType, ActionDate, Description)
    VALUES (
        'INSERT',
        NOW(),
        CONCAT('New student added: ', NEW.StudentName, ', Marks: ', NEW.Marks)
    );
END //
DELIMITER ;

-- Test AFTER INSERT Trigger
INSERT INTO Students (StudentName, Age, Marks) VALUES ('Bob Johnson', 20, 85);

-- View Logs
SELECT * FROM StudentLogs;

-- ======================================================================
-- Task 3: AFTER UPDATE Trigger
-- Log updates to student marks
-- ======================================================================

DELIMITER //
CREATE TRIGGER after_student_update
AFTER UPDATE ON Students
FOR EACH ROW
BEGIN
    IF OLD.Marks <> NEW.Marks THEN
        INSERT INTO StudentLogs (ActionType, ActionDate, Description)
        VALUES (
            'UPDATE',
            NOW(),
            CONCAT('Marks updated for ', NEW.StudentName, 
                   ' from ', OLD.Marks, ' to ', NEW.Marks)
        );
    END IF;
END //
DELIMITER ;

-- ⚠️ If you get Error Code: 1175 (Safe Update Mode), run this first:
-- SET SQL_SAFE_UPDATES = 0;

-- Test AFTER UPDATE Trigger
UPDATE Students SET Marks = 95 WHERE StudentID = 1;

-- View Logs
SELECT * FROM StudentLogs;

-- ======================================================================
-- Task 4: AFTER DELETE Trigger
-- Log student deletions
-- ======================================================================

DELIMITER //
CREATE TRIGGER after_student_delete
AFTER DELETE ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentLogs (ActionType, ActionDate, Description)
    VALUES (
        'DELETE',
        NOW(),
        CONCAT('Student deleted: ', OLD.StudentName, ', Marks: ', OLD.Marks)
    );
END //
DELIMITER ;

-- Test AFTER DELETE Trigger
DELETE FROM Students WHERE StudentID = 2;

-- View Logs
SELECT * FROM StudentLogs;

-- ======================================================================
-- Verify All Data
-- ======================================================================

SELECT * FROM Students;
SELECT * FROM StudentLogs;

-- ======================================================================
-- END OF EXPERIMENT – Implementation of Triggers
-- ======================================================================
