# Problem 05 — Latest row per entity (latest order per customer)

## Business question
For each customer, return their **latest order**:
- order_id, order_ts, status

Tie-break:
- if multiple orders share the same `order_ts`, pick the **highest order_id**.

## The trap
A common approach is:
- SELECT customer_id, MAX(order_ts)
- join back to orders on timestamp

This breaks on ties (returns multiple rows) unless you add a deterministic tie-break.
Window functions (ROW_NUMBER) express this cleanly.

## Files
- `wrong.sql` shows the MAX + join-back tie problem.
- `correct.sql` uses ROW_NUMBER with a tie-break.
- `verify.sql` shows ranked orders per customer.
