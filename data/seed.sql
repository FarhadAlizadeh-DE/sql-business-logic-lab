-- Seed data for SQL Business Logic Lab

INSERT INTO customers (customer_id, full_name, country, created_at) VALUES
  (1, 'Ava Stone', 'US', '2025-01-02 10:00:00'),
  (2, 'Ben Kaya',  'US', '2025-01-03 11:00:00'),
  (3, 'Cora Lin',  'CA', '2025-01-10 09:30:00'),
  (4, 'Dan Noor',  'UK', '2025-02-01 08:15:00');

INSERT INTO products (product_id, product_name, category, is_active) VALUES
  (101, 'Concrete Book',     'Books', TRUE),
  (102, 'SQL Mug',           'Merch', TRUE),
  (103, 'Steel Ruler',       'Tools', TRUE),
  (104, 'Retired Sticker',   'Merch', FALSE);

INSERT INTO orders (order_id, customer_id, order_ts, status) VALUES
  (1001, 1, '2025-03-01 12:00:00', 'paid'),
  (1002, 1, '2025-03-05 09:00:00', 'shipped'),
  (1003, 2, '2025-03-02 14:30:00', 'paid'),
  (1004, 3, '2025-03-03 16:45:00', 'cancelled');

INSERT INTO order_items (order_item_id, order_id, product_id, qty, unit_price) VALUES
  (1, 1001, 101, 1, 29.99),
  (2, 1001, 102, 2, 12.50),

  (3, 1002, 103, 1, 19.00),
  (4, 1002, 102, 1, 12.50),

  (5, 1003, 101, 1, 29.99),
  (6, 1003, 103, 2, 19.00),

  (7, 1004, 102, 1, 12.50);

-- Tie case for Problem 05: same timestamp, different order_id
INSERT INTO orders (order_id, customer_id, order_ts, status)
VALUES (1005, 1, '2025-03-05 09:00:00', 'refunded');
