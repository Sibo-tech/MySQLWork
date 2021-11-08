-- unions
select customer_id, first_name, points, 'Bronze' As type
from customers
where points < 2000
union
select customer_id, first_name, points, 'Silver' As type
from customers
where points between 2000 and 3000
union
select customer_id, first_name, points, 'Gold' As type
from customers
where points > 3000
order by first_name;

-- inserting a row into a table
insert into customers (first_name, last_name, birth_date, address, city, state)
values ('Sibongile', 'Maseko', '1994-05-08', 'Khayelitsha', 'Cape Town', 'WC');

-- inserting multiple rows into a table
insert into shippers(name)
values ('Shipper1'), ('Shipper2'), ('Shipper3');

insert into products(name, quantity_in_stock, unit_price)
values ('item1', '10','1.5'),('item2', '20','0.5'),('item3', '30','1.00');

-- inserting hierarchical rows(inserting rows into multiple tables)
insert into orders (customer_id, order_date, status)
values (1, '2019-01-02', 1);

insert into order_items
values ( last_insert_id(), 1, 1, 2.95), ( last_insert_id(), 2, 1, 3.95);
