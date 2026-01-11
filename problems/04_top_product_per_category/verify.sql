-- VERIFY: Show the full ranked list so you can eyeball winners and ties.

WITH product_revenue AS (
  SELECT
    p.category,
    p.product_id,
    p.product_name,
    SUM(oi.qty * oi.unit_price) AS revenue
  FROM products p
  JOIN order_items oi
    ON oi.product_id = p.product_id
  JOIN orders o
    ON o.order_id = oi.order_id
  WHERE o.status IN ('paid', 'shipped')
  GROUP BY p.category, p.product_id, p.product_name
)
SELECT
  category,
  product_id,
  product_name,
  revenue,
  ROW_NUMBER() OVER (PARTITION BY category ORDER BY revenue DESC, product_id ASC) AS rn
FROM product_revenue
ORDER BY category, rn, product_id;
