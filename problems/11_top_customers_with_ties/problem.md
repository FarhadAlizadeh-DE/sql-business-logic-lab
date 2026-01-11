# Problem 11 — Top N customers by revenue (tie-aware)

## Business question
Return the **top 2 customers** by total revenue (paid/shipped orders only).
If multiple customers tie for 2nd place, include all ties.

## The traps
1) `ORDER BY revenue DESC LIMIT 2` drops ties.
2) `ROW_NUMBER()` assigns unique ranks and also drops ties.
3) Correct approach is usually `DENSE_RANK()` (or `RANK()` depending on requirements).

## Files
- `wrong.sql`: LIMIT drops ties.
- `correct.sql`: DENSE_RANK keeps ties.
- `verify.sql`: shows full ranking for sanity.

## Why `wrong.sql` is wrong
`LIMIT 2` returns an arbitrary 2 rows after sorting and will drop customers tied for 2nd place.

## Why `DENSE_RANK()` is correct here
`DENSE_RANK()` assigns the same rank to ties, so filtering `rnk <= 2` keeps all customers
who belong in the top 2 including ties.
