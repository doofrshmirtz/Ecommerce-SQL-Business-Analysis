# E-Commerce SQL Business Analysis

## Executive Summary

This project analyses approximately 100,000 orders from the Brazilian
Olist e-commerce marketplace using PostgreSQL.

The analysis focuses on revenue performance, customer retention,
customer value, average order value and geographic sales distribution.

## Business Objectives

- Identify the highest-revenue product categories
- Analyse monthly revenue development
- Measure customer lifetime value
- Calculate repeat-customer behaviour
- Track average order value
- Identify high-performing states and cities

## Dataset

The project uses the Olist Brazilian E-Commerce Dataset.

Main tables:

- orders
- customers
- order_items
- products
- payments
- sellers
- reviews

## Tools

- PostgreSQL
- DBeaver
- Python
- Pandas
- SQLAlchemy
- Jupyter Notebook

## Database Structure

Add the database-schema image here.

## Analysis

### 1. Product Category Revenue

Business question:

Which product categories generate the highest revenue?

Key finding:

Beauty and Health generated approximately R$1.26 million in revenue
and was the highest-performing product category.

![Top product categories](screenshots/01_top_revenue_products.png)

SQL file:

`queries/01_top_revenue_products.sql`

### 2. Monthly Revenue Trend

Business question:

How did delivered-order revenue change over time?

Key finding:

Revenue increased strongly during the observation period, with a
noticeable peak around November 2017.

![Monthly revenue trend](screenshots/02_monthly_revenue_trend.png)

SQL file:

`queries/02_monthly_revenue_trend.sql`

### 3. Customer Lifetime Value

Add your verified result here.

![Customer lifetime value](screenshots/03_customer_lifetime_value.png)

SQL file:

`queries/03_customer_lifetime_value.sql`

### 4. Customer Retention

The analysis found that the overwhelming majority of customers placed
only one order, indicating a major retention opportunity.

![Repeat customer rate](screenshots/04_repeat_customer_rate.png)

SQL file:

`queries/04_repeat_vs_new_customers.sql`

### 5. Average Order Value

Average order value remained relatively stable across the analysed
period.

![Average order value](screenshots/05_average_order_value.png)

SQL file:

`queries/05_average_order_value.sql`

### 6. Geographic Sales Distribution

São Paulo was the strongest geographic market by revenue and order
volume.

![Geographic sales](screenshots/06_geographic_sales_distribution.png)

SQL file:

`queries/06_geographic_sales_distribution.sql`

## SQL Skills Demonstrated

- Multi-table joins
- Aggregations
- Conditional logic
- Subqueries and CTEs
- Date-based analysis
- Customer-level analysis
- KPI calculation
- Business insight generation

## Repository Structure

```text
Ecommerce-SQL-Business-Analysis/
├── notebooks/
│   └── data_loading.ipynb
├── queries/
│   ├── 01_top_revenue_products.sql
│   ├── 02_monthly_revenue_trend.sql
│   ├── 03_customer_lifetime_value.sql
│   ├── 04_repeat_vs_new_customers.sql
│   ├── 05_average_order_value.sql
│   └── 06_geographic_sales_distribution.sql
├── screenshots/
└── README.md
