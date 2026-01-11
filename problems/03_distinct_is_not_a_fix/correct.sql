-- CORRECT: Reduce to the correct grain before counting customers.

SELECT
  COUNT(*) AS merch_customers
FROM (
  SELECT
    c.customer_id
  FROM customers c
  JOIN orders o
    ON o.customer_id = c.customer_id
   AND o.status IN ('paid', 'shipped')
  JOIN order_items oi
    ON oi.order_id = o.order_id
  JOIN products p
    ON p.product_id = oi.product_id
   AND p.category = 'Merch'
  GROUP BY c.customer_id
) t;
