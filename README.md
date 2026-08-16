# Revenue & Operations Intelligence Platform

An end-to-end analytics engineering and business intelligence platform built on 99,441 e-commerce orders from the Brazilian Olist marketplace. The project implements a Databricks Medallion Architecture (Bronze &rarr; Silver &rarr; Gold), a dimensional data model in Power BI, an executive insights report, and a roadmap toward operational machine learning.

---

## Repository Structure

```text
revenue_operations/
├── dashboard/
│   ├── revenue_operaions.pbix            # Power BI interactive report (4 pages)
│   ├── revenue_operaions.pbit            # Power BI template file (schema & layout)
│   └── revenue_operaions_dashboard.pdf   # Exported dashboard page snapshots
├── data/
│   ├── raw/                              # Source transactional CSV datasets (9 files)
│   ├── processed/                        # Processed intermediate storage
│   └── external/                         # External reference datasets
├── docs/
│   ├── 01_data_discovery.md              # Source data profiling & candidate key audit
│   ├── er.sql                            # Relational schema DDL & integrity constraints
│   ├── ERDaigram.webp                    # Entity-Relationship diagram
│   ├── Orders dataset.txt
│   └── Revenue and Operations Intelligence.html
├── notebooks/
│   ├── 01_bronze_ingestion.ipynb         # Bronze layer: raw ingestion & file tracking
│   ├── 01_source_data_profile.ipynb      # EDA: schema profiling, missing values, duplicates
│   ├── 02_silver_customers_products_sellers.ipynb
│   ├── 02_silver_order_order_items_products.ipynb
│   ├── 02_silver_reviews_geolocation_product_categrory_translation.ipynb
│   └── 03_gold_core_business_table.ipynb # Gold layer: star schema dimensional modeling
├── Revenue_Operations_Business_Insights_Report.pdf # 3-page executive business report
└── README.md
```

---

## Data Architecture & Pipeline (Medallion Pattern)

The data pipeline processes raw transactional data into optimized analytical tables using PySpark and Delta Lake:

```
[ Raw CSV Data ] 
       │
       ▼
[ Bronze Layer ]   Raw ingestion, file tracking, audit metadata
       │
       ▼
[ Silver Layer ]   Deduplication, type casting, category translation, data quality checks
       │
       ▼
[ Gold Layer ]     Star schema modeling (fact_orders, fact_order_items, dim_customers)
       │
       ▼
[ Power BI Layer ] DAX measures, semantic modeling, 4-page executive dashboard
       │
       ▼
[ Executive PDF ]  Revenue_Operations_Business_Insights_Report.pdf
```

### 1. Bronze Layer (Ingestion & Profiling)
* **Scope:** Ingestion of 9 raw CSV datasets (`customers`, `orders`, `order_items`, `payments`, `reviews`, `products`, `sellers`, `geolocation`, and `product_category_name_translation`).
* **Tasks:** Ingestion timestamp tracking, source file naming, row/column count audits, and null-value profiling.

### 2. Silver Layer (Cleansing & Conformance)
* **Scope:** Standardizing schemas and enforcing referential consistency across datasets.
* **Tasks:**
  * Deduplicating multi-row geographic coordinates and seller records.
  * Standardizing timestamps (`order_purchase_timestamp`, `order_delivered_customer_date`, `order_estimated_delivery_date`).
  * Joining Portuguese product categories with English translations.
  * Handling review text sparsity while preserving raw rating distributions.

### 3. Gold Layer (Dimensional Modeling)
* **`fact_orders` (Order Grain — 99,441 rows):** Central fact table containing order timestamps, delivery duration (`delivery_days`), estimated transit duration, payment totals (`total_payment_value`), average review scores, and SLA compliance flags (`on_time`, `late`, `not_delivered`).
* **`fact_order_items` (Order-Item Grain — 102,425 rows):** Item-level transaction details capturing product IDs, seller IDs, item quantity, product subtotal (`price`), and allocated freight charges (`freight_value`).
* **`dim_customers` (Unique Customer Grain — 96,096 rows):** Customer dimension resolving `customer_id` into `customer_unique_id`, tracking first/last purchase dates, order frequency bins, total lifetime spend, and repeat buyer classification (`repeat` vs `one-time`).
* **`geolocation`:** Reference dimension mapping postal code prefixes to state and city boundaries.

---

## Key Metrics & Verified Findings

