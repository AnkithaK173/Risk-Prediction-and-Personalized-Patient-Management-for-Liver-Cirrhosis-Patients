CREATE DATABASE LiverCirrhosisDB;
USE LiverCirrhosisDB;
CREATE TABLE LiverCirrhosisPatients (
    n_days INT,
    status VARCHAR(255),
    drug VARCHAR(255),
    age FLOAT,
    sex INT,
    ascites VARCHAR(255),
    hepatomegaly VARCHAR(255),
    spiders VARCHAR(255),
    edema VARCHAR(255),
    bilirubin FLOAT,
    cholesterol FLOAT,
    albumin FLOAT,
    copper FLOAT,
    alk_phos FLOAT,
    sgot FLOAT,
    tryglicerides FLOAT,
    platelets FLOAT,
    prothrombin FLOAT,
    stage INT,
    risk_level INT,
    cluster INT
);

INSERT INTO LiverCirrhosisPatients(
    n_days, status, drug, age, sex, ascites, hepatomegaly, spiders, edema, bilirubin,
    cholesterol, albumin, copper, alk_phos, sgot, tryglicerides, platelets,
    prothrombin, stage, risk_level, cluster
)
VALUES 
    (30, 'Active', 'DrugA', 45.5, 1, 'No', 'Yes', 'No', 'Yes', 1.2, 180.0, 3.5, 70.0, 250.0, 35.0, 100.0, 250000, 11.5, 3, 1, 2),
    (60, 'Inactive', 'DrugB', 37.0, 0, 'Yes', 'No', 'Yes', 'No', 2.1, 200.0, 4.0, 65.0, 275.0, 40.0, 110.0, 280000, 12.0, 4, 2, 1),
    (15, 'Active', 'DrugC', 50.2, 1, 'No', 'Yes', 'Yes', 'Yes', 0.9, 190.0, 3.8, 80.0, 240.0, 38.0, 120.0, 260000, 13.0, 2, 1, 3);
    
    SELECT COUNT(*) AS total_rows FROM LiverCirrhosisPatients;
    
    SELECT * FROM liverCirrhosisDB . LiverCirrhosisPatients;
    
-- 15 SQL queries aligned with project:    
-- "Risk Prediction and Personalized Patient Management for Liver Cirrhosis Patients."
-- 1. Retrieve All Data
-- This query fetches all columns and rows from the LiverCirrhosisPatients table. 
-- It is usually the first step to quickly inspect the data and verify its structure.

SELECT * FROM LiverCirrhosisPatients;

-- 2. Count Patients by Risk Level
-- This query groups patients based on the risk_level and counts the number of patients in each risk category (e.g., low, medium, high).
-- It helps identify the distribution of patients across different risk levels.

SELECT risk_level, COUNT(*) AS Patient_Count
FROM LiverCirrhosisPatients
GROUP BY risk_level;

-- 3. List Patients on a Specific Drug with Ascites
-- This query retrieves details of patients who have ascites (a common symptom of liver cirrhosis) and are on a specific drug (DrugA). This can help identify the drug's potential impact on ascites.
SELECT n_days, age, sex, drug, ascites
FROM LiverCirrhosisPatients
WHERE ascites = 'Yes' AND drug = 'DrugA';
SELECT DISTINCT ascites, drug
FROM LiverCirrhosisPatients;
SELECT n_days, age, sex, drug, ascites
FROM LiverCirrhosisPatients
WHERE drug = 'DrugA';
SELECT n_days, age, sex, drug, ascites
FROM LiverCirrhosisPatients
WHERE ascites = 'Yes';

-- 4. Calculate Average Age for Each Risk Level
-- Calculates the average age of patients for each risk_level.
-- This helps determine if certain age groups are more prone to higher risk levels of liver cirrhosis.
SELECT risk_level, AVG(age) AS Average_Age
FROM LiverCirrhosisPatients
GROUP BY risk_level;

-- 5. Sum of Platelets by Stage and Sex
-- This query sums up the platelet counts for each combination of stage and sex.
-- Platelet count is an important factor in assessing liver function, and the query helps understand its variation across different stages and genders.
SELECT stage, sex, SUM(platelets) AS Total_Platelets
FROM LiverCirrhosisPatients
GROUP BY stage, sex;

-- 6. Top 5 Patients with the Highest Bilirubin Levels
-- Bilirubin levels indicate liver function. 
--  This query lists the top 5 patients with the highest bilirubin levels, which might indicate severe liver dysfunction or jaundice.
SELECT n_days, bilirubin
FROM LiverCirrhosisPatients
ORDER BY bilirubin DESC
LIMIT 5;

