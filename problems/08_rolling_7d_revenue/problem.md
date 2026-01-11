# Problem 08 — Rolling 7-day revenue (time series + window frame)

## Business question
Create a daily revenue series for paid/shipped orders and compute rolling 7-day revenue.

Definitions:
- daily_revenue: sum(qty * unit_price) for orders on that day (paid/shipped only)
- rolling_7d_revenue: sum of daily_revenue for the current day and previous 6 days

## The traps
1) Window frame confusion:
   - `ROWS BETWEEN 6 PRECEDING AND CURRENT ROW` is based on row count (days present),
     not calendar days. Missing days can distort the meaning.
2) Forgetting to generate missing dates:
   - If a day has no orders, it should still appear with revenue = 0 for clean time series.
3) Joining at wrong grain can inflate revenue.

## Files
- `wrong.sql`: rolling window over only existing days (skips missing dates).
- `correct.sql`: generates a full date series and then computes rolling 7-day revenue.
- `verify.sql`: shows the daily series used as input.

## Why `wrong.sql` is misleading
`ROWS BETWEEN 6 PRECEDING AND CURRENT ROW` operates on row count, not calendar time.
If some days have no data, the rolling window silently stretches over a longer period.

## Correct approach
Generate a complete date series, fill missing days with zero revenue,
and then apply the rolling window so "7 days" truly means 7 days.
