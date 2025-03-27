# 📊 Telecom Customer Churn & Retention Analysis

## 📌 Project Overview
This project aims to analyze customer churn in a telecom company using **Power BI**. The objective is to **identify key factors influencing churn**, helping the business retain customers and improve profitability.

## 🎯 Business Goal
- Identify **high-risk customers** and take preventive actions.
- Understand the impact of **customer service, plan types, and charges** on churn.
- Provide data-driven insights to **reduce churn and optimize customer retention strategies**.

## 📂 Dataset
- **File Name:** `churn-bigml-80.csv`
- Contains telecom customer data with details such as:
  - Customer usage behavior (minutes, charges, etc.)
  - Subscription plans (International Plan, Voicemail Plan)
  - Customer service calls
  - Churn status (Yes/No)

## 🔍 Key Insights & KPIs
1. **Total Customers** → Distinct count of Customer ID.
2. **Churn Rate (%)** → `(Churned Customers / Total Customers) * 100`.
3. **Average Total Charge** → `AVG(Total_Charge)`.
4. **High-Risk Customers (%)** → Customers with high usage and likelihood to churn.

## 📊 Power BI Dashboard & Visualizations
The dashboard is divided into **three sections**:

### 🔹 1. Summary KPIs (Top Left - Card Visuals)
- ✅ **Total Customers**  
- ✅ **Churn Rate (%)**  
- ✅ **Avg Total Charge**  
- ✅ **High-Risk Customers (%)**  

### 🔹 2. Customer Behavior & Churn Analysis (Middle Section)
- **Churn Rate by Customer Category** *(Stacked Bar Chart)*  
  - X-Axis: Customer Category (International Plan, Voicemail Plan)  
  - Y-Axis: Count of Customers  
  - Legend: Churn (Yes/No)  

- **Customer Service Calls vs. Churn** *(Stacked Bar Chart)*  
  - X-Axis: Customer Service Calls  
  - Y-Axis: Count of Customers  

- **Churn Distribution by Plan Type** *(Pie Chart)*  
  - Legend: International Plan, Voicemail Plan  
  - Values: Count of Customers  

### 🔹 3. Total Charge & Churn Impact (Bottom Section)
- **Churn vs. Total Charge** *(Stacked Column Chart)*  
  - X-Axis: International Plan & Voicemail Plan  
  - Y-Axis: Sum of Total Charge  

- **Churn Rate by State** *(Filled Map)*  
  - Location: State  
  - Value: Churn Rate  

- **Total Charge by International Plan** *(Clustered Column Chart)*  
  - X-Axis: International Plan  
  - Y-Axis: Sum of Total Charge  

## 🛠️ DAX Calculations
```DAX
Total_Charge = [Total_Day_Minutes] * 0.5

Churn_Rate = DIVIDE(COUNTROWS(FILTER('churn-bigml-80', 'churn-bigml-80'[Churn] = 1)), COUNTROWS('churn-bigml-80')) * 100

High_Risk_Customers = DIVIDE(COUNTROWS(FILTER('churn-bigml-80', 'churn-bigml-80'[Total_Day_Minutes] > 200)), COUNTROWS('churn-bigml-80')) * 100

Retention_Rate = 100 - [Churn_Rate]

Avg_Total_Charge = AVERAGE('churn-bigml-80'[Total_Charge])
```

## 🚀 How This Analysis Helps the Business
✔ **Reduces churn** by identifying customers at risk.  
✔ **Improves customer service** based on service call analysis.  
✔ **Optimizes pricing strategies** by analyzing total charges.  
✔ **Enhances revenue & profitability** by increasing retention.  

## 📢 Conclusion
This Power BI dashboard provides **actionable insights** to help the telecom company **reduce churn and increase customer retention**. 📈  

---
🔗 **Project by:** [Your Name]  
📅 **Date:** [Your Date]  
