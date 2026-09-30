WITH customer_orders AS (
    SELECT
        customer_unique_id,
        order_id,
        order_quarter,
        SUM(revenue) AS order_revenue
    FROM workspace.default.debiprasad_olist_silver_orders
    GROUP BY customer_unique_id, order_id, order_quarter
),
customer_order_counts AS (
    SELECT
        customer_unique_id,
        COUNT(*) AS order_count
    FROM customer_orders
    GROUP BY customer_unique_id
)
SELECT
    c.order_quarter,
    ROUND(SUM(c.order_revenue), 2) AS total_revenue,
    ROUND(SUM(CASE WHEN x.order_count > 1 THEN c.order_revenue ELSE 0 END), 2) AS repeat_customer_revenue,
    ROUND(
        100 * SUM(CASE WHEN x.order_count > 1 THEN c.order_revenue ELSE 0 END)
        / NULLIF(SUM(c.order_revenue), 0),
        2
    ) AS repeat_revenue_share_pct
FROM customer_orders c
JOIN customer_order_counts x
    ON c.customer_unique_id = x.customer_unique_id
GROUP BY c.order_quarter
ORDER BY c.order_quarter;
