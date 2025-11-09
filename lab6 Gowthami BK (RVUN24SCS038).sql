-- ======================================================================
-- Lab Experiment – GROUP BY, HAVING, ORDER BY and INDEXING
-- ======================================================================

DROP DATABASE IF EXISTS HospitalDB;
CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE Visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    visit_date DATE,
    doctor_id INT,
    diagnosis VARCHAR(100),
    treatment_cost DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

INSERT INTO Patients (patient_name, age, gender) VALUES
('Ravi Kumar', 34, 'Male'),
('Priya Sharma', 29, 'Female'),
('Ankit Verma', 41, 'Male'),
('Neha Gupta', 25, 'Female'),
('Arjun Singh', 50, 'Male');

INSERT INTO Visits (patient_id, visit_date, doctor_id, diagnosis, treatment_cost) VALUES
(1, '2024-01-05', 101, 'Fever', 150.00),
(1, '2024-01-15', 102, 'Cold', 120.00),
(2, '2024-02-10', 103, 'Fracture', 500.00),
(3, '2024-02-18', 104, 'Diabetes', 300.00),
(4, '2024-03-02', 102, 'Fever', 180.00),
(5, '2024-03-15', 105, 'Heart Disease', 800.00),
(3, '2024-03-20', 104, 'Diabetes', 250.00),
(2, '2024-03-25', 103, 'Fracture', 550.00),
(1, '2024-04-01', 101, 'Cold', 130.00),
(5, '2024-04-10', 105, 'Heart Disease', 900.00);

-- Task 1: GROUP BY
SELECT 
    diagnosis,
    COUNT(*) AS total_cases,
    AVG(treatment_cost) AS avg_treatment_cost
FROM Visits
GROUP BY diagnosis;

-- Task 2: HAVING
SELECT 
    diagnosis,
    COUNT(*) AS total_cases,
    AVG(treatment_cost) AS avg_treatment_cost
FROM Visits
GROUP BY diagnosis
HAVING AVG(treatment_cost) > 200;

-- Task 3: ORDER BY
SELECT 
    diagnosis,
    COUNT(*) AS total_cases,
    AVG(treatment_cost) AS avg_treatment_cost
FROM Visits
GROUP BY diagnosis
ORDER BY avg_treatment_cost DESC;

-- Task 4: INDEXING
CREATE INDEX idx_patient_id ON Visits(patient_id);
SHOW INDEX FROM Visits;

SELECT * 
FROM Visits 
WHERE patient_id = 1;
