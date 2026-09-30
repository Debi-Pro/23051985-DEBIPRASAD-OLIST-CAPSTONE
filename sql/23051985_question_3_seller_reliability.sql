SELECT
    seller_id,
    orders,
    ROUND(avg_delivery_days, 2) AS avg_delivery_days,
    ROUND(late_rate * 100, 2) AS late_rate_pct,
    ROUND(avg_review_score, 2) AS avg_review_score,
    ROUND(total_revenue, 2) AS total_revenue
FROM workspace.default.debiprasad_olist_gold_seller_reliability
WHERE orders >= 10
ORDER BY late_rate DESC, avg_review_score ASC;

SELECT
    ROUND(CORR(late_rate, avg_review_score), 3) AS lateness_review_correlation
FROM workspace.default.debiprasad_olist_gold_seller_reliability
WHERE orders >= 10;
