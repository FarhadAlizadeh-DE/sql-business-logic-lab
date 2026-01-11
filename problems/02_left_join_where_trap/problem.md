# Problem 02 — LEFT JOIN + WHERE trap (missing zero-order customers)

## Business question
List **all customers** and count how many **paid or shipped** orders each customer has.

Requirement:
- Customers with zero qualifying orders must still appear with `0`.

## The trap
A LEFT JOIN keeps unmatched rows **only if you don't filter them out later**.
Placing a filter on the joined table in the `WHERE` clause can turn your LEFT JOIN into an INNER JOIN by removing NULL-matched rows.
## Why `wrong.sql` is wrong
`LEFT JOIN` produces NULLs for customers without matching orders.
The `WHERE o.status IN (...)` condition removes those NULL rows (NULL is not TRUE),
so zero-order customers disappear and the LEFT JOIN behaves like an INNER JOIN.

## Two correct patterns
1) Put the filter in the JOIN condition:  
   `LEFT JOIN orders o ON ... AND o.status IN (...)`

2) Or use conditional aggregation:  
   `SUM(CASE WHEN o.status IN (...) THEN 1 ELSE 0 END)`

## Files
- `wrong.sql` shows the trap (filter in WHERE removes zero-order customers).
- `correct.sql` keeps all customers (filter in the JOIN condition).
- `verify.sql` cross-checks using conditional aggregation.
