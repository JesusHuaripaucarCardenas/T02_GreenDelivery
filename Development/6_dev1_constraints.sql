-------------------------------------------------
-- RELACIONES DE DEVELOPER_01 HACIA TABLAS COMPARTIDAS
-------------------------------------------------

-- deliveries → orders
ALTER TABLE deliveries
ADD CONSTRAINT fk_deliveries_orders 
FOREIGN KEY (orders_id) 
REFERENCES DEVELOPER_01.orders(id);

-- delivery_routes → deliveries
ALTER TABLE delivery_routes
ADD CONSTRAINT fk_delroute_deliveries 
FOREIGN KEY (deliveries_id) 
REFERENCES DEVELOPER_01.deliveries(id);

-- delivery_routes → routes
ALTER TABLE delivery_routes
ADD CONSTRAINT fk_delroute_routes 
FOREIGN KEY (routes_id) 
REFERENCES DEVELOPER_01.routes(id);

-- routes_points → routes
ALTER TABLE routes_points
ADD CONSTRAINT fk_rpoints_routes 
FOREIGN KEY (routes_id) 
REFERENCES DEVELOPER_01.routes(id);
