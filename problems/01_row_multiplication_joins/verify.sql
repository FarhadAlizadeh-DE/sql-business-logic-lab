WITH order_revenue AS (
  SELECT
    o.customer_id,
    o.order_id,
    SUM(oi.qty * oi.unit_price) AS order_rev
  FROM orders o
  JOIN order_items oi
    ON oi.order_id = o.order_id
  WHERE o.status IN ('paid', 'shipped')
  GROUP BY o.customer_id, o.order_id
)
SELECT
  c.customer_id,
  c.full_name,
  COALESCE(SUM(orv.order_rev), 0) AS revenue
FROM customers c
LEFT JOIN order_revenue orv
  ON orv.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY c.customer_id;
