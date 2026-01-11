-- WRONG / FRAGILE: MAX + join-back.
-- Problems:
-- 1) Ties can return multiple winners per category.
-- 2) Easy to join at the wrong level and accidentally duplicate revenue.

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
),
max_rev AS (
  SELECT
    category,
    MAX(revenue) AS max_revenue
  FROM product_revenue
  GROUP BY category
)
SELECT
  pr.category,
  pr.product_id,
  pr.product_name,
  pr.revenue
FROM product_revenue pr
JOIN max_rev mr
  ON mr.category = pr.category
 AND mr.max_revenue = pr.revenue
ORDER BY pr.category, pr.product_id;
