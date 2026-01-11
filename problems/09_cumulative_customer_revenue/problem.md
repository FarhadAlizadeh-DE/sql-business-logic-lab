# Problem 09 — Cumulative revenue per customer (running total)

## Business question
For each customer, build a daily revenue time series (paid/shipped orders only) and compute a
cumulative running total over time.

Output:
- customer_id, full_name, day, daily_revenue, cumulative_revenue

## The traps
1) Computing running totals directly over order_items rows (wrong grain) inflates totals.
2) Forgetting to partition the window by customer mixes customers together.
3) Ordering: cumulative totals must be ordered by day (and sometimes ties need ordering rules).

## Files
- `wrong.sql`: wrong grain + missing PARTITION BY.
- `correct.sql`: daily aggregation at customer-day grain, then window SUM partitioned by customer.
- `verify.sql`: show the customer-day series used as input.

## Why `wrong.sql` is wrong
The window function is missing `PARTITION BY customer_id`, so the running total is calculated
across all customers combined (a global running sum), not per customer.

## Rule of thumb
Running totals must be partitioned by the entity (customer_id). Always verify by checking that
the first row for each customer starts at their own daily value.
