# Problem 07 — Funnel metric (conversion rate)

## Business question
Compute:
- total_customers
- converted_customers: customers with at least one order in ('paid','shipped')
- conversion_rate = converted_customers / total_customers

## The traps
1) Counting orders instead of customers (1 customer can place many orders).
2) Joining to order_items multiplies rows and inflates counts.
3) Integer division: in some DBs, 1/4 becomes 0 if you don't cast to numeric.

## Files
- `wrong.sql` demonstrates common mistakes (row multiplication + wrong unit).
- `correct.sql` computes conversion safely.
- `verify.sql` shows a per-customer converted flag you can eyeball.
