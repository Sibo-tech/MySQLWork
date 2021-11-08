
select oi.order_id, oi.product_id,p.name, oi.quantity, p.unit_price
from sql_store.order_items oi
right join sql_inventory.products p on oi.product_id = p.product_id;