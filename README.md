# datawarehousing-project-sql
A case study data warehousing project using SQL queries.

# OfficeProducts Data Warehouse Project (Case Study)

## 📝 Overview  
This project involves the **design, implementation, and analysis of a data warehouse** for *OfficeProducts*, a major supplier of office products with a strong online presence.  

The project is divided into two main sections:  
1. **Data Warehouse Design & Implementation (Section A)**  
2. **Multidimensional Data Analysis with OLAP (Section B)**  

The overall goal is to build a scalable warehouse schema, simulate ETL, and perform advanced SQL queries to uncover business insights such as top-performing products, regions, and promotional strategies.  

---

## 1️Section A – Data Warehouse Schema: Design & Implementation  

### Objectives  
- Design a **snowflake schema** to capture both transactional and master data.  
- Create an **Entity-Relationship Diagram (ERD)** for the warehouse.  
- Implement **ETL processes** to load data from transactional and master sources into the warehouse.  

### Schema Design  
The schema supports multi-dimensional analysis of sales and profit, enabling queries such as:  
- Product sales by client and region.  
- Total product sales by time period.  
- Profitability per product category.  

**Key Components**  
- **Fact Table**: `SALES_FACT`  
- **Dimension Tables**:  
  - `SUPPLIER_DIM`  
  - `PRODUCT_CATEGORY_DIM`  
  - `PRICE_RANGE_DIM`  
  - `PRODUCT_DIM`  
  - `TRANSACTION_DATE_DIM`  
  - `CHANNEL_DIM`  
  - `REGION_DIM`  
  - `CLIENT_DIM`  
- **Bridge Table**: `PRODUCT_SUPPLIER_BRIDGE`  

Indexes and foreign key dependencies were created to optimize performance.  

---

## Section B – Multidimensional Data Analysis  

### Tools Used  
- **SQL (Oracle SQL Developer)**  
- **OLAP Features** such as `GROUP BY`, `ROLLUP`, and `CUBE`  
- **Materialized Views** for aggregate queries  

### Example Insights  
- **Top Countries by Sales**: USA, Germany, and Japan.  
- **Promotion Effectiveness**:  
  - Promo ID `999` generated the highest sales (~$94.5M).  
  - Promo ID `33` generated the lowest (~$0.27M), highlighting potential weaknesses in execution.  
- **Channel Performance**:  
  - "No Promotion" categories often outperformed Internet/TV campaigns.  
  - Direct Sales and Partner channels performed strongly without heavy promotions.  

---

## Project Structure  
- `SQL_Scripts/` → SQL code for schema creation, ETL, and queries  
- `Reports/` → Screenshots, query outputs, and analysis answers  
- `README.md` → Project documentation (this file)  

---

## Conclusion  
This project demonstrates how a **snowflake schema** and OLAP techniques can be applied to analyze retail business data.  
- The data warehouse design supports complex queries across multiple dimensions.  
- SQL aggregation and OLAP queries provide valuable insights for sales, promotions, and channel strategies.  
- Findings can guide management decisions, such as focusing on high-performing promotions and optimizing underperforming campaigns.

---

## Files 
This project contains two `.sql` files:
- `createDW.sql`: For Section A.
- `queriesDW.sql`: For Section B.

---
