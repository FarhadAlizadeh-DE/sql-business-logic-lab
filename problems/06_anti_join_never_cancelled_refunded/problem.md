# Problem 06 — Anti-joins (customers who never cancelled/refunded)

## Business question
Return customers who **have never had** an order with status in ('cancelled', 'refunded').

Include customers with no orders.

## The trap
Many people use `NOT IN (subquery)` for anti-joins.
If the subquery can return NULL, `NOT IN` can evaluate to UNKNOWN and return zero rows or incorrect results.

Safer patterns:
- `NOT EXISTS`
- `LEFT JOIN ... WHERE joined_key IS NULL`
