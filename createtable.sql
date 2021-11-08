CREATE VIEW order_product_view AS
select oi.order_id, oi.product_id,p.name, oi.quantity, p.unit_price
from order_items oi
join products p using (product_id);