
-- INSERTS PARA LA TABLA ROLE
INSERT INTO role (name, description, status)
VALUES ('Administrador', 'Usuario con acceso completo al sistema', 'A');

INSERT INTO role (name, description, status)
VALUES ('Cliente', 'Usuario que realiza pedidos y compras', 'A');

INSERT INTO role (name, description, status)
VALUES ('Conductor', 'Usuario encargado de realizar entregas', 'A');


-- INSERTS PARA LA TABLA USERS
-- Usuario Administrador
INSERT INTO users (email, password, role_id, name, last_name, birthdate, phone, sex, document_type, document_number, alternative_phone, status)
VALUES ('admin@delivery.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye', 1, 'Carlos', 'Mendoza', DATE '1985-03-15', '+51987654321', 'masculino', 'DNI', '45678912', '+51912345678', 'A');

-- Usuario Cliente
INSERT INTO users (email, password, role_id, name, last_name, birthdate, phone, sex, document_type, document_number, company_name, status)
VALUES ('cliente1@gmail.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye', 2, 'María', 'Rodriguez', DATE '1990-07-22', '+51998765432', 'femenino', 'DNI', '78945612', 'Comercial SR', 'A');

-- Usuario Conductor
INSERT INTO users (email, password, role_id, name, last_name, birthdate, phone, sex, document_type, document_number, license, hire_date, average_grade, total_deliveries, status)
VALUES ('conductor1@delivery.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye', 3, 'Pedro', 'Castillo', DATE '1988-11-10', '+51965432178', 'masculino', 'DNI', '56789123', 'Q123456789', DATE '2024-01-15', 4.75, 156, 'A');


-- INSERTS PARA LA TABLA VEHICLE
INSERT INTO vehicle (plate, vehicle_type, brand, model, year, load_capacity, last_revision_date, next_review, maturity_insurance, observation, status)
VALUES ('ABC-123', 'Furgoneta', 'Toyota', 'Hiace', 2020, 1500.00, DATE '2025-08-15', DATE '2026-02-15', DATE '2026-03-20', 'Vehículo en excelente estado', 'A');


INSERT INTO vehicle (plate, vehicle_type, brand, model, year, load_capacity, last_revision_date, next_review, maturity_insurance, observation, status)
VALUES ('DEF-456', 'Motocicleta', 'Honda', 'CBR 250', 2021, 50.00, DATE '2025-06-20', DATE '2025-12-20', DATE '2026-01-10', 'Para entregas rápidas urbanas', 'M');


-- INSERTS PARA LA TABLA ADDRESS
INSERT INTO address (street, "number", district, postal_code, reference, latitude, length, orders_id)
VALUES ('Avenida Javier Prado Este', '4200', 'Santiago de Surco', 15023, 'Frente al centro comercial Jockey Plaza', -12.09167800, -76.97767900, 1);

INSERT INTO address (street, "number", district, postal_code, reference, latitude, length, orders_id)
VALUES ('Calle Las Begonias', '441', 'San Isidro', 15036, 'Edificio de oficinas, piso 5', -12.09345600, -77.03456700, 2);
