# Problem 01 — Row multiplication in joins (silent revenue inflation)

## Business question
Compute **total revenue per customer** for **paid or shipped** orders.

Revenue definition:
- Revenue is the sum of `qty * unit_price` across all items in qualifying orders.

## The trap
SQL bugs often come from joining at the wrong “grain” (level of detail).
If you accidentally join a customer’s orders twice (or join another table at customer level after item level),
you silently duplicate rows and inflate totals.

## Files
- `wrong.sql` shows a classic inflation bug (orders joined twice).
- `correct.sql` joins once at each grain (customer → orders → items).
- `verify.sql` cross-checks by aggregating at order level first, then rolling up.
## Why `wrong.sql` is wrong (in one sentence)
It joins `orders` twice at the customer level, so each order item row is duplicated once per matching order row, silently inflating revenue.

## What you learn here
- Always know your **grain** (row-level detail) before joining.
- A join that “looks fine” can still multiply rows if the relationship is one-to-many on both sides.
- If totals look too high, check row counts before/after joins.

## Debug trick
Compare row counts after each join.  
If rows increase unexpectedly, you likely introduced a multiplicative join.

