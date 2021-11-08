-- creating a copy of a table
use sql_invoicing;
create table invoices_archived as
select i.invoice_id, i.number, c.name as client, i.invoice_total, 
		i.payment_total, i.invoice_date, i.payment_date, i.due_date
from invoices i
join clients c using (client_id)
where payment_date is not null;

-- updating a single row
use sql_invoicing;
update invoices
set payment_total = (invoice_total *0.5), payment_date = due_date
where client_id = 3;

-- updating multiple rows
use sql_store;
Update customers
set points = points + 50
where birth_date < '1990-01-01';

-- using subqueries in update
use sql_store;
update orders
set comments ='Gold customers'
where customer_id in (select customer_id
					from customers
                    where points > 3000);

-- Deleting rows
Delete from invoices
where client_id = (Select *
					from clients
					where name = 'Myworks');
-- Restoring database
#File> open sql script> open create-databases

