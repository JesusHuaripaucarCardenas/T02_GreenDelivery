-- ===============================================
-- Inserciones en ROUTES 
-- ===============================================
INSERT INTO dev1.routes VALUES (1, 'Ruta Centro', 'Ruta principal por el centro', 'Centro', 12.5, 35, 'Fácil', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes VALUES (2, 'Ruta Norte', 'Ruta que cubre zona norte', 'Norte', 20.3, 55, 'Media', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes VALUES (3, 'Ruta Sur', 'Ruta hacia zona sur', 'Sur', 15.0, 45, 'Media', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes VALUES (4, 'Ruta Este', 'Ruta hacia zona este', 'Este', 8.2, 25, 'Fácil', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes VALUES (5, 'Ruta Oeste', 'Ruta hacia zona oeste', 'Oeste', 18.9, 50, 'Difícil', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes VALUES (6, 'Ruta Litoral', 'Ruta por el malecón', 'Costa', 22.7, 60, 'Media', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes VALUES (7, 'Ruta Montaña', 'Ruta en zona alta', 'Montaña', 30.0, 90, 'Difícil', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes VALUES (8, 'Ruta Express', 'Ruta rápida por autopista', 'Autopista', 10.0, 20, 'Fácil', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes VALUES (9, 'Ruta Industrial', 'Ruta por zona industrial', 'Industrial', 16.4, 40, 'Media', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes VALUES (10, 'Ruta Comercial', 'Ruta por zona de negocios', 'Comercial', 12.8, 35, 'Fácil', SYSTIMESTAMP, 'A');

-- ===============================================
-- Inserciones en ROUTES_POINTS 
-- ===============================================
INSERT INTO dev1.routes_points VALUES (1, 1, 1, 'Plaza Mayor', 'Inicio en centro histórico', -12.0464, -77.0428, 'Inicio', 0, 0, 'Inicio ruta', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes_points VALUES (2, 1, 2, 'Parque Kennedy', 'Parada intermedia', -12.1235, -77.0297, 'Intermedio', 15, 6000, 'Parada breve', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes_points VALUES (3, 2, 1, 'Estadio Nacional', 'Inicio ruta norte', -12.0669, -77.0331, 'Inicio', 0, 0, 'Inicio ruta', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes_points VALUES (4, 2, 2, 'Plaza Norte', 'Parada comercial', -12.0115, -77.0603, 'Intermedio', 30, 11000, 'Zona concurrida', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes_points VALUES (5, 3, 1, 'Museo Sur', 'Inicio ruta sur', -12.1842, -77.0133, 'Inicio', 0, 0, 'Inicio ruta', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes_points VALUES (6, 4, 1, 'Parque Este', 'Inicio ruta este', -12.0551, -76.9501, 'Inicio', 0, 0, 'Inicio ruta', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes_points VALUES (7, 5, 1, 'Plaza Oeste', 'Inicio ruta oeste', -12.0891, -77.1002, 'Inicio', 0, 0, 'Inicio ruta', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes_points VALUES (8, 6, 1, 'Malecón Costa', 'Inicio ruta litoral', -12.1341, -77.0309, 'Inicio', 0, 0, 'Vista al mar', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes_points VALUES (9, 7, 1, 'Cerro Azul', 'Inicio ruta montaña', -12.3284, -76.7781, 'Inicio', 0, 0, 'Zona alta', SYSTIMESTAMP, 'A');
INSERT INTO dev1.routes_points VALUES (10, 8, 1, 'Autopista Sur', 'Inicio ruta express', -12.0921, -77.0221, 'Inicio', 0, 0, 'Inicio ruta rápida', SYSTIMESTAMP, 'A');

-- ===============================================
-- Inserciones en DELIVERIES 
-- ===============================================
INSERT INTO dev1.deliveries VALUES (1, SYSTIMESTAMP, SYSTIMESTAMP + INTERVAL '40' MINUTE, 25.50, 12.5, 'A', 1001);
INSERT INTO dev1.deliveries VALUES (2, SYSTIMESTAMP, SYSTIMESTAMP + INTERVAL '55' MINUTE, 40.00, 20.3, 'A', 1002);
INSERT INTO dev1.deliveries VALUES (3, SYSTIMESTAMP, SYSTIMESTAMP + INTERVAL '45' MINUTE, 30.00, 15.0, 'A', 1003);
INSERT INTO dev1.deliveries VALUES (4, SYSTIMESTAMP, SYSTIMESTAMP + INTERVAL '25' MINUTE, 20.00, 8.2, 'A', 1004);
INSERT INTO dev1.deliveries VALUES (5, SYSTIMESTAMP, SYSTIMESTAMP + INTERVAL '50' MINUTE, 35.00, 18.9, 'A', 1005);
INSERT INTO dev1.deliveries VALUES (6, SYSTIMESTAMP, SYSTIMESTAMP + INTERVAL '60' MINUTE, 45.00, 22.7, 'A', 1006);
INSERT INTO dev1.deliveries VALUES (7, SYSTIMESTAMP, SYSTIMESTAMP + INTERVAL '90' MINUTE, 70.00, 30.0, 'A', 1007);
INSERT INTO dev1.deliveries VALUES (8, SYSTIMESTAMP, SYSTIMESTAMP + INTERVAL '20' MINUTE, 18.00, 10.0, 'A', 1008);
INSERT INTO dev1.deliveries VALUES (9, SYSTIMESTAMP, SYSTIMESTAMP + INTERVAL '40' MINUTE, 28.00, 16.4, 'A', 1009);
INSERT INTO dev1.deliveries VALUES (10, SYSTIMESTAMP, SYSTIMESTAMP + INTERVAL '35' MINUTE, 24.00, 12.8, 'A', 1010);

-- ===============================================
-- Inserciones en DELIVERY_ROUTES 
-- ===============================================
INSERT INTO dev1.delivery_routes VALUES (1, 1, 1, 'N', 0, 40, 12.5, 5, SYSTIMESTAMP, 'Entrega sin inconvenientes');
INSERT INTO dev1.delivery_routes VALUES (2, 2, 2, 'N', 1, 55, 20.3, 4, SYSTIMESTAMP, 'Pequeño desvío en ruta norte');
INSERT INTO dev1.delivery_routes VALUES (3, 3, 3, 'N', 0, 45, 15.0, 5, SYSTIMESTAMP, 'Ruta sur completada');
INSERT INTO dev1.delivery_routes VALUES (4, 4, 4, 'N', 0, 25, 8.2, 5, SYSTIMESTAMP, 'Ruta este rápida');
INSERT INTO dev1.delivery_routes VALUES (5, 5, 5, 'N', 2, 50, 18.9, 3, SYSTIMESTAMP, 'Retraso por tráfico en oeste');
INSERT INTO dev1.delivery_routes VALUES (6, 6, 6, 'N', 0, 60, 22.7, 4, SYSTIMESTAMP, 'Ruta litoral completada');
INSERT INTO dev1.delivery_routes VALUES (7, 7, 7, 'N', 1, 90, 30.0, 4, SYSTIMESTAMP, 'Ruta montaña complicada');
INSERT INTO dev1.delivery_routes VALUES (8, 8, 8, 'N', 0, 20, 10.0, 5, SYSTIMESTAMP, 'Ruta express sin problemas');
INSERT INTO dev1.delivery_routes VALUES (9, 9, 9, 'N', 1, 40, 16.4, 4, SYSTIMESTAMP, 'Ruta industrial con desvío');
INSERT INTO dev1.delivery_routes VALUES (10, 10, 10, 'N', 0, 35, 12.8, 5, SYSTIMESTAMP, 'Ruta comercial perfecta');

