-- Olist E-Commerce Operations Analysis
-- SQLite-compatible queries for the prepared fact_orders table.
-- Expected columns include: order_id, order_status, customer_state,
-- delivered_order, is_late, delivery_days, review_score,
-- payment_value, and order_purchase_timestamp.

-- 1. Overall order-status distribution
SELECT order_status, COUNT(*) AS total_orders
FROM fact_orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- 2. Executive KPI summary
SELECT
  COUNT(DISTINCT order_id) AS total_orders,
  SUM(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END) AS delivered_orders,
  SUM(CASE WHEN order_status = 'delivered' AND is_late = 1 THEN 1 ELSE 0 END) AS late_delivered_orders,
  ROUND(100.0 * SUM(CASE WHEN order_status = 'delivered' AND is_late = 1 THEN 1 ELSE 0 END)
    / NULLIF(SUM(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END), 0), 1) AS late_rate_pct,
  ROUND(AVG(CASE WHEN order_status = 'delivered' THEN delivery_days END), 1) AS avg_delivery_days,
  ROUND(AVG(CASE WHEN order_status = 'delivered' THEN review_score END), 2) AS avg_review_score
FROM fact_orders;

-- 3. Monthly paid-value trend
SELECT
  strftime('%Y-%m', order_purchase_timestamp) AS purchase_month,
  ROUND(SUM(payment_value), 2) AS paid_order_value,
  COUNT(DISTINCT order_id) AS orders
FROM fact_orders
GROUP BY purchase_month
ORDER BY purchase_month;

-- 4. State-level delivery performance
SELECT
  customer_state,
  COUNT(DISTINCT CASE WHEN order_status = 'delivered' THEN order_id END) AS delivered_orders,
  SUM(CASE WHEN order_status = 'delivered' AND is_late = 1 THEN 1 ELSE 0 END) AS late_delivered_orders,
  ROUND(100.0 * SUM(CASE WHEN order_status = 'delivered' AND is_late = 1 THEN 1 ELSE 0 END)
    / NULLIF(COUNT(DISTINCT CASE WHEN order_status = 'delivered' THEN order_id END), 0), 1) AS late_rate_pct,
  ROUND(AVG(CASE WHEN order_status = 'delivered' THEN delivery_days END), 1) AS avg_delivery_days,
  ROUND(AVG(CASE WHEN order_status = 'delivered' THEN review_score END), 2) AS avg_review_score
FROM fact_orders
GROUP BY customer_state
ORDER BY late_rate_pct DESC;

-- 5. Fair state comparison: minimum 100 delivered orders
SELECT
  customer_state,
  COUNT(DISTINCT order_id) AS delivered_orders,
  SUM(CASE WHEN is_late = 1 THEN 1 ELSE 0 END) AS late_delivered_orders,
  ROUND(100.0 * SUM(CASE WHEN is_late = 1 THEN 1 ELSE 0 END)
    / NULLIF(COUNT(DISTINCT order_id), 0), 1) AS late_rate_pct
FROM fact_orders
WHERE order_status = 'delivered'
GROUP BY customer_state
HAVING COUNT(DISTINCT order_id) >= 100
ORDER BY late_rate_pct DESC;

-- 6. Late versus on-time customer experience
SELECT
  CASE WHEN is_late = 1 THEN 'Late' ELSE 'On-time' END AS delivery_label,
  COUNT(*) AS delivered_orders,
  COUNT(review_score) AS reviewed_orders,
  ROUND(100.0 * COUNT(review_score) / NULLIF(COUNT(*), 0), 1) AS review_coverage_pct,
  ROUND(AVG(review_score), 2) AS avg_review_score
FROM fact_orders
WHERE order_status = 'delivered'
GROUP BY delivery_label
ORDER BY delivery_label;

-- 7. Data-quality checks
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT order_id) AS unique_orders,
  COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_rows,
  SUM(CASE WHEN review_score IS NULL THEN 1 ELSE 0 END) AS missing_review_scores,
  SUM(CASE WHEN order_status = 'delivered' AND delivery_days IS NULL THEN 1 ELSE 0 END) AS missing_delivery_days,
  SUM(CASE WHEN order_status = 'delivered' AND is_late IS NULL THEN 1 ELSE 0 END) AS missing_late_flags
FROM fact_orders;
