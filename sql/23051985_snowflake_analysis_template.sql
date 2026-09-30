-- Snowflake analysis worksheet template.
-- Intended to run after the three Gold tables are loaded into Snowflake.
-- Not executed because a working Snowflake account was not available.

-- Q1
SELECT
    product_category_name_english,
    orders,
    ROUND(avg_delivery_days, 2) AS avg_delivery_days,
    ROUND(avg_review_score, 2) AS avg_review_score,
    ROUND(late_rate * 100, 2) AS late_rate_pct
FROM GOLD_CATEGORY_DELIVERY
WHERE orders >= 20
ORDER BY late_rate DESC, avg_review_score ASC;

-- Q2
SELECT
    order_quarter,
    total_revenue,
    repeat_customer_revenue,
    repeat_revenue_share_pct
FROM GOLD_CUSTOMER_REVENUE
ORDER BY order_quarter;

-- Q3
SELECT
    seller_id,
    orders,
    avg_delivery_days,
    late_rate * 100 AS late_rate_pct,
    avg_review_score,
    total_revenue
FROM GOLD_SELLER_RELIABILITY
WHERE orders >= 10
ORDER BY late_rate DESC, avg_review_score ASC;
