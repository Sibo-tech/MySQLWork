-- Outer Join Between Multiple Tables 
use sql_store;
Select o.order_id, o.order_date, c.first_name AS customer, sh.name as shipper, os.name as status
from orders o
join customers c on o.customer_id = c.customer_id
left join shippers sh on o.shipper_id = sh.shipper_id
join order_statuses os on o.status = os.order_status_id;

-- self outer join
use sql_hr;
select e.employee_id, e.first_name, m.first_name as manager
from employees e
left join employees m on e.reports_to = m.employee_id;

-- the using clause
use sql_store;
Select o.order_id, c.first_name, sh.name as shipper
from orders o
join customers c using (customer_id)
left join shippers sh using (shipper_id);

use sql_invoicing;
select p.date, c.name as client, p.amount, pm.name as payment_method
from payments p
join clients c using (client_id)
join payment_methods pm on p.payment_method = pm.payment_method_id;

-- natural join
use sql_store;
select o.order_id, c.first_name
from orders o
natural join customers c;

-- cross join
select c.first_name as customer, p.name as product
from customers c
cross join products p #explicit syntax 
order by c.first_name;

select sh.name as shipper,p.name as product
from shippers sh, products p #implicit syntax
order by sh.name;









