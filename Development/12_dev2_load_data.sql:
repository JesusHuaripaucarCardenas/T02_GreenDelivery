-- ========================
-- Insertar ÓRDENES (10)
-- ========================
INSERT INTO orders (users_id, order_code, priority, subtotal, shipping_cost, total, status)
VALUES (1, 'ORD001', 'N', 100.00, 10.00, 110.00, 'R');
INSERT INTO orders (users_id, order_code, priority, subtotal, shipping_cost, total, status)
VALUES (2, 'ORD002', 'A', 200.00, 15.00, 215.00, 'C');
INSERT INTO orders (users_id, order_code, priority, subtotal, shipping_cost, total, status)
VALUES (3, 'ORD003', 'B', 50.00, 5.00, 55.00, 'P');
INSERT INTO orders (users_id, order_code, priority, subtotal, shipping_cost, total, status)
VALUES (4, 'ORD004', 'U', 500.00, 20.00, 520.00, 'T');
INSERT INTO orders (users_id, order_code, priority, subtotal, shipping_cost, total, status)
VALUES (5, 'ORD005', 'N', 300.00, 25.00, 325.00, 'E');
INSERT INTO orders (users_id, order_code, priority, subtotal, shipping_cost, total, status)
VALUES (6, 'ORD006', 'A', 150.00, 12.00, 162.00, 'X');
INSERT INTO orders (users_id, order_code, priority, subtotal, shipping_cost, total, status)
VALUES (7, 'ORD007', 'B', 80.00, 8.00, 88.00, 'R');
INSERT INTO orders (users_id, order_code, priority, subtotal, shipping_cost, total, status)
VALUES (8, 'ORD008', 'N', 400.00, 30.00, 430.00, 'C');
INSERT INTO orders (users_id, order_code, priority, subtotal, shipping_cost, total, status)
VALUES (9, 'ORD009', 'A', 250.00, 18.00, 268.00, 'P');
INSERT INTO orders (users_id, order_code, priority, subtotal, shipping_cost, total, status)
VALUES (10, 'ORD010', 'U', 600.00, 40.00, 640.00, 'T');

-- ========================
-- Insertar PRODUCTOS (10)
-- ========================
INSERT INTO product (orders_id, code, name, description, unit_weight, fragile, cooled, reference_price, status)
VALUES (1, 'PRD001', 'Laptop', 'Portátil 15 pulgadas', 2.5, 'S', 'N', 1200.00, 'A');
INSERT INTO product (orders_id, code, name, description, unit_weight, fragile, cooled, reference_price, status)
VALUES (1, 'PRD002', 'Mouse', 'Mouse inalámbrico', 0.1, 'N', 'N', 25.00, 'A');
INSERT INTO product (orders_id, code, name, description, unit_weight, fragile, cooled, reference_price, status)
VALUES (2, 'PRD003', 'Teclado', 'Teclado mecánico', 0.8, 'N', 'N', 80.00, 'A');
INSERT INTO product (orders_id, code, name, description, unit_weight, fragile, cooled, reference_price, status)
VALUES (3, 'PRD004', 'Monitor', 'Monitor 24 pulgadas', 4.0, 'S', 'N', 250.00, 'A');
INSERT INTO product (orders_id, code, name, description, unit_weight, fragile, cooled, reference_price, status)
VALUES (4, 'PRD005', 'Impresora', 'Impresora multifuncional', 6.0, 'S', 'N', 400.00, 'I');
INSERT INTO product (orders_id, code, name, description, unit_weight, fragile, cooled, reference_price, status)
VALUES (5, 'PRD006', 'Auriculares', 'Headset gamer', 0.3, 'N', 'N', 120.00, 'A');
INSERT INTO product (orders_id, code, name, description, unit_weight, fragile, cooled, reference_price, status)
VALUES (6, 'PRD007', 'Tablet', 'Tablet 10 pulgadas', 1.0, 'S', 'N', 350.00, 'A');
INSERT INTO product (orders_id, code, name, description, unit_weight, fragile, cooled, reference_price, status)
VALUES (7, 'PRD008', 'Cámara', 'Cámara digital', 0.9, 'S', 'N', 600.00, 'A');
INSERT INTO product (orders_id, code, name, description, unit_weight, fragile, cooled, reference_price, status)
VALUES (8, 'PRD009', 'Smartphone', 'Teléfono Android', 0.5, 'S', 'N', 900.00, 'A');
INSERT INTO product (orders_id, code, name, description, unit_weight, fragile, cooled, reference_price, status)
VALUES (9, 'PRD010', 'Parlante', 'Parlante bluetooth', 1.2, 'N', 'N', 150.00, 'A');

-- ========================
-- Insertar DETALLES DE PEDIDOS (10)
-- ========================
INSERT INTO order_details (orders_id, quantity, unit_price) VALUES (1, 2, 1200.00);
INSERT INTO order_details (orders_id, quantity, unit_price) VALUES (1, 5, 25.00);
INSERT INTO order_details (orders_id, quantity, unit_price) VALUES (2, 1, 80.00);
INSERT INTO order_details (orders_id, quantity, unit_price) VALUES (3, 2, 250.00);
INSERT INTO order_details (orders_id, quantity, unit_price) VALUES (4, 1, 400.00);
INSERT INTO order_details (orders_id, quantity, unit_price) VALUES (5, 3, 120.00);
INSERT INTO order_details (orders_id, quantity, unit_price) VALUES (6, 2, 350.00);
INSERT INTO order_details (orders_id, quantity, unit_price) VALUES (7, 1, 600.00);
INSERT INTO order_details (orders_id, quantity, unit_price) VALUES (8, 1, 900.00);
INSERT INTO order_details (orders_id, quantity, unit_price) VALUES (9, 4, 150.00);

-- ========================
-- Insertar STATUS TRACKING (10)
-- ========================
INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (1, NULL, 'Registrado', 'Pedido inicial', 'system');
INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (1, 'Registrado', 'Confirmado', 'Pago aprobado', 'admin');
INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (2, NULL, 'Registrado', 'Pedido creado', 'system');
INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (2, 'Registrado', 'Cancelado', 'Cliente anuló pedido', 'user01');
INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (3, NULL, 'Registrado', 'Pedido inicial', 'system');
INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (3, 'Registrado', 'Procesado', 'Preparando envío', 'logistics');
INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (4, NULL, 'Registrado', 'Pedido inicial', 'system');
INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (4, 'Registrado', 'En tránsito', 'Paquete enviado', 'courier');
INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (5, NULL, 'Registrado', 'Pedido inicial', 'system');
INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (5, 'Registrado', 'Entregado', 'Cliente recibió producto', 'courier');
