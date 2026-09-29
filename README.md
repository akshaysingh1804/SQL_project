# SQL_project
E-Commerce Customer &amp; Sales Analytics

# Project Executive Summary
This project analyzes transactional data from an enterprise e-commerce platform to extract actionable insights across sales trends, customer acquisition, product performance, and customer retention. By transforming raw relational data into key performance indicators (KPIs), this project demonstrates how SQL can drive decision-making for marketing, inventory management, and executive strategy.

# Database Architecture
The database (`ecommerce_company`) consists of four primary relational tables:
- **customers** : Customer demographics and location data.
- **orders**: Order timestamps, total order values, and customer references.
- **orderdetails**: Item-level breakdown, quantities, and price per unit.
- **product**: Product catalog metadata and categories.
 
# Key Business Questions & Insights Addressed

# 1. Revenue & Sales Dynamics
- **Month-on-Month (MoM) Growth:** Utilized MySQL Window Functions (`LAG()`) to compute MoM growth percentage and track sales momentum over time.
- **Average Order Value (AOV):** Calculated monthly shifts in AOV to evaluate marketing campaign efficiency and upsell performance.
- **Peak Revenue Periods:** Identified top sales periods to assist inventory stocking and operational planning.

# 2. Product & Category Performance
- **High-Value Product Mix:** Identified top-grossing SKUs and premium product purchasing behaviors (average units per order combined with high aggregate revenue).
- **Category Reach:** Evaluated unique customer penetration across distinct product categories.
- **Inventory Refresh & Risk Flagging:** Pinpointed underperforming SKUs (<40% customer penetration) for potential markdown or clearance strategies.

# 3. Customer Lifecycle & Market Segmentation
- **Geographic Segmentation:** Isolated top 3 customer locations to optimize regional logistics and localized ad spending.
- **Order Frequency Distribution:** Built customer cohorts based on lifetime purchase counts to evaluate customer retention depth.
- **New Customer Acquisition:** Monitored monthly first-purchase cohorts to evaluate new customer acquisition rates.
