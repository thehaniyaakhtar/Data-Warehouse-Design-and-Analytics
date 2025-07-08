# 📊 Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project** repository! 🚀
This project demonstrates a comprehensive data warehousing and analytics solution—from building a modern data architecture to delivering actionable business insights. It follows industry best practices in data engineering, modeling, and analytics.

---

## 🏗️ Data Architecture

This project implements the **Medallion Architecture** across three layers:

* **Bronze Layer**: Stores raw data ingested from source systems (ERP and CRM) as-is.
* **Silver Layer**: Cleanses, standardizes, and transforms data for analysis.
* **Gold Layer**: Stores business-ready data in a star schema optimized for reporting and analytics.

---

## 📖 Project Overview

This end-to-end data project includes:

* **Data Architecture**: Designing a modern warehouse using Medallion Architecture.
* **ETL Pipelines**: Extracting, transforming, and loading data using SQL.
* **Data Modeling**: Creating fact and dimension tables for analytical workloads.
* **Analytics & Reporting**: Generating insights via SQL-based reports and dashboards.

---

## 🎯 Skill Areas Highlighted

This project demonstrates capabilities in:

* SQL Development
* Data Engineering
* ETL Pipeline Design
* Data Modeling
* Business Intelligence & Analytics
* Data Architecture Design

---

## 🛠️ Tools & Technologies

* **SQL Server Express**: Hosting the relational database.
* **SQL Server Management Studio (SSMS)**: For managing and querying the database.
* **Draw\.io**: For designing architecture and data models.
* **Git & GitHub**: For version control and collaboration.
* **CSV Files**: Source data from ERP and CRM systems.

---

## 🚀 Project Requirements

### 📌 Data Engineering (Warehouse)

* **Objective**: Build a modern data warehouse to consolidate sales data and support analytics.
* **Data Sources**: Two CSV-based systems (ERP and CRM).
* **Scope**:

  * Clean and resolve data quality issues.
  * Integrate data into a unified analytical model.
  * Focus on the latest dataset; historization not required.
  * Provide comprehensive documentation for data stakeholders.

### 📌 Data Analysis (BI Reporting)

* **Objective**: Deliver insights on:

  * Customer Behavior
  * Product Performance
  * Sales Trends
* **Approach**: SQL-based analytical queries and reporting views.

---

## 📂 Repository Structure

```
data-warehouse-project/
│
├── datasets/                           # Raw ERP and CRM datasets (CSV files)
│
├── docs/                               # Documentation and diagrams
│   ├── etl.drawio                      # ETL pipeline visualization
│   ├── data_architecture.drawio        # High-level architecture design
│   ├── data_catalog.md                 # Field definitions and metadata
│   ├── data_flow.drawio                # Data flow diagram
│   ├── data_models.drawio              # Star schema and data modeling diagrams
│   ├── naming-conventions.md           # Standards for naming tables/columns
│
├── scripts/                            # SQL scripts for data processing
│   ├── bronze/                         # Ingest raw data
│   ├── silver/                         # Cleanse and transform data
│   ├── gold/                           # Final analytics-ready data models
│
├── tests/                              # Data quality and validation checks
│
├── README.md                           # Project overview and setup
├── LICENSE                             # Open-source license
├── .gitignore                          # Git ignore rules
└── requirements.txt                    # Project dependencies
```
