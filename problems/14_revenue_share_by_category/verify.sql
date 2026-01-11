-- VERIFY: Category revenue per customer (paid/shipped only)

SELECT
  c.customer_id,
  c.full_name,
  p.category,
  SUM(oi.qty * oi.unit_price) AS category_revenue
FROM customers c
JOIN orders o
  ON o.customer_id = c.customer_id
JOIN order_items oi
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
WHERE o.status IN ('paid','shipped')
GROUP BY c.customer_id, c.full_name, p.category
ORDER BY c.customer_id, p.category;
