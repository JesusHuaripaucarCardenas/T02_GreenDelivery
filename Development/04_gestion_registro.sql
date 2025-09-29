-- TABLA DE ROLE
INSERT INTO role (name, description)
VALUES ('Administrador', 'Usuario con permisos completos del sistema');
commit;

INSERT INTO role (name, description)
VALUES ('Cliente', 'Usuario que realiza pedidos');
commit;

INSERT INTO role (name, description, status)
VALUES ('Conductor', 'Usuario encargado de las entregas', 'A');
commit;

UPDATE role
SET description = 'Usuario que gestiona y administra el sistema completo'
WHERE name = 'Administrador';
commit;

-- TABLA DE USERS
INSERT INTO users (email, password, role_id, name, last_name, birthdate, phone, sex, document_type, document_number)
VALUES ('admin@delivery.com', '$2a$10$hash1', 1, 'Carlos', 'Rodriguez', DATE '1985-03-15', '987654321', 'masculino', 'DNI', '12345678');
commit;

INSERT INTO users (email, password, role_id, name, last_name, birthdate, phone, sex, document_type, document_number, alternative_phone, company_name)
VALUES ('cliente1@email.com', '$2a$10$hash2', 2, 'Maria', 'Gonzalez', DATE '1990-07-22', '976543210', 'femenino', 'DNI', '87654321', '965432109', 'Empresa ABC');
commit;

INSERT INTO users (email, password, role_id, name, last_name, birthdate, phone, sex, document_type, document_number, license, hire_date)
VALUES ('conductor1@delivery.com', '$2a$10$hash3', 3, 'Juan', 'Perez', DATE '1988-12-10', '954321098', 'masculino', 'DNI', '11223344', 'LIC123456', DATE '2024-01-15');
commit;

UPDATE users
SET phone = '987654322', alternative_phone = '965432108'
WHERE email = 'cliente1@email.com';
commit;

-- TABLA DE ORDERS
INSERT INTO orders (users_id, order_code, requested_delivery_date, priority, subtotal, shipping_cost, total)
VALUES (2, 'ORD-2025-001', DATE '2025-08-18', 'N', 150.50, 15.00, 165.50);
commit;

INSERT INTO orders (users_id, order_code, requested_delivery_date, priority, subtotal, shipping_cost, total, status)
VALUES (2, 'ORD-2025-002', DATE '2025-08-19', 'A', 89.75, 12.50, 102.25, 'C');
commit;

INSERT INTO orders (users_id, order_code, requested_delivery_date, priority, subtotal, shipping_cost, total, status)
VALUES (2, 'ORD-2025-003', DATE '2025-08-20', 'U', 245.00, 25.00, 270.00, 'P');
commit;

UPDATE orders
SET status = 'C', subtotal = 155.75, total = 170.75
WHERE order_code = 'ORD-2025-001';
commit;

-- TABLA DE ORDER_DETAILS
INSERT INTO order_details (orders_id, quantity, unit_price)
VALUES (1, 2, 75.25);
commit;

INSERT INTO order_details (orders_id, quantity, unit_price)
VALUES (2, 1, 89.75);
commit;

INSERT INTO order_details (orders_id, quantity, unit_price)
VALUES (3, 3, 81.67);
commit;

UPDATE order_details
SET quantity = 3, unit_price = 51.92
WHERE orders_id = 1;
commit;

-- TABLA DE PRODUCT
INSERT INTO product (orders_id, code, name, description, unit_weight, fragile, cooled, reference_price)
VALUES (1, 'PROD-001', 'Smartphone Samsung', 'Teléfono inteligente última generación', 0.18, 'S', 'N', 150.50);
commit;

INSERT INTO product (orders_id, code, name, description, unit_weight, fragile, cooled, reference_price)
VALUES (2, 'PROD-002', 'Laptop HP Pavilion', 'Laptop para uso profesional', 2.10, 'S', 'N', 89.75);
commit;

INSERT INTO product (orders_id, code, name, description, unit_weight, reference_price, status)
VALUES (3, 'PROD-003', 'Medicamentos', 'Productos farmacéuticos refrigerados', 0.50, 245.00, 'A');
commit;

UPDATE product
SET cooled = 'S', description = 'Productos farmacéuticos que requieren refrigeración'
WHERE code = 'PROD-003';
commit;

