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

## Why `NOT IN` can fail
If the subquery returns a NULL, then `x NOT IN (...)` becomes UNKNOWN for every x,
so the WHERE clause filters out everything.

## Rule of thumb
Use `NOT EXISTS` (or a LEFT JOIN anti-join) for "never had" questions.
