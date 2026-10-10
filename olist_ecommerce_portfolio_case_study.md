# Olist E-Commerce Operations Analysis

**Tools:** Excel · SQL · Power BI  
**Role:** Data Analyst  
**Dataset:** 10,000-order practice subset of the Brazilian Olist e-commerce dataset  
**Analysis period:** October–December 2017

## Project overview

This project simulates a real-world assignment for a junior operations data analyst supporting an e-commerce leadership team.

The manager’s request was:

> Customer complaints about late deliveries and poor reviews are increasing. Identify where the problem is concentrated, quantify the operational impact, and recommend the first actions the business should take.

I analysed order volume, paid order value, delivery reliability, delivery time, customer reviews, state-level performance, and data quality. The work was completed using Excel for rapid exploration, SQL for repeatable analysis, and Power BI for manager-facing reporting.

## Business questions

The analysis focused on five questions:

1. How is the business performing overall?
2. Which states have the highest late-delivery rates?
3. Which states contribute the greatest number of late deliveries?
4. Are late deliveries associated with lower customer review scores?
5. Can the data be trusted for operational reporting?

## Data and preparation

The practice dataset contains one row per order in the prepared `fact_orders` table, supported by related order, payment, item, review, customer, product, and seller tables.

Before analysing the data, I checked:

- Order-level grain and duplicate order IDs
- Missing delivery-duration values
- Missing late-delivery flags
- Missing review scores
- Text-versus-number formatting issues
- The risk of duplicated payment values when joining one-to-many tables

A key modelling consideration was that one order can contain multiple items and multiple payment records. Payment values therefore need to be aggregated to order level before being joined to item-level data.

## Approach by tool

### Excel: rapid investigation

I used Excel to:

- Convert the extract into a structured table
- Check data types and missing values
- Build a monthly paid-value PivotTable
- Build a state-level delivery-performance PivotTable
- Compare delivered orders, late deliveries, late rate, average delivery days, and average review score
- Highlight high late-rate states with conditional formatting

Excel was appropriate for quickly exploring a moderate-sized extract and validating the first findings.

### SQL: repeatable analysis

I used SQLite-compatible SQL to:

- Inspect and validate the imported tables
- Count orders by status
- Calculate paid order value and monthly trends
- Calculate late-delivery rate by state
- Apply a minimum-volume rule of at least 100 delivered orders
- Compare review scores for late and on-time deliveries
- Check duplicates and missing values
- Join customers, products, categories, sellers, items, and payments safely

SQL made the analysis repeatable and reduced the risk of manually copying results between worksheets.

### Power BI: operational dashboard

I built a four-page dashboard:

1. **Executive Summary** — overall commercial, delivery, and customer KPIs
2. **Delivery Performance** — state-level late rate, late-order volume, delivery time, and review performance
3. **Customer Experience** — review scores for late versus on-time orders and review performance by state
4. **Data Quality** — completeness, uniqueness, missing values, and reporting-readiness checks

## Key KPIs

| KPI | Result |
|---|---:|
| Total orders | 10,000 |
| Paid order value | Approximately R$1.60 million |
| Delivered orders | 9,662 |
| Late delivered orders | 1,194 |
| Overall late-delivery rate | 12.4% |
| Average delivery time | 14.4 days |
| Average review score | 3.96 / 5 |
| Delivered-order share | 96.6% |

## Key findings

### 1. RJ has the largest late-delivery impact

RJ recorded **332 late delivered orders**, the highest absolute late-order volume in the analysis. Because the measure reflects the number of affected orders rather than only a percentage, RJ may have the greatest impact on the company’s overall on-time delivery KPI.

### 2. CE has the highest late rate among meaningful-volume states

Among states with at least **100 delivered orders**, CE recorded the highest late-delivery rate at **25.4%**. This makes CE a high-risk segment for operational investigation while avoiding conclusions based only on very small samples.

### 3. MA and PI are high-risk but lower-volume signals

