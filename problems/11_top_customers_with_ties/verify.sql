-- VERIFY: Full ranking to confirm ties.

WITH revenue AS (
  SELECT
    c.customer_id,
    c.full_name,
    COALESCE(SUM(oi.qty * oi.unit_price), 0) AS revenue
  FROM customers c
  LEFT JOIN orders o
    ON o.customer_id = c.customer_id
   AND o.status IN ('paid', 'shipped')
  LEFT JOIN order_items oi
    ON oi.order_id = o.order_id
  GROUP BY c.customer_id, c.full_name
)
SELECT
  customer_id,
  full_name,
  revenue,
  RANK() OVER (ORDER BY revenue DESC) AS rank_gap,
  DENSE_RANK() OVER (ORDER BY revenue DESC) AS dense_rank
FROM revenue
ORDER BY revenue DESC, customer_id;