-- TABLA DE ADDRESS
INSERT INTO address (street, "number", district, postal_code, reference, latitude, length, orders_id)
VALUES ('Av. Los Libertadores', '123', 'San Isidro', 15036, 'Frente al parque central', -12.09750000, -77.03640000, 1);
commit;

INSERT INTO address (street, "number", district, postal_code, reference, latitude, length, orders_id)
VALUES ('Jr. Las Flores', '456', 'Miraflores', 15074, 'Edificio azul, tercer piso', -12.11670000, -77.02970000, 2);
commit;

INSERT INTO address (street, "number", district, reference, orders_id)
VALUES ('Calle Los Pinos', '789', 'Surco', 'Casa esquina con portón verde', 3);
commit;

UPDATE address
SET reference = 'Frente al parque central, casa blanca con rejas negras', postal_code = 15037
WHERE orders_id = 1;
commit;

-- TABLA DE USER_ADDRESSES
INSERT INTO user_addresses (users_id, address_id, alias, is_main)
VALUES (2, 1, 'Casa Principal', 'S');
commit;

INSERT INTO user_addresses (users_id, address_id, alias, is_main, status)
VALUES (2, 2, 'Oficina', 'N', 'A');
commit;

INSERT INTO user_addresses (users_id, address_id, alias)
VALUES (2, 3, 'Casa Secundaria');
commit;

UPDATE user_addresses
SET alias = 'Oficina Central', is_main = 'N'
WHERE users_id = 2 AND address_id = 2;
commit;

-- TABLA DE STATUS_TRACKING
INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (1, NULL, 'R', 'Pedido recibido correctamente', 'admin@delivery.com');
commit;

INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (2, 'R', 'C', 'Pedido confirmado y en preparación', 'admin@delivery.com');
commit;

INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
VALUES (3, 'C', 'P', 'Preparando productos para envío', 'operador1');
commit;

UPDATE status_tracking
SET "comment" = 'Pedido recibido y validado correctamente por el sistema', "user" = 'sistema_automatico'
WHERE orders_id = 1 AND new_status = 'R';
commit;

-- TABLA DE DELIVERIES
INSERT INTO deliveries (orders_id, departure_time, delivery_cost, distance_traveled)
VALUES (1, TIMESTAMP '2025-08-17 09:00:00', 15.00, 12.50);
commit;

INSERT INTO deliveries (orders_id, delivery_cost, distance_traveled, status)
VALUES (2, 12.50, 8.30, 'A');
commit;

INSERT INTO deliveries (orders_id, departure_time, delivery_time, delivery_cost, distance_traveled, status)
VALUES (3, TIMESTAMP '2025-08-17 14:00:00', TIMESTAMP '2025-08-17 15:30:00', 25.00, 18.70, 'E');
commit;

UPDATE deliveries
SET delivery_time = TIMESTAMP '2025-08-17 10:45:00', status = 'E', distance_traveled = 13.20
WHERE orders_id = 1;
commit;

-- TABLA DE VEHICLE
INSERT INTO vehicle (plate, vehicle_type, brand, model, year, load_capacity, last_revision_date, next_review, maturity_insurance, observation)
VALUES ('ABC-123', 'Motocicleta', 'Honda', 'CB150', 2023, 50.00, DATE '2025-06-15', DATE '2025-12-15', DATE '2025-12-31', 'Vehículo en excelente estado');
commit;

INSERT INTO vehicle (plate, vehicle_type, brand, model, year, load_capacity, status)
VALUES ('DEF-456', 'Furgoneta', 'Toyota', 'Hiace', 2022, 1000.00, 'A');
commit;

INSERT INTO vehicle (plate, vehicle_type, brand, model, load_capacity, last_revision_date, observation, status)
VALUES ('GHI-789', 'Camión', 'Isuzu', 'NPR', 2500.00, DATE '2025-07-01', 'Requiere mantenimiento preventivo', 'M');
commit;

UPDATE vehicle
SET status = 'A', observation = 'Mantenimiento completado, vehículo operativo', next_review = DATE '2026-01-01'
WHERE plate = 'GHI-789';
commit;

-- TABLA DE VEHICLE_DRIVER
INSERT INTO vehicle_driver (driver_id, vehicle_id, assignment_date, is_main, observation)
VALUES (3, 1, DATE '2025-01-20', 'S', 'Asignación principal del conductor');
commit;

