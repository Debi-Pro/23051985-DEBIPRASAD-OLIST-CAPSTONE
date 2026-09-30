# Olist E-Commerce Analytics — Databricks Capstone

**Student:** Debiprasad Mishra  
**Roll Number:** 23051985  
**Dataset:** Olist Brazilian e-commerce dataset  
**Architecture:** Bronze → Silver → Gold → Snowflake handover design

## Project Overview

This project builds an end-to-end analytics pipeline for the Olist Brazilian e-commerce dataset. Raw CSV files are landed in Databricks, stored as Bronze Delta tables, cleaned and joined into a Silver analytical dataset, and aggregated into three Gold business tables.

The pipeline is orchestrated with a Databricks multi-task Job:

`Bronze → Silver → Gold`

## Business Questions

1. Which product categories have the worst delivery performance and how does it relate to review scores?
2. What share of revenue comes from repeat customers and how does it change quarter by quarter?
3. Which sellers have high late-delivery rates and how does seller lateness relate to review scores?

## Dataset

The project uses the nine Olist CSV datasets:

- orders
- order items
- payments
- reviews
- customers
- sellers
- products
- geolocation
- category translation

### Bronze input row counts

| Dataset | Rows |
|---|---:|
| Orders | 99,441 |
| Customers | 99,441 |
| Order items | 112,650 |
| Payments | 103,886 |
| Reviews | 104,162 |
| Products | 32,951 |
| Sellers | 3,095 |
| Geolocation | 1,000,163 |
| Category translation | 71 |

## Pipeline

### Bronze

Raw CSV files are loaded from the Olist source into the Databricks managed volume and written as Delta tables. No analytical aggregation is performed in Bronze.

### Silver

The Silver layer standardizes timestamp fields, removes duplicate order/order-item keys, aggregates payment and review information at order level, joins customers, sellers, products and translated categories, and derives analytical fields including delivery days, estimated delivery days, late flag, order quarter and revenue.

The resulting analytical dataset contains **113,425 rows** at order-item analytical grain.

### Gold

Three business tables are produced:

- `debiprasad_olist_gold_category_delivery`
- `debiprasad_olist_gold_customer_revenue`
- `debiprasad_olist_gold_seller_reliability`

These tables aggregate the Silver data for the three business questions.

## Databricks Job

The successful run used three dependent Serverless tasks:

`bronze → silver → gold`

The captured run shows all three tasks succeeded.

## Analysis Findings

### Q1 — Category delivery and reviews

In the displayed Gold output, `home_comfort_2` has a 16.67% late rate, followed by `furniture_mattress_and_upholstery` at 13.16% and `audio` at 12.64%. `office_furniture` has the highest displayed average delivery time at 20.79 days among the shown categories and an average review score of 3.49. Results should be interpreted together with order volume; for example, `home_comfort_2` has 24 orders while `bed_bath_table` has 9,417.

### Q2 — Repeat-customer revenue

The customer-level Gold output tracks repeat-customer share by customer count. The SQL analysis additionally calculates the requested **repeat-customer revenue share**. The revenue-based results show repeat-customer revenue share of 3.48% in 2016-Q4, rising to 7.35% in 2017-Q2 and 7.34% in 2017-Q3, before declining to 4.62% in 2018-Q3. The 2018-Q4 row has zero revenue and is not economically meaningful.

### Q3 — Seller reliability

The displayed seller output shows substantial variation in late-delivery rates. The first seller has a 50.00% late rate and an average review score of 1.72; the second has a 48.94% late rate and a 2.57 average review score. Seller results are filtered to sellers with at least 10 orders.

## Snowflake Handover

The capstone brief specifies a file-based Gold → Snowflake handover using a stage, `COPY INTO`, and `COPY_HISTORY`.

A Snowflake handover and analysis SQL template is included in `sql/`. A working Snowflake account was not available during implementation, so no Snowflake load or `COPY_HISTORY` result is represented as completed evidence in this repository.

## Repository Contents

- `notebooks/` — exported Databricks notebooks
- `sql/` — analysis queries and Snowflake handover templates
- `architecture/` — architecture diagram and project report
- `evidence/` — successful Databricks Job evidence
- `hosted_project/` — static hosted project page
- `documentation/` — submission notes
- `demo/` — five-minute demo script

## Technology Stack

- Databricks Free Edition
- Apache Spark / PySpark
- Delta tables
- SQL
- Snowflake handover design
- GitHub Pages-compatible static HTML

## Reproducibility

The notebooks use the Databricks managed volume path and namespaced table names used during implementation. The Bronze notebook loads the nine Olist CSV files, the Silver notebook creates the cleaned joined dataset, and the Gold notebook creates the three analytical tables.
