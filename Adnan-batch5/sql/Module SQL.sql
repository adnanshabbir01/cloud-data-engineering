-- Percentage
select top 1 percent * from production.products

-- Offset and Fetch
-- Offsets skips and Fetch next fetches the desired next rows
-- Does not work without Order by
-- Fetch next does not work with Offset
select * from production.products order by list_price asc
offset 10 rows 
fetch next 10 rows only;

select distinct city, state 
from sales.customers

select distinct state, city
from sales.customers

select distinct phone from sales.customers
select * from production.products where category_id = 1 and list_price >= 400
select * from production.products where model_year = 2018 and list_price > 300


select * from production.products where brand_id in (1,2) and list_price > 1000
select * from production.products where (brand_id = 1 or brand_id = 2) and list_price > 300

select * from production.products where list_price in (2999.9, 2599.9, 1199.99, 2799.99)
select * from production.products where list_price between 1199.99 and 2999.9

select * from sales.orders where order_date between '2016-01-01' and '2018-01-01'

--	Combining 2 columns and aliasing
select first_name + ' ' + last_name as full_name
from sales.customers

-- Logical operators are used with wildcards
select * from sales.customers where first_name like 's%t'
and first_name like 's%'            

-- To skip the first letter 
select * from sales.customers where first_name like '_a%';

 create schema hr;
 go

 create table hr.candidates (
 id int primary key identity,
 fullname varchar(100) not null);

 create table hr.employees (
 id int primary key identity,
 fullname  varchar(100) not null);



 INSERT INTO hr.candidates (fullname)
VALUES 
('Ali Khan'),
('Sara Ahmed'),
('John Smith'),
('Ayesha Malik');


INSERT INTO hr.employees (fullname)
VALUES 
('Ali Khan'),
('Emily Johnson'),
('Hassan Raza'),
('Sara Ahmed');

select a.fullname
from hr.employees a 
inner join hr.candidates b
on a.fullname = b.fullname

select distinct a.category_id, b.category_name
from production.products a
inner join production.categories b
on a.category_id = b.category_id
--order by product_name desc;

select first_name + ' ' + last_name as full_name, order_status, order_date
from sales.orders a 
left join sales.customers b
on a.customer_id = b.customer_id


select p.product_name, o.order_id
from production.products P
inner join sales.order_items o
on p.product_id = o.product_id;

select
a.product_name,
b.order_id,
c.order_date,
b.item_id
from production.products a
left join sales.order_items b
on a.product_id = b.product_id
left join sales.orders c
on b.order_id = c.order_id;


select 
a.product_name,
b.order_id
from production.products a
right join sales.order_items b
on a.product_id = b.product_id;

select 
a.product_name,
b.order_id
from sales.order_items b
right join  production.products a
on a.product_id = b.product_id;

select a.store_id, b.store_name, a.quantity, a.product_id, c.product_name
from production.stocks a
left join sales.stores b
on a.store_id = b.store_id
left join production.products c
on a.product_id = c.product_id;

select * from production.products
cross join sales.order_items;

-- Self Join
select a.staff_id from 
sales.staffs a 
join sales.staffs b
on a.staff_id = b.staff_id;

select a.first_name, a.manager_id, b.first_name, b.staff_id
from sales.staffs a
left join sales.staffs b
on a.manager_id = b.staff_id

-- FULL JOIN AND FULL OUTER JOIN IS SAME
-- CROSS JOIN MAKES CARDINALITY 

select a.customer_id, a.first_name, b.customer_id, b.first_name
from sales.customers a
left join sales.customers b
on a.city = b.city
where (
a.customer_id != b.customer_id)
and a.first_name = 'Albany'
order by a.city;


-- Aggregations

select customer_id, year(order_date) as order_year, count(order_id) as order_count
from sales.orders 
where customer_id in (2,11,25)
group by customer_id, year(order_date);


select city, count(customer_id) as cust_count
from sales.customers
group by city;

select category_id, max(list_price) as max_price, min(list_price) as min_price
from production.products
group by category_id;

select order_id, sum(quantity * list_price * (1-discount)) as net_amount
from sales.order_items  
group by order_id
having sum(quantity * list_price * (1-discount)) > 5000;

select customer_id, year(order_date) as order_year, count(order_id) as order_count
from sales.orders 
--where customer_id in (2,11,25)
group by customer_id, year(order_date)
having count(order_id) > 1;

-- order_count will be executed in the end so having does not know the alias value order_count 
-- that is why we use count(order_id) in having
-- different clauses can be used in select and having

select category_id, avg(list_price) as avg_price
from production.products
group by category_id
having avg(list_price) between 500 and 1000;


select * from sales.orders 
where customer_id in (
select customer_id 
from sales.customers where city = 'New York');

-- we can write max 32 subqueries in a query
select product_name, list_price
from production.products
where list_price > (
select avg(list_price)
from production.products where brand_id in (select brand_id from production.brands where brand_name in ('Electra','Trek')));
-- we should always select only one column in sub query

select product_name 
from production.products
where category_id in 
(select category_id from production.categories
where category_name in ('Comfort Bicycles','Electric Bikes'));


select * from production.products 
where product_id in 
(select product_id
from production.stocks where quantity > 25);