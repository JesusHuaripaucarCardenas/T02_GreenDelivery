
-- Relación users -> role
ALTER TABLE users 
ADD CONSTRAINT fk_users_role 
FOREIGN KEY (role_id) REFERENCES role(id);

-- Relación address -> orders
ALTER TABLE address 
ADD CONSTRAINT fk_address_orders 
FOREIGN KEY (orders_id) REFERENCES orders(id);
