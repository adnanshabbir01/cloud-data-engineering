-- ============================================================
--  ASSIGNMENT 02 — Joins
--  Database : BikeStores
-- ============================================================


-- ============================================================
--  Question 1
--  Retrieve the product_name, list_price, and category_name
--  for every product.
--  Use production.products and production.categories.
--  Sort the results by product_name ascending.
-- ============================================================

-- Write your query below:
select p.product_name, p.list_price, c.category_name
from production.products p
left join production.categories c
on p.category_id = c.category_id;

-- ============================================================
--  Question 2
--  Show the customer full name (as full_name), order_id,
--  and order_date for all customers who have placed an order.
--  Use sales.customers and sales.orders.
--  Sort by order_date descending.
-- ============================================================

-- Write your query below:
select c.first_name + ' ' + c.last_name as last_name, o.order_id, o.order_date
from sales.customers c
inner join sales.orders o
on c.customer_id = o.customer_id
order by order_date desc;


-- ============================================================
--  Question 3
--  Retrieve product_name, list_price, category_name, and
--  brand_name for every product.
--  Use production.products, production.categories,
--  and production.brands.
--  Sort by brand_name then product_name (both ascending).
-- ============================================================

-- Write your query below:
select p.product_name, p.list_price, c.category_name, b.brand_name
from production.products p
left join production.categories c
on p.category_id = c.category_id
left join production.brands b
on p.brand_id = b.brand_id
order by b.brand_name asc, p.product_name asc;

-- ============================================================
--  Question 4
--  List all products along with their order_id and item_id.
--  Make sure products that have NEVER been ordered also appear
--  in the result (those rows will have NULL for order_id
--  and item_id).
--  Use production.products and sales.order_items.
--  Sort by order_id ascending.
-- ============================================================

-- Write your query below:
select p.product_name, order_id, o.item_id
from production.products p
left join sales.order_items o
on p.product_id = o.product_id
order by order_id asc;

-- ============================================================
--  Question 5
--  Using your answer from Question 4 as a base, filter the
--  results to show ONLY the products that have never been
--  ordered.
--  Display only product_id and product_name.
-- ============================================================

-- Write your query below:
select p.product_id, p.product_id
from production.products p
left join sales.order_items o
on p.product_id = o.product_id
where order_id is null
order by order_id asc;

-- ============================================================
--  Question 6
--  Show all stores along with any orders placed at each store.
--  Display store_name, store_id (from stores), order_id,
--  and order_date.
--  Every store must appear in the result, even if it has
--  no orders yet.
--  Use sales.orders and sales.stores.
-- ============================================================

-- Write your query below:
select s.store_name, s.store_id, o.order_id, o.order_id
from sales.stores s
left join sales.orders o
on s.store_id = o.store_id;

-- ============================================================
--  Question 7
--  List every staff member alongside their manager's name.
--  Display:
--    • staff full name   (as staff_name)
--    • manager full name (as manager_name)
--  Use only the sales.staffs table.
--  Staff who have no manager should NOT appear in the result.
-- ============================================================

-- Write your query below:
select a.first_name + ' ' + a.last_name as staff_name, b.first_name + ' ' + b.last_name as manager_name
from sales.staffs a
inner join sales.staffs b
on a.manager_id = b.staff_id;

-- ============================================================
--  Question 8
--  Generate every possible combination of store name and
--  brand name.
--  Display store_name and brand_name.
--  Use sales.stores and production.brands.
--  How many total rows do you expect?
--  Write the expected count as a comment next to your query.
-- ============================================================

-- Write your query below:
select a.store_name, b.brand_name
from sales.stores a
cross join production.brands b;

-- ============================================================
--  Question 9
--  Retrieve the customer full name (as full_name), order_id,
--  order_date, product_name, and list_price for every order
--  that has been placed.
--  Use sales.customers, sales.orders, sales.order_items,
--  and production.products.
--  Sort by order_date ascending, then full_name ascending.
-- ============================================================

-- Write your query below:
select c.first_name + ' ' + c.last_name as full_name, o.order_id, o.order_date, p.product_name, p.list_price
from sales.orders o
left join sales.customers c
on o.customer_id = c.customer_id
left join sales.order_items oi
on o.order_id = oi.order_id
left join production.products p
on oi.product_id = p.product_id;
