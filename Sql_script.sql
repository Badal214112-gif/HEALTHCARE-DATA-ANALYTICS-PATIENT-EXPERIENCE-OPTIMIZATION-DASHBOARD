create database healthcare_db;

-- ==========================================
-- HOSPITAL ER DASHBOARD SQL
-- DB: healthcare_db
-- Table: hospital_data
-- ==========================================

USE healthcare_db;

-- --------------------------
-- BASIC CHECK
-- --------------------------

SELECT COUNT(*) AS total_rows FROM hospital_data;

-- --------------------------
-- MAIN KPIs
-- --------------------------

-- Total Patients
SELECT COUNT(*) AS total_patients
FROM hospital_data;

-- Distinct Patients
SELECT COUNT(DISTINCT `Patient Id`) AS distinct_patients
FROM hospital_data;

-- Avg Wait Time
SELECT ROUND(AVG(`Patient Waittime`), 2) AS avg_wait_time
FROM hospital_data;

-- Total Admitted + Admission Rate %
SELECT
    SUM(CASE WHEN `Patient Admission Flag_1` = TRUE THEN 1 ELSE 0 END) AS admitted_patients,
    ROUND(
        (SUM(CASE WHEN `Patient Admission Flag_1` = TRUE THEN 1 ELSE 0 END) / COUNT(*)) * 100,
        2
    ) AS admission_rate_percent
FROM hospital_data;

-- --------------------------
-- PATIENTS BY TIME
-- --------------------------

-- Patients by Month
SELECT
    YEAR(`Patient Admission Date`) AS year,
    MONTH(`Patient Admission Date`) AS month,
    COUNT(*) AS total_patients
FROM hospital_data
GROUP BY year, month
ORDER BY year, month;

-- Patients by Date (Daily Trend)
SELECT
    DATE(`Patient Admission Date`) AS admission_day,
    COUNT(*) AS total_patients
FROM hospital_data
GROUP BY admission_day
ORDER BY admission_day;

-- --------------------------
-- PATIENT BY GENDER
-- --------------------------

SELECT
    `Patient Gender`,
    COUNT(*) AS total_patients
FROM hospital_data
GROUP BY `Patient Gender`
ORDER BY total_patients DESC;

-- --------------------------
-- PATIENT BY DEPARTMENT
-- --------------------------

SELECT
    `Department Referral`,
    COUNT(*) AS total_patients
FROM hospital_data
GROUP BY `Department Referral`
ORDER BY total_patients DESC;

-- --------------------------
-- WAIT TIME INSIGHTS
-- --------------------------

-- Avg Wait Time by Department
SELECT
    `Department Referral`,
    ROUND(AVG(`Patient Waittime`), 2) AS avg_wait_time
FROM hospital_data
GROUP BY `Department Referral`
ORDER BY avg_wait_time DESC;

-- Avg Wait Time by Gender
SELECT
    `Patient Gender`,
    ROUND(AVG(`Patient Waittime`), 2) AS avg_wait_time
FROM hospital_data
GROUP BY `Patient Gender`
ORDER BY avg_wait_time DESC;

-- --------------------------
-- 7) TOP BUSY DAYS (Extra Insight)
-- --------------------------

SELECT
    DATE(`Patient Admission Date`) AS admission_day,
    COUNT(*) AS total_patients
FROM hospital_data
GROUP BY admission_day
ORDER BY total_patients DESC
LIMIT 10;
