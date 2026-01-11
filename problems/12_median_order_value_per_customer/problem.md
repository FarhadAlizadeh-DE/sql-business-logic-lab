# Problem 12 — Median order value per customer

## Business question
For each customer, compute the **median** order value across their **paid/shipped** orders.

Definitions:
- order_value = sum(qty * unit_price) within an order
- median is the 50th percentile of order_value per customer

## The traps
1) Computing "median" using AVG (median ≠ average).
2) Taking median over order_items rows instead of order totals (wrong grain).
3) Including customers with 0 qualifying orders (decide behavior).

## Files
- `wrong.sql`: wrong grain + wrong statistic.
- `correct.sql`: order totals first, then median per customer using percentile_cont.
- `verify.sql`: lists per-order totals so you can eyeball the median.

## Why `wrong.sql` is wrong
It averages **item-level** values and calls it median. Median must be computed over the correct grain:
one row per order (order totals), not one row per order item.

## Rule of thumb
Define the metric at the correct grain first (order_value per order), then compute statistics (median).