MA and PI showed higher late rates overall—approximately **48.0%** and **44.2%**, respectively—but their delivered-order volumes were much smaller. These results should be treated as warning signals and validated over a longer period or larger sample before major resource decisions are made.

### 4. Delivery time varies materially by state

PA recorded the longest average delivery time among the displayed meaningful-volume states at approximately **26.0 days**. This suggests that fulfilment, transport distance, carrier handoffs, or promised-delivery-date planning may differ across states.

### 5. Late deliveries are associated with lower review scores

The Power BI comparison showed a substantially lower average review score for late orders than for on-time orders. This indicates an association between delivery performance and customer satisfaction during the analysed period.

The result should not be described as proof that late delivery alone caused lower reviews. Product quality, seller service, freight cost, category, and customer expectations may also influence review scores.

### 6. November was the strongest commercial month

Paid order value and order volume peaked in **November 2017**. A period of higher commercial activity may require additional fulfilment capacity, seller coordination, and carrier planning to prevent service levels from deteriorating.

## Recommendation

The first operational priority should be **RJ**, because it contributes the highest number of late deliveries and may have the largest effect on the overall on-time delivery KPI.

At the same time, the business should investigate **CE** as the highest late-rate state among states with a meaningful delivered-order base. MA and PI should remain on a watchlist because their high rates may indicate a process issue, although their smaller volumes make the estimates less stable.

The recommended investigation is:

1. Compare seller dispatch time across RJ, CE, MA, and PI.
2. Review carrier performance and handoff delays.
3. Compare delivery distance and estimated-delivery-date accuracy.
4. Identify sellers with both meaningful order volume and above-average late rates.
5. Check whether specific product categories or freight levels are concentrated in the affected states.
6. Monitor the intervention weekly.

## Measurement plan

The following KPIs should be tracked weekly:

| KPI | Purpose |
|---|---|
| Late-delivery rate | Measures the percentage of delivered orders arriving after the estimate |
| Late delivered orders | Measures the absolute operational volume of late deliveries |
| Average delivery days | Tracks how long customers wait for delivery |
| Average review score | Monitors customer-experience impact |
| Review coverage | Shows how much of the order population has customer feedback |
| Delivered-order volume | Provides the denominator and prevents small-sample misinterpretation |
| Seller dispatch time | Helps separate seller delays from carrier delays |

## Limitations

- The analysis uses a prepared 10,000-order practice subset rather than a live company feed.
- The period covers October–December 2017 and should not be treated as current performance.
- High late rate does not necessarily mean high business impact when the order volume is small.
- Review-score differences show association, not causation.
- State-level analysis alone cannot identify whether the root cause is the seller, carrier, route, product category, or promised-date calculation.
- Payment and item analysis must control for one-to-many joins to avoid overstating value.

## Portfolio summary

> **Olist E-Commerce Operations Analysis** — Analysed a 10,000-order e-commerce dataset to identify delivery-performance issues, customer-experience patterns, and state-level operational risks. Used Excel for exploratory PivotTable analysis, SQL for repeatable KPI queries and multi-table analysis, and Power BI to build an interactive four-page operations dashboard. The project focused on late-delivery rate, late-order volume, delivery time, paid order value, review score, seller performance, and data quality.

## Suggested portfolio project card

**Olist E-Commerce Operations Analysis**  
*Excel · SQL · Power BI*

Built an operations dashboard for a 10,000-order e-commerce dataset. Identified RJ as the largest contributor to late-delivery volume and CE as the highest late-rate state among meaningful-volume segments. Connected delivery reliability to customer reviews and translated the findings into operational recommendations.

## Suggested interview explanation

> I approached the project as an operations analyst rather than just building charts. I first defined the KPIs and checked the grain of the data, then used Excel for fast exploration and SQL for repeatable analysis across related tables. In Power BI, I built an executive summary, delivery-performance page, customer-experience page, and data-quality page. The main finding was that RJ had the highest absolute volume of late deliveries, while CE had the highest late rate among states with at least 100 delivered orders. I recommended investigating seller dispatch and carrier performance while monitoring late rate, late-order volume, delivery time, and review score weekly.