-- 7. Count Patients with Edema and High Risk
-- This query counts the number of patients who have edema (swelling due to fluid retention) and are classified as high risk (risk_level = 3).
-- This helps identify the subset of patients needing immediate attention.
SELECT COUNT(*) AS HighRiskWithEdema
FROM LiverCirrhosisPatients
WHERE edema = 'Yes' AND risk_level = 3;

-- 8. Average Albumin by Cluster
-- Calculates the average albumin level for each patient cluster. 
-- Low albumin is a marker of poor liver function.
-- By segmenting patients into clusters, the query helps understand albumin trends across different patient groups.
SELECT cluster, AVG(albumin) AS Average_Albumin
FROM LiverCirrhosisPatients
GROUP BY cluster;

-- 9. Filter Patients with High Prothrombin and Advanced Stage
-- Prothrombin time indicates blood clotting efficiency. 
-- This query filters out patients with high prothrombin levels and advanced disease stages (stage 3 or higher), helping to identify critical cases.
-- Check Maximum Prothrombin Value
SELECT MAX(prothrombin) AS max_prothrombin
FROM LiverCirrhosisPatients;
SELECT n_days, prothrombin, stage
FROM LiverCirrhosisPatients
WHERE prothrombin > 10 AND stage >= 3;
-- Investigate Stage 3 or Higher:
SELECT n_days, prothrombin, stage
FROM LiverCirrhosisPatients
WHERE stage >= 3;

-- 10. Patients with High Cholesterol and Severe Hepatomegaly
-- High cholesterol and hepatomegaly (enlarged liver) can be indicators of severe liver damage.
-- This query identifies patients who exhibit both, highlighting those at risk of complications.
-- i. Check Maximum Cholesterol Value:
SELECT MAX(cholesterol) AS max_cholesterol
FROM LiverCirrhosisPatients;
-- ii. Check Count of Patients with Hepatomegaly ('Yes'):
SELECT COUNT(*) AS count_hepatomegaly_yes
FROM LiverCirrhosisPatients
WHERE hepatomegaly = 'Yes';
-- iii. Examine Cholesterol Values for Patients with Hepatomegaly ('Yes'):
SELECT n_days, cholesterol, hepatomegaly
FROM LiverCirrhosisPatients
WHERE hepatomegaly = 'Yes';
 
-- 11. Identify Patients with Specific Risk Levels and Spider Angiomas
-- Spider angiomas are a sign of liver disease. 
-- This query finds patients who show this symptom and have a moderate or higher risk level (risk_level >= 2), aiding in symptom-based assessment.
SELECT n_days, risk_level, spiders
FROM LiverCirrhosisPatients
WHERE spiders = 'Yes' AND risk_level >= 2;

-- 12. Trend Analysis of Albumin Levels by Stage
-- This query calculates the average albumin levels across different stages of the disease and orders the results by stage. 
-- It helps identify trends in albumin decline as the disease progresses.
SELECT stage, AVG(albumin) AS Avg_Albumin
FROM LiverCirrhosisPatients
GROUP BY stage
ORDER BY stage;

-- 13. Count Patients by Drug Type and Presence of Ascites
-- This query groups patients by drug and whether they have ascites, counting the number of patients in each group.
-- It provides insights into how different drugs might relate to the presence of ascites.
SELECT drug, ascites, COUNT(*) AS Patient_Count
FROM LiverCirrhosisPatients
GROUP BY drug, ascites;

-- 14. Segment Patients Based on Sex and Risk Level
-- This query segments the patients based on sex and risk_level, providing a count of patients in each segment.
-- It helps in understanding gender-based risk distribution.
SELECT sex, risk_level, COUNT(*) AS Total_Patients
FROM LiverCirrhosisPatients
GROUP BY sex, risk_level;

-- 15. Create a View for High-Risk Patients in Specific Clusters
-- This query creates a view named HighRiskClusters that filters for patients who are classified as high risk (risk_level = 3) and belong to specific clusters (cluster IN (1, 2)). 
-- Views are used for easier querying and analysis of specific subsets of the data.
CREATE VIEW HighRiskClusters AS
SELECT n_days, age, sex, stage, risk_level, cluster
FROM LiverCirrhosisPatients
WHERE risk_level = 3 AND cluster IN (1, 2);
-- Check Distribution of Risk Levels and Clusters:
-- To see the distribution of risk_level and cluster values,
SELECT DISTINCT risk_level FROM LiverCirrhosisPatients;
SELECT DISTINCT cluster FROM LiverCirrhosisPatients;