From the Gold fact and dimension tables:

| Metric Category | Metric Name | Value | Analytical Context |
| :--- | :--- | :--- | :--- |
| **Financials** | Gross Payment Revenue | **$16,008,872.12** | Total customer payments across all completed orders |
| | Net Product Sales | **$13,591,643.70** | Total merchandise value excluding freight charges |
| | Freight Revenue | **$2,251,909.54** | Shipping charges collected (14.1% of gross revenue) |
| | Average Order Value (AOV) | **$160.99** | Revenue per completed order |
| **Customer Dynamics** | Unique Customer Base | **96,096** | Total distinct buyer entities |
| | Repeat Customer Rate | **3.12%** | Only 2,997 customers placed &ge; 2 orders; 93,099 are single-buyers |
| | Average Orders / Customer | **1.03** | Low repeat purchase velocity |
| | Average Customer LTV | **$166.59** | Total revenue divided by unique customers |
| **Operations & SLAs** | On-Time Delivery Rate | **89.15%** | 88,649 shipments delivered on or before estimated date |
| | Late Delivery Rate | **7.17%** | Orders delayed beyond SLA in dashboard model |
| | Average Delivery Time | **12.50 Days** | Mean duration from purchase to customer receipt |
| | Overall CSAT | **4.09 / 5.00** | Average customer review score across all orders |
| **CSAT Association** | On-Time Order CSAT | **4.29 / 5.00** | Healthy customer satisfaction baseline |
| | Late Order CSAT | **2.57 / 5.00** | **1.72-star difference** associated with delivery delays |

---

## Power BI Dashboard Overview

The Power BI suite ([revenue_operaions.pbix](file:///c:/Users/prajw/Desktop/Projects/revenue_operations/dashboard/revenue_operaions.pbix)) is organized into 4 dedicated pages:

1. **Executive Revenue & Operations Overview:** High-level executive scorecard tracking gross revenue, order volume, repeat customer rate, on-time delivery %, monthly revenue trajectory, and top product categories.
2. **Revenue Analysis:** Detailed financial breakdown analyzing sales by product category, seller contributions, day-of-week purchase distribution, and state-level revenue concentration (SP generates 37.5%, RJ 13.4%, MG 11.7%).
3. **Customer Analysis:** Deep dive into customer acquisition cohorts, purchase frequency distribution (1 order vs 2+ orders), geographic customer density, and top lifetime spenders.
4. **Operations & Delivery Analysis:** Logistics evaluation tracking delivery durations, state-specific late rates (RJ at 12.95% and BA at 13.52% vs SP at 5.72%), seller SLA compliance, and the correlation between transit duration and customer review scores.

---

## Executive Report Deliverable

A formal 3-page business report is generated at the repository root:
* **File:** [`Revenue_Operations_Business_Insights_Report.pdf`](file:///c:/Users/prajw/Desktop/Projects/revenue_operations/Revenue_Operations_Business_Insights_Report.pdf)
* **Contents:**
  1. Executive Summary & Core KPI Cards
  2. Revenue Performance & Category Breakdown (with Monthly Trend and Category Net Sales charts)
  3. Customer Retention Dynamics (with Purchase Frequency distribution chart)
  4. Operations & Delivery Performance (with CSAT by Delivery Status and State Late Rate charts)
  5. 4 Actionable Business Recommendations (Seller SLA governance, regional logistics routing, CRM re-engagement, core category protection)
  6. Next Analytical Step: Delivery Risk Prediction

---

## Current Project Status & Next Steps

### Completed Milestones
- [x] Source data discovery and ER schema design (`docs/01_data_discovery.md`, `docs/er.sql`)
- [x] PySpark Medallion pipeline implementation (Bronze &rarr; Silver &rarr; Gold in `notebooks/`)
- [x] Star schema dimensional model and DAX measure formulation
- [x] Power BI reporting suite implementation (`dashboard/revenue_operaions.pbix`)
- [x] Executive Insights Report compilation (`Revenue_Operations_Business_Insights_Report.pdf`)

### Upcoming Milestone: Machine Learning Phase
* **Objective:** Build a supervised classification model for **Delivery Risk Prediction** to forecast late delivery risk at the point of order creation/approval.
* **Business Purpose:** Enable operations to proactively identify high-risk shipments, evaluate carrier routing, or notify customers before delivery SLAs are breached, mitigating delivery delays and protecting customer satisfaction.
