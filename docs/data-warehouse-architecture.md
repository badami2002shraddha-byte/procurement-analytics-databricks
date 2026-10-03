# Procurement Data Warehouse Architecture

## 1. Overview

The procurement analytics solution uses a star schema to analyze purchase order data. Dimension tables provide descriptive information, while the fact table stores measurable procurement transactions.

## 2. Star Schema

### Fact Table: `fact_purchase_orders`

**Grain:** One product line per purchase order.

| Column           | Description                           |
| ---------------- | ------------------------------------- |
| `po_number`      | Purchase order identifier             |
| `date_key`       | Reference to the date dimension       |
| `vendor_key`     | Reference to the vendor dimension     |
| `product_key`    | Reference to the product dimension    |
| `department_key` | Reference to the department dimension |
| `quantity`       | Quantity purchased                    |
| `unit_price`     | Price per unit                        |
| `total_amount`   | Quantity multiplied by unit price     |

### Dimension Tables

* **`dim_date`** — Full date, day, month, quarter, and year.
* **`dim_vendor`** — Vendor name, city, and category.
* **`dim_product`** — Product name and product category.
* **`dim_department`** — Department name and business unit.

## 3. Data Pipeline

### Bronze Layer

Stores the initial purchase order records in a Delta table named `bronze_purchase_orders`.

### Silver Layer

Cleans the records by removing rows with missing required fields, non-positive quantities, or non-positive unit prices. The cleaned data is stored in `silver_purchase_orders`.

### Gold Layer

Creates aggregated datasets for:

* Vendor spend
* Product category spend
* Department spend

These datasets support dashboard reporting and business analysis.

## 4. Data Quality Validation

The project validates row counts and checks that fact-table keys match their corresponding dimension records.

## 5. Business Value

The dashboard helps users monitor procurement spending, compare vendor spending, understand department-level expenditure, and track spending over time.
