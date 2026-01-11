-- WRONG: DISTINCT hides duplication caused by item-level joins.

SELECT
  COUNT(DISTINCT c.customer_id) AS merch_customers
FROM customers c
JOIN orders o
  ON o.customer_id = c.customer_id
JOIN order_items oi
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
WHERE p.category = 'Merch'
  AND o.status IN ('paid', 'shipped');
