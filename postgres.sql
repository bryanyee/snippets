-- Typecast and left trim
SELECT
    LEFT(users.created_at::text, 10) AS user_created_at
FROM users;


-- String concatenation
SELECT
    CONCAT(users.first_name, ' ', users.last_name) AS full_name
FROM users;


-- Dig into json values
SELECT
    items.config::json->>'description' AS item_description,
    CAST (items.config::json->>'identifier' AS INTEGER) AS item_id
FROM items;


-- Case statement
SELECT
    items.name,
    CASE
        WHEN items.price < 10 THEN 'cheap'
        WHEN items.price < 100 THEN 'average'
        WHEN items.price < 500 THEN 'above average'
        ELSE 'expensive'
    END AS price_tier
FROM items;


-- Join, filter and sort
SELECT
    users.id AS user_id,
    users.first_name,
    members.id AS member_id
FROM users
LEFT JOIN members ON user.id = members.user_id
WHERE members.category = 'premium'
ORDER BY users.created_at DESC;


-- Group by multiple fields
SELECT user_id, category_id, COUNT(*)
FROM favorited_items
GROUP BY user_id, category_id
HAVING COUNT(*) > 1;


-- Count the results of another query
SELECT COUNT(*)
FROM (
  SELECT user_id, category_id, COUNT(*)
  FROM favorited_items
  GROUP BY user_id, category_id
  HAVING COUNT(*) > 1;
) AS RESULTS;


-- Grouping, aggregate functions, and querying data on a single item from a 1-to-many relationship using a correlated subquery
SELECT
    order.id AS order_id,
    order.created_at AS order_date,
    COUNT(line_items) AS line_item_count,
    COUNT(line_items) > 0 AS is_large_purchase,
    MAX(items.price) AS highest_item_price,
    (
        SELECT items.name
        FROM items
        WHERE orders.id = line_items.order id AND line_items.item_id = items.id
        ORDER BY items.price DESC
        LIMIT 1
    ) AS highest_price_item_name,
FROM orders
JOIN line_items ON orders.id = line_items.order_id
JOIN items ON line_items.item_id = items.id
GROUP BY orders.id, -- unique row for every order, with aggregate calculations on line_items and items
HAVING orders.customer_id = 100;


-- Joining a table multiple times
SELECT
    users.id AS user_id,
    COUNT(incomplete_tasks) AS incomplete_task_count,
    COUNT(complete_tasks) AS complete_task_count
FROM users
left JOIN tasks AS incomplete_tasks ON users.id = tasks.user_id AND tasks.state IN ('created', 'started')
left JOIN tasks AS complete_tasks ON users.id = tasks.user_id AND tasks.state = 'complete'
GROUP BY users.id;
