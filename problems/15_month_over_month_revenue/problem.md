# Problem 15 — Month-over-month revenue change

## Business question
Compute monthly revenue (paid/shipped orders only) and calculate
month-over-month (MoM) percentage change.

Output:
- month
- monthly_revenue
- previous_month_revenue
- mom_change_pct

## The traps
1) Forgetting to truncate dates to month.
2) Using LAG without ordering.
3) Division by zero / NULL in first month.
4) Mixing item-level and order-level grain.

## Files
- `wrong.sql`: missing ordering and unsafe division.
- `correct.sql`: clean monthly aggregation + LAG + safe percent change.
- `verify.sql`: monthly revenue only (input to MoM).