INSERT INTO vehicle_driver (driver_id, vehicle_id, assignment_date, is_main, status)
VALUES (3, 2, DATE '2025-02-01', 'N', 'A');
commit;

INSERT INTO vehicle_driver (driver_id, vehicle_id, assignment_date, deallocation_date, observation)
VALUES (3, 3, DATE '2025-01-15', DATE '2025-07-01', 'Vehículo enviado a mantenimiento');
commit;

UPDATE vehicle_driver
SET deallocation_date = NULL, status = 'A', observation = 'Reasignado después de mantenimiento'
WHERE driver_id = 3 AND vehicle_id = 3;
commit;

-- TABLA DE ROUTES
INSERT INTO routes (name, description, main_district, distance_km, estimated_time_minutes, difficulty)
VALUES ('Ruta Centro Lima', 'Ruta principal por el centro histórico de Lima', 'Lima', 15.50, 45, 'medio');
commit;

INSERT INTO routes (name, description, main_district, distance_km, estimated_time_minutes, difficulty, status)
VALUES ('Ruta Miraflores-San Isidro', 'Conexión rápida entre distritos residenciales', 'Miraflores', 8.20, 25, 'facil', 'A');
commit;

INSERT INTO routes (name, description, main_district, distance_km, estimated_time_minutes, difficulty)
VALUES ('Ruta Industrial Callao', 'Ruta hacia zona industrial del Callao', 'Callao', 22.80, 65, 'dificil');
commit;

UPDATE routes
SET estimated_time_minutes = 50, description = 'Ruta principal por el centro histórico, incluye tráfico pesado'
WHERE name = 'Ruta Centro Lima';
commit;

-- TABLA DE ROUTES_POINTS
INSERT INTO routes_points (routes_id, "order", name, description, latitude, length, point_type, estimated_time_minutes, distance_meters)
VALUES (1, 1, 'Plaza de Armas', 'Punto de partida centro histórico', -12.04640000, -77.04280000, 'inicio', 0, 0);
commit;

INSERT INTO routes_points (routes_id, "order", name, description, latitude, length, point_type, estimated_time_minutes, distance_meters, observation)
VALUES (1, 2, 'Jr. de la Unión', 'Calle peatonal comercial', -12.04580000, -77.03010000, 'intermedio', 15, 1200, 'Zona de alta congestión peatonal');
commit;

INSERT INTO routes_points (routes_id, "order", name, point_type, estimated_time_minutes, distance_meters)
VALUES (1, 3, 'Estación Central', 'destino', 30, 2500);
commit;

UPDATE routes_points
SET description = 'Calle peatonal comercial - evitar horas pico', estimated_time_minutes = 20
WHERE routes_id = 1 AND "order" = 2;
commit;

-- TABLA DE ROUTE_SEGMENTS
INSERT INTO route_segments (routes_id, origin_point, destination_point, order_segment, instruction, address, street_name, distance_meters, estimated_time_minutes, average_speed, difficulty, via_type, trafficlight)
VALUES (1, 1, 2, 1, 'Dirigirse hacia el este por Jr. de la Unión', 'recto', 'Jr. de la Unión', 1200, 15, 4.8, 'medio', 'jiron', 'S');
commit;

INSERT INTO route_segments (routes_id, origin_point, destination_point, order_segment, instruction, address, street_name, distance_meters, estimated_time_minutes, average_speed, difficulty, via_type, regular_traffic)
VALUES (1, 2, 3, 2, 'Continuar hasta la estación central', 'recto', 'Av. Tacna', 1300, 15, 5.2, 'facil', 'avenida', 'alto');
commit;

INSERT INTO routes_points (routes_id, "order", name, point_type, estimated_time_minutes, distance_meters)
VALUES (2, 1, 'Inicio Miraflores', 'inicio', 0, 0);
commit;

INSERT INTO routes_points (routes_id, "order", name, point_type, estimated_time_minutes, distance_meters)
VALUES (2, 2, 'Destino San Isidro', 'destino', 10, 800);
commit;

INSERT INTO route_segments (routes_id, origin_point, destination_point, order_segment, instruction, address, distance_meters, estimated_time_minutes, difficulty, earring)
VALUES (2, 4, 5, 1, 'Subir por la pendiente hacia San Isidro', 'derecha', 800, 10, 'medio', 'subida');
commit;

