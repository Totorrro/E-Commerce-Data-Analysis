# E-Commerce-Data-Analysis

This project analyzes an e-commerce dataset using SQL for data validation and analysis, and Power BI for interactive reporting.  
The goal is to explore sales performance and discount impact, and to demonstrate data cleaning, KPI design, and business insight generation.

---

## 📌 Project Overview

This project simulates a real-world e-commerce analytics task.  
SQL is used to validate and analyze the dataset, and Power BI is used to build an interactive business intelligence report.

---

## 🛠 Tools Used

- SQL (PostgreSQL) – Data validation and analysis  
- Power BI Desktop – Data visualization and dashboard  
- GitHub – Documentation and project sharing  

---

## 📂 Dataset

The dataset contains transaction-level e-commerce data with the following fields:

- user_id  
- product_id  
- category  
- price  
- discount  
- final_price  
- payment_method  
- purchase_date  

---

## 🧹 Data Validation (SQL)

The following data quality checks were performed:

- Missing values check  
- Negative and zero price validation  
- Discount range validation (0–100%)  
- Final price calculation consistency check  
- Duplicate transaction detection  
- Data type validation  
- Date range validation  

📁 SQL file: `sql/sql_validation.sql`

---

## 📊 Data Analysis (SQL)

Key analyses performed:

- Monthly revenue trend and growth analysis  
- Customer Lifetime Value (CLV) estimation  
- Revenue distribution by product category  
- Payment method usage analysis  
- Discount impact on sales volume and revenue  

📁 SQL file: `sql/sql_analysis.sql`

---

## 📈 Power BI Report

The Power BI report contains three pages:

### 1️⃣ Executive Overview  
- Total Revenue  
- Total Customers  
- Average Order Value (AOV)  
- Revenue trend by month  
- Revenue by category  
- Payment method distribution  

### 2️⃣ Customer Insights  
- Customer Lifetime Value (CLV)  
- Purchase frequency  
- Customer segmentation (One-time vs Repeat buyers)  

### 3️⃣ Discount Strategy Analysis  
- Revenue by discount bracket  
- Sales volume by discount level  
- Average transaction value by discount  

📁 Power BI file: `powerbi/ecommerce_dashboard.pbix`  
📁 PDF export: `powerbi/ecommerce_dashboard.pdf`

---

## 🖼 Dashboard Screenshots

### Executive Overview
![Overview](screenshots/overview.png)

### Customer Insights
![Customer](screenshots/customer.png)

### Discount Analysis
![Discount](screenshots/discount.png)

---

## 💡 Key Business Insights

- Revenue is evenly distributed across product categories.  
- Credit card and UPI are the most frequently used payment methods.  
- Higher discounts increase sales volume but reduce average transaction value.  
- Most customers are one-time buyers, indicating low retention.  
- Average Order Value is around 200, indicating a mid-priced e-commerce platform.  

---

## 🚀 Future Improvements

- Build a star schema (fact and dimension tables)  
- Perform RFM customer segmentation  
- Conduct cohort retention analysis  
- Add product cost data to calculate profit  
- Forecast future revenue trends  

---

## 📬 Contact

Feel free to connect with me on GitHub or LinkedIn for collaboration opportunities.
