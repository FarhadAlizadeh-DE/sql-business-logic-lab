-- VERIFY: EXISTS expresses the intent directly.

SELECT
  COUNT(*) AS merch_customers
FROM customers c
WHERE EXISTS (
  SELECT 1
  FROM orders o
  JOIN order_items oi
    ON oi.order_id = o.order_id
  JOIN products p
    ON p.product_id = oi.product_id
  WHERE o.customer_id = c.customer_id
    AND o.status IN ('paid', 'shipped')
    AND p.category = 'Merch'
);