UPDATE route_segments
SET regular_traffic = 'medio', estimated_time_minutes = 12, instruction = 'Dirigirse hacia el este por Jr. de la Unión - evitar horas pico'
WHERE routes_id = 1 AND order_segment = 1;
commit;

-- TABLA DE ORIGIN_DESTINATION_ROUTES
INSERT INTO origin_destination_routes (source_address, destination_address, main_path, distance_km, average_time_minutes, times_used, average_rating)
VALUES (1, 2, 1, 15.50, 45, 5, 4.20);
commit;

INSERT INTO origin_destination_routes (source_address, destination_address, main_path, alternative_route, distance_km, average_time_minutes)
VALUES (2, 3, 2, 1, 8.20, 25);
commit;

INSERT INTO origin_destination_routes (source_address, destination_address, main_path, distance_km, average_time_minutes, times_used)
VALUES (1, 3, 3, 22.80, 65, 2);
commit;

UPDATE origin_destination_routes
SET times_used = 8, average_rating = 4.50, average_time_minutes = 42
WHERE source_address = 1 AND destination_address = 2;
commit;

-- TABLA DE DRIVER_FAVORITE_ROUTES
INSERT INTO driver_favorite_routes (driver_id, routes_id, times_used, average_time_minutes, average_rating, personal_notes, first_date_, last_date)
VALUES (3, 1, 5, 43, 4.50, 'Ruta conocida, buen tiempo promedio', DATE '2025-02-01', DATE '2025-08-15');
commit;

INSERT INTO driver_favorite_routes (driver_id, routes_id, times_used, average_time_minutes, average_rating, personal_notes)
VALUES (3, 2, 3, 22, 4.80, 'Ruta rápida y eficiente');
commit;

INSERT INTO driver_favorite_routes (driver_id, routes_id, times_used, average_time_minutes, personal_notes, first_date_)
VALUES (3, 3, 2, 68, 'Ruta larga pero bien pagada', DATE '2025-07-01');
commit;

UPDATE driver_favorite_routes
SET times_used = 8, average_time_minutes = 40, last_date = DATE '2025-08-17'
WHERE driver_id = 3 AND routes_id = 1;
commit;

-- TABLA DE DRIVER_ASSIGNMENTS
INSERT INTO driver_assignments (driver_id, routes_id, assignment_date, start_time, end_time, status, observation)
VALUES (3, 1, DATE '2025-08-17', DATE '2025-08-17', DATE '2025-08-17', 'completada', 'Entrega exitosa en tiempo record');
commit;

INSERT INTO driver_assignments (driver_id, routes_id, assignment_date, status)
VALUES (3, 2, DATE '2025-08-18', 'programada');
commit;

INSERT INTO driver_assignments (driver_id, routes_id, assignment_date, start_time, status, observation)
VALUES (3, 3, DATE '2025-08-19', DATE '2025-08-19', 'en_curso', 'Ruta en progreso');
commit;

UPDATE driver_assignments
SET end_time = DATE '2025-08-18', status = 'completada', observation = 'Ruta completada sin inconvenientes'
WHERE driver_id = 3 AND assignment_date = DATE '2025-08-18';
commit;

-- TABLA DE DELIVERY_ROUTES
INSERT INTO delivery_routes (deliveries_id, routes_id, usage_type, deviations, actual_time_minutes, actual_distance_km, route_rating, remarks)
VALUES (1, 1, 'E', 0, 43, 15.20, 5, 'Ruta ejecutada sin problemas');
commit;

INSERT INTO delivery_routes (deliveries_id, routes_id, usage_type, actual_time_minutes, actual_distance_km, route_rating)
VALUES (2, 2, 'P', 25, 8.10, 4);
commit;

INSERT INTO delivery_routes (deliveries_id, routes_id, usage_type, deviations, actual_time_minutes, actual_distance_km, route_rating, remarks)
VALUES (3, 3, 'E', 1, 67, 23.10, 4, 'Una desviación menor por construcción');
commit;

UPDATE delivery_routes
SET usage_type = 'E', actual_time_minutes = 23, actual_distance_km = 8.00, route_rating = 5
WHERE deliveries_id = 2;
commit;
