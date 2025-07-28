# 🛠️ Customer Intelligence Analytics Pipeline (Bronze → Gold)

**📊 Transforming Raw Retail Sales into Strategic Customer KPIs & Segments**

## 🚀 Project Summary

This project simulates a real-world **Retail Sales Analytics** pipeline by implementing a **Bronze → Silver → Gold** layered data architecture using SQL. Starting from raw transactional data, we clean, model, and transform it into powerful **customer-level insights** and **business-ready metrics**. The final output powers dashboards, CRM systems, and data-driven decision-making.

Built using:

* **SQL (MySQL)** for transformation logic
* **DB Browser for SQLite** for testing and debugging
* Structured as an **end-to-end analytical data pipeline**

---

## 🧠 What Makes This Project Different?

🔹 **Customer Intelligence Focus**: Goes beyond product-level sales to generate customer KPIs like RFM (Recency, Frequency, Monetary), lifespan, segment tags (VIP, Regular, New), and age-based grouping.
🔹 **Real-World Business Relevance**: Produces explainable metrics like Average Order Value (AOV), Monthly Spend, and Customer Lifespan — directly useful for marketing and retention.
🔹 **Gold-Layer KPIs**: Final data is transformed into a **clean, joinable view (`gold_report_customers`)** with 360° customer insights, powering **self-service BI dashboards**.

---

## 🧱 Architecture Overview

```plaintext
Raw CSV Data
     ↓
Bronze Layer: Loaded as-is into staging tables
     ↓
Silver Layer: Cleaned, validated, and de-duplicated tables
     ↓
Gold Layer: Business-ready views with customer KPIs and segmentation
```

---

## 📌 Key Components

### 🔹 Bronze Layer

* Raw transactional and customer CSVs loaded into tables
* No transformations applied

### 🔹 Silver Layer

* Cleaned invalid dates, null fields, and inconsistent keys
* Ensured referential integrity and filtered valid records

### 🔹 Gold Layer (Core Focus)

Created a consolidated view: `gold_report_customers`, which includes:

| Feature             | Description                                         |
| ------------------- | --------------------------------------------------- |
| `customer_name`     | Full name of the customer                           |
| `age_group`         | Bucketed age (Under 20, 20–29, ..., 50+)            |
| `customer_segment`  | VIP / Regular / New based on lifespan & total spend |
| `total_sales`       | Total amount spent                                  |
| `total_orders`      | Number of distinct orders                           |
| `avg_order_value`   | Total sales ÷ orders                                |
| `avg_monthly_spend` | Total sales ÷ lifespan (months)                     |
| `lifespan`          | Active months between first & last purchase         |
| `recency`           | Months since last purchase                          |

---

## 📈 13 Business Insights Extracted

After creating the gold layer, the following business-focused queries were executed:

| Insight                               | Description                                       |
| ------------------------------------- | ------------------------------------------------- |
| 1. Total Revenue by Product Category  | Identify top-performing categories for promotions |
| 2. Category-wise Revenue Contribution | Allocate marketing resources smartly              |
| 3. Top 5 Products by Revenue          | Optimize inventory & ads for best sellers         |
| 4. AOV by Category                    | Drive bundling and upselling strategies           |
| 5. Monthly Revenue Trends             | Track seasonal performance shifts                 |
| 6. Monthly Sales per Category         | Improve demand forecasting                        |
| 7. Avg Customer Age per Category      | Enable targeted demographic marketing             |
| 8. RFM Analysis                       | Power loyalty scoring and lifecycle models        |
| 9. Segmenting Customers               | Tag as VIP, Regular, or New for priority handling |
| 10. Age Group Distribution            | Create age-specific campaigns                     |
| 11. Customer Lifespan                 | Support churn prediction                          |
| 12. Customer-Level Metrics            | Feed into CRM dashboards                          |
| 13. Gold View Creation                | Enable self-service BI for stakeholders           |

---
