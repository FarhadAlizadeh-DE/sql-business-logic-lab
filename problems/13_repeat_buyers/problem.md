# Problem 13 — Repeat buyers (>= 2 paid/shipped orders)

## Business question
Find customers who have **at least 2** orders with status in ('paid','shipped').

Output:
- customer_id, full_name, qualifying_orders

## The traps
1) Joining to order_items counts items, not orders (inflates order counts).
2) COUNT(*) vs COUNT(DISTINCT order_id) when joins create multiple rows per order.

## Files
- `wrong.sql`: counts rows after joining order_items (inflates).
- `correct.sql`: counts DISTINCT orders at the correct grain.
- `verify.sql`: lists qualifying order_ids per customer.
