-- VERIFY: First purchase day per customer (paid/shipped only)

SELECT
  c.customer_id,
  c.full_name,
  MIN(o.order_ts::date) AS first_purchase_day
FROM customers c
JOIN orders o
  ON o.customer_id = c.customer_id
WHERE o.status IN ('paid','shipped')
GROUP BY c.customer_id, c.full_name
ORDER BY c.customer_id;
