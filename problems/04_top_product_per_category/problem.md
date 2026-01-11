# Problem 04 — Top 1 per group (top product per category)

## Business question
For each product category, find the **top product by revenue** (sum of qty * unit_price),
considering **paid/shipped** orders only.

Tie-break:
1) higher revenue wins
2) if tied, lower product_id wins

## The trap
A common but fragile pattern is:
- compute MAX(revenue) per category
- join back to products

This can return multiple rows on ties and is easy to get wrong.
Window functions (ROW_NUMBER) express the intent cleanly.

## Files
- `wrong.sql` shows a fragile pattern (MAX + join back).
- `correct.sql` uses a window function and explicit tie-break.
- `verify.sql` returns full ranked lists to sanity-check.
