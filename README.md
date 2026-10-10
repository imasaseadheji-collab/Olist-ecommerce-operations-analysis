# Olist E-Commerce Operations Analysis

A portfolio-ready data analyst case study using Excel, SQL, and Power BI to investigate delivery reliability and customer experience in a 10,000-order e-commerce practice dataset.

## Business question

Customer complaints about late deliveries and poor reviews are increasing. Where is delivery performance breaking down, how large is the impact, and what should the business investigate first?

## Key findings

- **RJ** recorded the highest absolute late-delivery volume with **332 late orders**.
- **CE** recorded the highest late-delivery rate among states with at least 100 delivered orders at **25.4%**.
- Late deliveries were associated with a lower average review score than on-time deliveries.
- The dataset contained **10,000 unique orders**, no duplicate order IDs, 85 missing review scores, and one missing delivery-day value.

## Tools and workflow

**Excel** was used for rapid exploration, PivotTables, data checks, and conditional formatting. **SQL** was used for repeatable KPI queries, state-level analysis, customer-experience comparisons, and data-quality checks. **Power BI** was used to build a four-page dashboard covering executive performance, delivery performance, customer experience, and data quality.

## Dashboard views

The four screenshots are views of the **same project**, not four separate projects.

- [Executive Summary](executive-summary.png)
- [Delivery Performance](delivery-performance.png)
- [Customer Experience](customer-experience.png)
- [Data Quality](data-quality.png)

## Repository contents

- [olist_operations_analysis.sql](olist_operations_analysis.sql) — SQLite-compatible analysis queries
- [olist_ecommerce_portfolio_case_study.md](olist_ecommerce_portfolio_case_study.md) — full case-study write-up
- Four Power BI dashboard screenshots

## Recommendation

Prioritise RJ because it contributes the largest number of late deliveries, while investigating CE as the highest late-rate state among meaningful-volume segments. Review seller dispatch time, carrier handoffs, delivery distance, and promised-date accuracy, then monitor late rate, late-order volume, delivery days, and review score weekly.

## Contact

**Imasase Adheji** — Data Analyst  
Email: imasase176@gmail.com  
GitHub: https://github.com/imasaseadheji-collab  
LinkedIn: https://www.linkedin.com/in/imasase-adheji-09963b423
