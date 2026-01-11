-- WRONG: Uses AVG of item rows (wrong grain) and calls it "median".
-- This is not median, and it's not even average order value.

SELECT
  c.customer_id,
  c.full_name,
  AVG(oi.qty * oi.unit_price) AS not_median
FROM customers c
JOIN orders o
  ON o.customer_id = c.customer_id
JOIN order_items oi
  ON oi.order_id = o.order_id
WHERE o.status IN ('paid','shipped')
GROUP BY c.customer_id, c.full_name
ORDER BY c.customer_id;
