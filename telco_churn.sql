-- Database: telco_churn

-- DROP DATABASE IF EXISTS telco_churn;
DROP TABLE IF EXISTS telco_data CASCADE;

CREATE TABLE telco_data (
    Customer_ID TEXT, Gender TEXT, Age INT, Under_30 TEXT, Senior_Citizen TEXT, 
    Married TEXT, Dependents TEXT, Number_of_Dependents INT, Country TEXT, 
    State TEXT, City TEXT, Zip_Code INT, Latitude NUMERIC, Longitude NUMERIC, 
    Population INT, Quarter TEXT, Referred_a_Friend TEXT, Number_of_Referrals INT, 
    Tenure_in_Months INT, Offer TEXT, Phone_Service TEXT, Avg_Monthly_Long_Distance_Charges NUMERIC, 
    Multiple_Lines TEXT, Internet_Service TEXT, Internet_Type TEXT, Avg_Monthly_GB_Download INT, 
    Online_Security TEXT, Online_Backup TEXT, Device_Protection_Plan TEXT, 
    Premium_Tech_Support TEXT, Streaming_TV TEXT, Streaming_Movies TEXT, 
    Streaming_Music TEXT, Unlimited_Data TEXT, Contract TEXT, Paperless_Billing TEXT, 
    Payment_Method TEXT, Monthly_Charge NUMERIC, Total_Charges NUMERIC, 
    Total_Refunds NUMERIC, Total_Extra_Data_Charges INT, Total_Long_Distance_Charges NUMERIC, 
    Total_Revenue NUMERIC, Satisfaction_Score INT, Customer_Status TEXT, 
    Churn_Label TEXT, Churn_Score INT, CLTV INT, Churn_Category TEXT, Churn_Reason TEXT
);
ALTER USER postgres WITH PASSWORD 'Sanika123';

SELECT count(*) FROM telco_data;

COPY telco_data(customer_id, gender, age, tenure_months, monthly_charge, total_revenue, cltv, satisfaction_score, churn_score, churn_label)
FROM 'C:\Users\Sanika\SQL_project\telco.csv' 
DELIMITER ',' 
CSV HEADER;

TRUNCATE TABLE telco_data;

SELECT * FROM public.telco_data LIMIT 10;



SELECT 
    customer_id, 
    city, 
    cltv, 
    ROUND(churn_probability::numeric, 3) as risk_level
FROM churn_predictions
WHERE churn_label = 'No' AND churn_probability > 0.7
ORDER BY cltv DESC;


SELECT customer_id, churn_probability 
FROM churn_predictions 
WHERE churn_label = 'No' 
ORDER BY churn_probability DESC 
LIMIT 10;

--To see the actual fruit of your labor
SELECT 
    customer_id, 
    cltv, 
    ROUND(churn_probability::numeric, 3) as risk_score
FROM churn_predictions
WHERE churn_label = 'No' 
ORDER BY churn_probability DESC
LIMIT 10;


--The "Business Insight" Query
SELECT 
    city, 
    COUNT(*) as total_customers, 
    ROUND(AVG(churn_probability::numeric), 2) as average_risk
FROM churn_predictions
GROUP BY city
HAVING COUNT(*) > 10
ORDER BY average_risk DESC
LIMIT 5;



--The "Risk Geography" Analysis (SQL)
--A company needs to know where to send their marketing teams.
SELECT 
    city, 
    COUNT(*) AS at_risk_count,
    ROUND(AVG(churn_probability::numeric), 2) AS avg_risk_score
FROM churn_predictions
WHERE churn_label = 'No' 
GROUP BY city
-- We removed the > 0.7 filter and the > 5 count to see EVERY city
ORDER BY avg_risk_score DESC
LIMIT 10;
