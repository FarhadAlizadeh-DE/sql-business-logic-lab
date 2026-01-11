-- WRONG: Mixing grains + counting orders (not customers) + row multiplication risk.
-- This will over-count if customers have multiple qualifying orders or multiple items.

SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN o.status IN ('paid','shipped') THEN 1 ELSE 0 END) AS qualifying_rows,
  -- This "rate" is meaningless because the numerator/denominator aren't customers.
  ROUND(
    SUM(CASE WHEN o.status IN ('paid','shipped') THEN 1 ELSE 0 END)::numeric
    / NULLIF(COUNT(*), 0),
    4
  ) AS bogus_rate
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.customer_id
LEFT JOIN order_items oi
  ON oi.order_id = o.order_id;
