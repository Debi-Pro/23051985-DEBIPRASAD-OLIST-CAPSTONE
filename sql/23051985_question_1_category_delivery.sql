SELECT
    product_category_name_english,
    orders,
    ROUND(avg_delivery_days, 2) AS avg_delivery_days,
    ROUND(avg_review_score, 2) AS avg_review_score,
    ROUND(late_rate * 100, 2) AS late_rate_pct
FROM workspace.default.debiprasad_olist_gold_category_delivery
WHERE orders >= 20
ORDER BY late_rate DESC, avg_review_score ASC;

SELECT
    ROUND(CORR(avg_delivery_days, avg_review_score), 3) AS delivery_review_correlation,
    ROUND(CORR(late_rate, avg_review_score), 3) AS late_review_correlation
FROM workspace.default.debiprasad_olist_gold_category_delivery
WHERE orders >= 20;
