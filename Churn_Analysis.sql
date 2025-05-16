CREATE DATABASE IF NOT EXISTS telecom_churn_analysis;
USE telecom_churn_analysis;

CREATE TABLE churn_bigml_80 (
    State VARCHAR(50),
    Account_Length INT,
    Area_Code INT,
    International_Plan VARCHAR(3),
    Voice_Mail_Plan VARCHAR(3),
    Number_Vmail_Messages INT,
    Total_Day_Minutes FLOAT,
    Total_Day_Calls INT,
    Total_Day_Charge FLOAT,
    Total_Eve_Minutes FLOAT,
    Total_Eve_Calls INT,
    Total_Eve_Charge FLOAT,
    Total_Night_Minutes FLOAT,
    Total_Night_Calls INT,
    Total_Night_Charge FLOAT,
    Total_Intl_Minutes FLOAT,
    Total_Intl_Calls INT,
    Total_Intl_Charge FLOAT,
    Customer_Service_Calls INT,
    Churn TINYINT(1)  -- Use TINYINT(1) instead of BOOLEAN for compatibility
);
SELECT COUNT(*) FROM churn_bigml_80;

SELECT 
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS Missing_State,
    SUM(CASE WHEN Account_Length IS NULL THEN 1 ELSE 0 END) AS Missing_Account_Length,
    SUM(CASE WHEN Area_Code IS NULL THEN 1 ELSE 0 END) AS Missing_Area_Code,
    SUM(CASE WHEN International_Plan IS NULL THEN 1 ELSE 0 END) AS Missing_International_Plan,
    SUM(CASE WHEN Voice_Mail_Plan IS NULL THEN 1 ELSE 0 END) AS Missing_Voice_Mail_Plan,
    SUM(CASE WHEN Number_Vmail_Messages IS NULL THEN 1 ELSE 0 END) AS Missing_Number_Vmail_Messages,
    SUM(CASE WHEN Total_Day_Minutes IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Day_Minutes,
    SUM(CASE WHEN Total_Day_Calls IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Day_Calls,
    SUM(CASE WHEN Total_Day_Charge IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Day_Charge,
    SUM(CASE WHEN Total_Eve_Minutes IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Eve_Minutes,
    SUM(CASE WHEN Total_Eve_Calls IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Eve_Calls,
    SUM(CASE WHEN Total_Eve_Charge IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Eve_Charge,
    SUM(CASE WHEN Total_Night_Minutes IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Night_Minutes,
    SUM(CASE WHEN Total_Night_Calls IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Night_Calls,
    SUM(CASE WHEN Total_Night_Charge IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Night_Charge,
    SUM(CASE WHEN Total_Intl_Minutes IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Intl_Minutes,
    SUM(CASE WHEN Total_Intl_Calls IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Intl_Calls,
    SUM(CASE WHEN Total_Intl_Charge IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Intl_Charge,
    SUM(CASE WHEN Customer_Service_Calls IS NULL THEN 1 ELSE 0 END) AS Missing_Customer_Service_Calls,
    SUM(CASE WHEN Churn IS NULL THEN 1 ELSE 0 END) AS Missing_Churn
FROM churn_bigml_80;

SELECT *, COUNT(*)  
FROM churn_bigml_80 
GROUP BY State, Account_Length, Area_Code, International_Plan, Voice_Mail_Plan,  
         Number_Vmail_Messages, Total_Day_Minutes, Total_Day_Calls, Total_Day_Charge,  
         Total_Eve_Minutes, Total_Eve_Calls, Total_Eve_Charge,  
         Total_Night_Minutes, Total_Night_Calls, Total_Night_Charge,  
         Total_Intl_Minutes, Total_Intl_Calls, Total_Intl_Charge,  
         Customer_Service_Calls, Churn  
HAVING COUNT(*) > 1  
LIMIT 1000;

-- 1. Find the Average Call Duration for Churned vs. Non-Churned Customers
SELECT 
    Churn,
    AVG(Total_Day_Minutes + Total_Eve_Minutes + Total_Night_Minutes + Total_Intl_Minutes) AS Avg_Call_Duration
FROM churn_bigml_80 
GROUP BY Churn;

-- 2. Identify Top Reasons for Churn Based on Usage Patterns
SELECT 
    Churn,
    AVG(Customer_Service_Calls) AS Avg_Service_Calls,
    AVG(Total_Intl_Calls) AS Avg_Intl_Calls,
    AVG(Total_Day_Minutes) AS Avg_Day_Minutes
FROM churn_bigml_80 
GROUP BY Churn;

-- 3. Find High-Risk Customers (Who Might Churn Soon)
SELECT  
    State,  
    Customer_Service_Calls,  
    International_Plan,  
    Total_Intl_Calls,  
    Churn  
FROM   churn_bigml_80 
WHERE (Customer_Service_Calls > 3 OR International_Plan = 'yes')  
AND Churn = '1'  
LIMIT 1000;

-- 4. State-Wise Churn Rate
SELECT  
    State,  
    COUNT(*) AS Total_Customers,  
    SUM(CASE WHEN Churn = '1' THEN 1 ELSE 0 END) AS Churned_Customers,  
    ROUND((SUM(CASE WHEN Churn = '1' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Churn_Rate  
FROM churn_bigml_80  
GROUP BY State  
ORDER BY Churn_Rate DESC;

-- 5. Revenue Loss Due to Churn
SELECT 
    SUM(Total_Day_Charge + Total_Eve_Charge + Total_Night_Charge + Total_Intl_Charge) AS Revenue_Loss
FROM churn_bigml_80 
WHERE Churn = '1';

-- 6. Churn Rate by Customer Service Calls
SELECT 
    Customer_Service_Calls, 
    COUNT(*) AS Total_Customers, 
    SUM(CASE WHEN Churn = '1' THEN 1 ELSE 0 END) AS Churned_Customers, 
    (SUM(CASE WHEN Churn = '1' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS Churn_Rate
FROM churn_bigml_80 
GROUP BY Customer_Service_Calls
ORDER BY Customer_Service_Calls;

-- 7. Customer Churn Based on International Plan
SELECT 
    International_Plan, 
    COUNT(*) AS Total_Customers, 
    SUM(CASE WHEN Churn = '1' THEN 1 ELSE 0 END) AS Churned_Customers
FROM churn_bigml_80 
GROUP BY International_Plan;

-- 8. Churn Rate Based on Voicemail Plan
SELECT 
    Voice_Mail_Plan, 
    COUNT(*) AS Total_Customers, 
    SUM(CASE WHEN Churn = '1' THEN 1 ELSE 0 END) AS Churned_Customers
FROM churn_bigml_80 
GROUP BY Voice_Mail_Plan;

-- 9. Average Revenue Per User (ARPU)
SELECT 
    AVG(Total_Day_Charge + Total_Eve_Charge + Total_Night_Charge + Total_Intl_Charge) AS ARPU
FROM churn_bigml_80 ;

-- 10. Churn Rate by Account Length
SELECT 
    CASE 
        WHEN Account_Length < 50 THEN 'Short-Term'
        WHEN Account_Length BETWEEN 50 AND 150 THEN 'Medium-Term'
        ELSE 'Long-Term'
    END AS Account_Length_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = '1' THEN 1 ELSE 0 END) AS Churned_Customers
FROM churn_bigml_80 
GROUP BY Account_Length_Group;





   











