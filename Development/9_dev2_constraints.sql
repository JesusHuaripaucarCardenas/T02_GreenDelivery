-------------------------------------------------
-- RELACIONES ENTRE TABLAS DE DEVELOPER_02
-------------------------------------------------

-- order_details → orders
ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_orders
FOREIGN KEY (orders_id)
REFERENCES orders(id)
ON DELETE CASCADE;

-- product → orders
ALTER TABLE product
ADD CONSTRAINT fk_product_orders
FOREIGN KEY (orders_id)
REFERENCES orders(id)
ON DELETE CASCADE;

-- status_tracking → orders
ALTER TABLE status_tracking
ADD CONSTRAINT fk_status_tracking_orders
FOREIGN KEY (orders_id)
REFERENCES orders(id)
ON DELETE CASCADE;

-------------------------------------------------
-- RELACIONES CON TABLAS COMPARTIDAS DE DEVELOPER_01
-------------------------------------------------

-- deliveries (DEV1) → orders (DEV2)
ALTER TABLE DEVELOPER_01.deliveries
ADD CONSTRAINT fk_deliveries_orders
FOREIGN KEY (orders_id)
REFERENCES orders(id);
