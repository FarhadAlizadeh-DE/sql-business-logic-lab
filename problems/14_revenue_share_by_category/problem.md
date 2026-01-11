# Problem 14 — Revenue share by category per customer

## Business question
For each customer and each product category, compute:
- category_revenue (paid/shipped only)
- customer_total_revenue
- category_revenue_pct = category_revenue / customer_total_revenue

## The traps
1) Integer division / type issues when computing percentages.
2) Wrong grain: totals must be computed from the same filtered dataset.
3) Double aggregation mistakes (summing totals twice).

## Files
- `wrong.sql`: computes total revenue at the wrong grain and can miscompute percentages.
- `correct.sql`: category revenue + window sum for customer totals.
- `verify.sql`: shows raw category revenue per customer (input to the ratio).
