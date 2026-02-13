-- Check missing values
SELECT 
    COUNT(*) FILTER (WHERE user_id IS NULL) AS null_user,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS null_product,
    COUNT(*) FILTER (WHERE category IS NULL) AS null_category,
    COUNT(*) FILTER (WHERE price IS NULL) AS null_price,
    COUNT(*) FILTER (WHERE final_price IS NULL) AS null_final_price,
    COUNT(*) FILTER (WHERE purchase_date IS NULL) AS null_date
FROM ecommerce;

-- Check negative or zero price / final price
SELECT *
FROM ecommerce
WHERE price <= 0 OR final_price <= 0;

-- Check discount range
SELECT *
FROM ecommerce
WHERE discount < 0 OR discount > 100;

-- Price and final price logic check
SELECT *,
       price * (1 - discount/100.0) AS expected_final_price
FROM ecommerce
WHERE ABS(final_price - price * (1 - discount/100.0)) > 0.01;

-- Check duplicate rows
SELECT user_id, product_id, purchase_date, COUNT(*)
FROM ecommerce
GROUP BY user_id, product_id, purchase_date
HAVING COUNT(*) > 1;

-- Check unique category
SELECT DISTINCT category
FROM ecommerce
ORDER BY category;

-- Check unique payment method
SELECT DISTINCT payment_method
FROM ecommerce;

-- Data type validation
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'ecommerce';

-- Date range validation
SELECT MIN(purchase_date), MAX(purchase_date)
FROM ecommerce;

-- Revenue trend
WITH Monthly_Stats AS (
    SELECT 
        DATE_TRUNC('month', Purchase_Date) AS month_raw,
        SUM(Final_Price) AS total_revenue,
        COUNT(DISTINCT DATE_TRUNC('day', Purchase_Date)) AS active_days
    FROM ecommerce
    GROUP BY 1
),
Calculated_Daily AS (
    SELECT 
        TO_CHAR(month_raw, 'MM-YYYY') AS month_label,
        total_revenue,
        active_days,
        -- Calculate Average Daily Revenue (ADR)
        ROUND(total_revenue / active_days, 2) AS avg_daily_revenue
    FROM Monthly_Stats
)
SELECT 
    month_label,
    active_days,
    total_revenue,
    avg_daily_revenue,
    LAG(avg_daily_revenue) OVER (ORDER BY TO_DATE(month_label, 'MM-YYYY')) AS prev_avg_daily,
    -- Growth percentage based on DAILY performance
    ROUND(
        ((avg_daily_revenue - LAG(avg_daily_revenue) OVER (ORDER BY TO_DATE(month_label, 'MM-YYYY'))) / 
        LAG(avg_daily_revenue) OVER (ORDER BY TO_DATE(month_label, 'MM-YYYY'))) * 100, 2
    ) AS daily_growth_percentage
FROM Calculated_Daily
ORDER BY TO_DATE(month_label, 'MM-YYYY');

-- Customer Lifetime Value (CLV)
WITH User_Metrics AS (
    SELECT 
        User_ID,
        SUM(Final_Price) AS total_revenue,
        COUNT(Product_ID) AS total_transactions
    FROM ecommerce
    GROUP BY User_ID
)
SELECT 
    ROUND(AVG(total_revenue / total_transactions),2) AS avg_order_value,
    ROUND(AVG(total_transactions),2) AS avg_purchase_frequency,
    -- Simple CLV formula: AOV * Frequency
    ROUND(AVG(total_revenue / total_transactions) * AVG(total_transactions),2) AS simple_clv
FROM User_Metrics;

-- Revenue by category
SELECT 
    Category,
    COUNT(*) AS total_transactions,
    SUM(Final_Price) AS total_revenue,
    ROUND(AVG(Final_Price), 2) AS avg_transaction_value,
    ROUND((SUM(Final_Price) / SUM(SUM(Final_Price)) OVER()) * 100, 2) AS revenue_percentage
FROM ecommerce
GROUP BY Category
ORDER BY total_revenue DESC;

-- Payment method usage
SELECT 
    Payment_Method,
    COUNT(*) AS usage_count,
    SUM(Final_Price) AS total_revenue,
    ROUND(AVG(Final_Price), 2) AS avg_spend_per_method,
    ROUND((COUNT(*)::NUMERIC / SUM(COUNT(*)) OVER()) * 100, 2) AS popularity_percentage
FROM ecommerce
GROUP BY Payment_Method
ORDER BY usage_count DESC;

-- Discount impact
SELECT 
    CASE 
        WHEN Discount = 0 THEN '0% Full Price'
        WHEN Discount <= 10 THEN '5-10% Small Discount'
        WHEN Discount <= 20 THEN '15-20% Mid Promo'
        ELSE '25%+ Heavy Clearance'
    END AS discount_strategy,
    COUNT(*) AS volume_of_sales,
    SUM(Final_Price) AS total_revenue,
    ROUND(AVG(Final_Price), 2) AS avg_sale_value
FROM ecommerce
GROUP BY 1
ORDER BY MIN(Discount) ASC;