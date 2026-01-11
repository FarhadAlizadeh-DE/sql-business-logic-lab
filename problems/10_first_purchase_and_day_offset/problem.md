# Problem 10 — First purchase date + days since first purchase

## Business question
For each customer, show each purchase day (paid/shipped only) with:
- daily revenue
- the customer's first purchase day
- days since first purchase

## The traps
1) Using MIN(order_ts) at the wrong grain (order_items can multiply rows).
2) Forgetting to partition window MIN by customer.
3) Date math: subtracting timestamps vs dates can yield intervals; keep types consistent.

## Files
- `wrong.sql`: wrong grain and missing partitioning.
- `correct.sql`: aggregate to customer-day first, then compute first_purchase_day with window MIN.
- `verify.sql`: shows first purchase day per customer only.

## Why `wrong.sql` is wrong
- It operates at the **order_item** grain (multiple rows per day), so results are not at the required customer-day level.
- It uses `MIN(...) OVER ()` (global) instead of `PARTITION BY customer_id`, so every customer inherits the same first purchase day.

## Rule of thumb
1) Aggregate to the grain you need (customer-day)  
2) Then compute cohort baselines with partitioned window functions.
