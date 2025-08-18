-- RELACIONES (CLAVES FORÁNEAS)


-- Relaciones de users
ALTER TABLE users ADD CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES role(id);

-- Relaciones de orders
ALTER TABLE orders ADD CONSTRAINT fk_orders_users FOREIGN KEY (users_id) REFERENCES users(id);

-- Relaciones de order_details
ALTER TABLE order_details ADD CONSTRAINT fk_order_details_orders FOREIGN KEY (orders_id) REFERENCES orders(id) ON DELETE CASCADE;

-- Relaciones de product
ALTER TABLE product ADD CONSTRAINT fk_product_orders FOREIGN KEY (orders_id) REFERENCES orders(id);

-- Relaciones de address
ALTER TABLE address ADD CONSTRAINT fk_address_orders FOREIGN KEY (orders_id) REFERENCES orders(id);

-- Relaciones de user_addresses
ALTER TABLE user_addresses ADD CONSTRAINT fk_user_addresses_users FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE;
ALTER TABLE user_addresses ADD CONSTRAINT fk_user_addresses_address FOREIGN KEY (address_id) REFERENCES address(id);

-- Relaciones de status_tracking
ALTER TABLE status_tracking ADD CONSTRAINT fk_st_orders FOREIGN KEY (orders_id) REFERENCES orders(id) ON DELETE CASCADE;

-- Relaciones de deliveries
ALTER TABLE deliveries ADD CONSTRAINT fk_deliveries_orders FOREIGN KEY (orders_id) REFERENCES orders(id);

-- Relaciones de vehicle_driver
ALTER TABLE vehicle_driver ADD CONSTRAINT fk_vehicle_driver_user FOREIGN KEY (driver_id) REFERENCES users(id);
ALTER TABLE vehicle_driver ADD CONSTRAINT fk_vehicle_driver_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicle(id);

-- Relaciones de routes_points
ALTER TABLE routes_points ADD CONSTRAINT fk_routes_points_routes FOREIGN KEY (routes_id) REFERENCES routes(id) ON DELETE CASCADE;

-- Relaciones de route_segments
ALTER TABLE route_segments ADD CONSTRAINT fk_route_segments_routes FOREIGN KEY (routes_id) REFERENCES routes(id) ON DELETE CASCADE;
ALTER TABLE route_segments ADD CONSTRAINT fk_route_segments_origin FOREIGN KEY (origin_point) REFERENCES routes_points(id);
ALTER TABLE route_segments ADD CONSTRAINT fk_route_segments_destination FOREIGN KEY (destination_point) REFERENCES routes_points(id);

-- Relaciones de origin_destination_routes
ALTER TABLE origin_destination_routes ADD CONSTRAINT fk_odr_source FOREIGN KEY (source_address) REFERENCES user_addresses(id);
ALTER TABLE origin_destination_routes ADD CONSTRAINT fk_odr_destination FOREIGN KEY (destination_address) REFERENCES user_addresses(id);
ALTER TABLE origin_destination_routes ADD CONSTRAINT fk_odr_main_path FOREIGN KEY (main_path) REFERENCES routes(id);
ALTER TABLE origin_destination_routes ADD CONSTRAINT fk_odr_alternative FOREIGN KEY (alternative_route) REFERENCES routes(id);

-- Relaciones de driver_favorite_routes
ALTER TABLE driver_favorite_routes ADD CONSTRAINT fk_dfr_driver FOREIGN KEY (driver_id) REFERENCES users(id);
ALTER TABLE driver_favorite_routes ADD CONSTRAINT fk_dfr_routes FOREIGN KEY (routes_id) REFERENCES routes(id);

-- Relaciones de driver_assignments
ALTER TABLE driver_assignments ADD CONSTRAINT fk_da_driver FOREIGN KEY (driver_id) REFERENCES users(id);
ALTER TABLE driver_assignments ADD CONSTRAINT fk_da_routes FOREIGN KEY (routes_id) REFERENCES routes(id);

-- Relaciones de delivery_routes
ALTER TABLE delivery_routes ADD CONSTRAINT fk_dr_deliveries FOREIGN KEY (deliveries_id) REFERENCES deliveries(id);
ALTER TABLE delivery_routes ADD CONSTRAINT fk_dr_routes FOREIGN KEY (routes_id) REFERENCES routes(id);


-- TRIGGERS PARA FUNCIONALIDAD AUTOMÁTICA


-- Trigger para asegurar solo una dirección principal por usuario
CREATE OR REPLACE TRIGGER tr_unique_main_address
    BEFORE INSERT OR UPDATE ON user_addresses
    FOR EACH ROW
    WHEN (NEW.is_main = 'S')
BEGIN
    UPDATE user_addresses
    SET is_main = 'N'
    WHERE users_id = :NEW.users_id
    AND is_main = 'S'
    AND id != NVL(:NEW.id, -1);
END tr_unique_main_address;
/

-- Trigger para asegurar solo un vehículo principal por conductor
CREATE OR REPLACE TRIGGER tr_unique_main_vehicle
    BEFORE INSERT OR UPDATE ON vehicle_driver
    FOR EACH ROW
    WHEN (NEW.is_main = 'S')
BEGIN
    UPDATE vehicle_driver
    SET is_main = 'N'
    WHERE driver_id = :NEW.driver_id
    AND is_main = 'S'
    AND status = 'A'
    AND id != NVL(:NEW.id, -1);
END tr_unique_main_vehicle;
/

CREATE OR REPLACE TRIGGER tr_update_route_totals
FOR INSERT OR UPDATE OR DELETE ON routes_points
COMPOUND TRIGGER

  TYPE t_set IS TABLE OF BOOLEAN INDEX BY PLS_INTEGER;
  g_route_set t_set;

  PROCEDURE add_id(p_id NUMBER) IS
    k PLS_INTEGER;
  BEGIN
    IF p_id IS NOT NULL THEN
      k := TRUNC(p_id); --
      g_route_set(k) := TRUE;
    END IF;
  END;

  AFTER EACH ROW IS
  BEGIN
    IF INSERTING OR UPDATING THEN
      add_id(:NEW.routes_id);
    ELSE
      add_id(:OLD.routes_id);
    END IF;
  END AFTER EACH ROW;

  AFTER STATEMENT IS
    k PLS_INTEGER;
  BEGIN
    k := g_route_set.FIRST;
    WHILE k IS NOT NULL LOOP
      UPDATE routes r
         SET r.distance_km = (
               SELECT CASE
                        WHEN SUM(distance_meters) > 0
                          THEN SUM(distance_meters) / 1000
                      END
               FROM   routes_points
               WHERE  routes_id = k
               AND    status = 'A'
             ),
             r.estimated_time_minutes = (
               SELECT CASE
                        WHEN SUM(estimated_time_minutes) > 0
                          THEN SUM(estimated_time_minutes)
                      END
               FROM   routes_points
               WHERE  routes_id = k
               AND    status = 'A'
             )
       WHERE r.id = k;

      k := g_route_set.NEXT(k);
    END LOOP;
  END AFTER STATEMENT;

END tr_update_route_totals;
/

CREATE OR REPLACE TRIGGER tr_update_route_stats
FOR INSERT OR UPDATE OF usage_type, actual_time_minutes, route_rating, deliveries_id, routes_id
ON delivery_routes
COMPOUND TRIGGER

  TYPE t_set IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  g_routes     t_set;
  g_deliveries t_set;

  PROCEDURE add_route(p_id NUMBER) IS k PLS_INTEGER; BEGIN
    IF p_id IS NOT NULL THEN k := TRUNC(p_id); g_routes(k) := 1; END IF;
  END;
  PROCEDURE add_delivery(p_id NUMBER) IS k PLS_INTEGER; BEGIN
    IF p_id IS NOT NULL THEN k := TRUNC(p_id); g_deliveries(k) := 1; END IF;
  END;

  AFTER EACH ROW IS
  BEGIN
    IF INSERTING OR UPDATING THEN
      IF :NEW.usage_type = 'E' OR :OLD.usage_type = 'E' THEN
        add_route(:NEW.routes_id);
        add_delivery(:NEW.deliveries_id);
      END IF;
    END IF;
  END AFTER EACH ROW;

  AFTER STATEMENT IS
    k PLS_INTEGER;
  BEGIN
    k := g_routes.FIRST;
    WHILE k IS NOT NULL LOOP
      UPDATE origin_destination_routes odr
         SET times_used = NVL( (SELECT COUNT(*)
                                FROM delivery_routes dr
                                WHERE dr.routes_id = k AND dr.usage_type = 'E'), 0),
             average_time_minutes = (SELECT NVL(AVG(dr.actual_time_minutes), 0)
                                     FROM delivery_routes dr
                                     WHERE dr.routes_id = k
                                       AND dr.usage_type = 'E'
                                       AND dr.actual_time_minutes IS NOT NULL),
             average_rating = (SELECT NVL(AVG(dr.route_rating), 0)
                               FROM delivery_routes dr
                               WHERE dr.routes_id = k
                                 AND dr.usage_type = 'E'
                                 AND dr.route_rating IS NOT NULL)
       WHERE odr.main_path = k;
      k := g_routes.NEXT(k);
    END LOOP;

    k := g_deliveries.FIRST;
    WHILE k IS NOT NULL LOOP
      DECLARE
        v_route_id  NUMBER;
        v_time      NUMBER;
        v_rating    NUMBER;
        v_driver_id NUMBER;
        v_cnt       NUMBER;
      BEGIN
        SELECT dr.routes_id, dr.actual_time_minutes, dr.route_rating
          INTO v_route_id, v_time, v_rating
          FROM delivery_routes dr
         WHERE dr.deliveries_id = k
           AND dr.usage_type = 'E'
           AND ROWNUM = 1;
        SELECT da.driver_id
          INTO v_driver_id
          FROM driver_assignments da
          JOIN deliveries d ON d.id = k
         WHERE da.routes_id = v_route_id
           AND da.assignment_date <= TRUNC(NVL(d.delivery_time, SYSDATE))
           AND da.status IN ('programada','en_curso','completada')
           AND ROWNUM = 1;

        -- Upsert
        SELECT COUNT(*) INTO v_cnt
          FROM driver_favorite_routes
         WHERE driver_id = v_driver_id
           AND routes_id  = v_route_id;

        IF v_cnt > 0 THEN
          UPDATE driver_favorite_routes
             SET times_used = times_used + 1,
                 last_date = TRUNC(SYSDATE),
                 average_time_minutes = NVL(v_time, average_time_minutes),
                 average_rating       = NVL(v_rating, average_rating)
           WHERE driver_id = v_driver_id
             AND routes_id  = v_route_id;
        ELSE
          INSERT INTO driver_favorite_routes
            (driver_id, routes_id, times_used, first_date_, last_date,
             average_time_minutes, average_rating)
          VALUES
            (v_driver_id, v_route_id, 1, TRUNC(SYSDATE), TRUNC(SYSDATE),
             v_time, v_rating);
        END IF;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN NULL;
        WHEN OTHERS THEN NULL;
      END;

      k := g_deliveries.NEXT(k);
    END LOOP;
  END AFTER STATEMENT;

END tr_update_route_stats;
/

CREATE OR REPLACE TRIGGER tr_update_driver_stats
    AFTER UPDATE ON deliveries
    FOR EACH ROW
    WHEN (NEW.status = 'E' AND OLD.status != 'E')
DECLARE
    v_driver_id NUMBER;
    v_avg_rating NUMBER;
BEGIN
    SELECT da.driver_id INTO v_driver_id
    FROM driver_assignments da
    JOIN delivery_routes dr ON da.routes_id = dr.routes_id
    WHERE dr.deliveries_id = :NEW.id
    AND da.status = 'completada'
    AND ROWNUM = 1;

    SELECT NVL(AVG(dr.route_rating), 0) INTO v_avg_rating
    FROM delivery_routes dr
    JOIN deliveries d ON dr.deliveries_id = d.id
    JOIN driver_assignments da ON da.routes_id = dr.routes_id
    WHERE da.driver_id = v_driver_id
    AND d.status = 'E'
    AND dr.route_rating IS NOT NULL;

    UPDATE users
    SET total_deliveries = total_deliveries + 1,
        average_grade = v_avg_rating
    WHERE id = v_driver_id;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL;
    WHEN OTHERS THEN
        NULL;
END tr_update_driver_stats;
/

CREATE OR REPLACE TRIGGER tr_update_order_status
    AFTER UPDATE ON deliveries
    FOR EACH ROW
    WHEN (NEW.status = 'E' AND OLD.status != 'E')
BEGIN
    UPDATE orders
    SET status = 'E'
    WHERE id = :NEW.orders_id;

    INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
    VALUES (:NEW.orders_id, 'T', 'E', 'Entrega completada automáticamente', 'SYSTEM');

EXCEPTION
    WHEN OTHERS THEN
        NULL;
END tr_update_order_status;
/

CREATE OR REPLACE TRIGGER tr_calculate_order_total
FOR INSERT OR UPDATE OR DELETE ON order_details
COMPOUND TRIGGER

  TYPE t_set IS TABLE OF BOOLEAN INDEX BY PLS_INTEGER;
  g_order_set t_set;

  PROCEDURE add_id(p_id NUMBER) IS
    k PLS_INTEGER;
  BEGIN
    IF p_id IS NOT NULL THEN
      k := TRUNC(p_id);
      g_order_set(k) := TRUE;
    END IF;
  END;

  AFTER EACH ROW IS
  BEGIN
    IF INSERTING OR UPDATING THEN
      add_id(:NEW.orders_id);
    ELSE
      add_id(:OLD.orders_id);
    END IF;
  END AFTER EACH ROW;

  AFTER STATEMENT IS
    k PLS_INTEGER;
    v_subtotal NUMBER;
  BEGIN
    k := g_order_set.FIRST;
    WHILE k IS NOT NULL LOOP
      SELECT NVL(SUM(quantity * NVL(unit_price, 0)), 0)
        INTO v_subtotal
        FROM order_details
       WHERE orders_id = k;

      UPDATE orders
         SET subtotal = v_subtotal,
             total    = v_subtotal + shipping_cost
       WHERE id = k;

      k := g_order_set.NEXT(k);
    END LOOP;
  END AFTER STATEMENT;

END tr_calculate_order_total;
/

CREATE OR REPLACE TRIGGER tr_track_order_status_changes
    AFTER UPDATE ON orders
    FOR EACH ROW
    WHEN (OLD.status != NEW.status)
BEGIN
    INSERT INTO status_tracking (orders_id, previous_status, new_status, "comment", "user")
    VALUES (:NEW.id, :OLD.status, :NEW.status, 'Cambio automático de estado', 'SYSTEM');
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END tr_track_order_status_changes;
/

-- Vista de usuarios completa
CREATE OR REPLACE VIEW vista_users_complete AS
SELECT
    u.id,
    u.name || ' ' || u.last_name AS full_name,
    u.email,
    u.phone,
    u.sex,
    u.document_type,
    u.document_number,
    r.name AS role_name,
    r.description AS role_description,
    CASE u.status
        WHEN 'A' THEN 'Activo'
        WHEN 'I' THEN 'Inactivo'
        WHEN 'S' THEN 'Suspendido'
    END AS status_description,
    u.creation_register,
    u.company_name,
    u.license,
    u.total_deliveries,
    u.average_grade,
    u.hire_date
FROM users u
JOIN role r ON u.role_id = r.id;

-- Vista de vehículos con conductores
CREATE OR REPLACE VIEW vista_vehicle_drivers AS
SELECT
    v.id,
    v.plate,
    v.vehicle_type,
    v.brand,
    v.model,
    CASE v.status
        WHEN 'A' THEN 'Activo'
        WHEN 'I' THEN 'Inactivo'
        WHEN 'M' THEN 'Mantenimiento'
        WHEN 'F' THEN 'Fuera de servicio'
    END AS status_description,
    v.load_capacity,
    u.name || ' ' || u.last_name AS assigned_driver,
    u.email AS driver_email,
    CASE vd.is_main WHEN 'S' THEN 'Principal' ELSE 'Secundario' END AS vehicle_priority,
    vd.assignment_date,
    CASE vd.status WHEN 'A' THEN 'Activo' ELSE 'Inactivo' END AS assignment_status
FROM vehicle v
LEFT JOIN vehicle_driver vd ON v.id = vd.vehicle_id AND vd.status = 'A'
LEFT JOIN users u ON vd.driver_id = u.id;

-- Vista de rutas completa con puntos
CREATE OR REPLACE VIEW vista_route_complete AS
SELECT
    r.id AS route_id,
    r.name AS route_name,
    r.description AS route_description,
    r.main_district,
    r.distance_km,
    r.estimated_time_minutes,
    rp.id AS point_id,
    rp."order" AS point_order,
    rp.name AS point_name,
    rp.description AS point_description,
    rp.point_type,
    rp.latitude,
    rp.length,
    rp.estimated_time_minutes AS point_time,
    rp.distance_meters
FROM routes r
JOIN routes_points rp ON r.id = rp.routes_id
WHERE r.status = 'A' AND rp.status = 'A'
ORDER BY r.id, rp."order";

-- Vista de pedidos completa
CREATE OR REPLACE VIEW vista_orders_complete AS
SELECT
    o.id,
    o.order_code,
    u.name || ' ' || u.last_name AS client_name,
    u.email AS client_email,
    u.phone AS client_phone,
    u.company_name,
    a.street || ' ' || NVL(a."number", '') || ', ' || a.district AS delivery_address,
    a.reference AS delivery_reference,
    o.order_date,
    o.requested_delivery_date,
    CASE o.status
        WHEN 'R' THEN 'Recibido'
        WHEN 'C' THEN 'Confirmado'
        WHEN 'P' THEN 'Preparando'
        WHEN 'T' THEN 'En Tránsito'
        WHEN 'E' THEN 'Entregado'
        WHEN 'X' THEN 'Cancelado'
    END AS status_description,
    CASE o.priority
        WHEN 'B' THEN 'Baja'
        WHEN 'N' THEN 'Normal'
        WHEN 'A' THEN 'Alta'
        WHEN 'U' THEN 'Urgente'
    END AS priority_description,
    o.subtotal,
    o.shipping_cost,
    o.total,
    d.delivery_time,
    CASE d.status
        WHEN 'A' THEN 'Asignada'
        WHEN 'R' THEN 'Recogida'
        WHEN 'T' THEN 'En Tránsito'
        WHEN 'E' THEN 'Entregada'
        WHEN 'F' THEN 'Fallida'
        WHEN 'P' THEN 'Reprogramada'
    END AS delivery_status
FROM orders o
JOIN users u ON o.users_id = u.id
LEFT JOIN address a ON o.id = a.orders_id
LEFT JOIN deliveries d ON o.id = d.orders_id;

-- Vista de rutas más populares
CREATE OR REPLACE VIEW vista_popular_routes AS
SELECT
    r.id AS route_id,
    r.name AS route_name,
    r.description,
    r.main_district,
    r.distance_km,
    r.estimated_time_minutes,
    COUNT(dr.id) as total_deliveries,
    NVL(AVG(dr.actual_time_minutes), 0) as average_real_time,
    NVL(AVG(dr.route_rating), 0) as average_rating,
    COUNT(DISTINCT da.driver_id) as different_drivers,
    MAX(dr.usage_date) as last_used
FROM routes r
LEFT JOIN delivery_routes dr ON r.id = dr.routes_id AND dr.usage_type = 'E'
LEFT JOIN deliveries d ON dr.deliveries_id = d.id
LEFT JOIN driver_assignments da ON da.routes_id = r.id
WHERE r.status = 'A'
GROUP BY r.id, r.name, r.description, r.main_district, r.distance_km, r.estimated_time_minutes
ORDER BY total_deliveries DESC;

-- Vista de estadísticas de conductores
CREATE OR REPLACE VIEW vista_driver_stats AS
SELECT
    u.id AS driver_id,
    u.name || ' ' || u.last_name AS driver_name,
    u.email,
    u.license,
    u.hire_date,
    u.total_deliveries,
    u.average_grade,
    CASE u.status
        WHEN 'A' THEN 'Activo'
        WHEN 'I' THEN 'Inactivo'
        WHEN 'S' THEN 'Suspendido'
    END AS status_description,
    v.plate AS assigned_vehicle,
    v.vehicle_type,
    COUNT(da.id) AS total_assignments,
    COUNT(CASE WHEN da.status = 'completada' THEN 1 END) AS completed_assignments
FROM users u
LEFT JOIN vehicle_driver vd ON u.id = vd.driver_id AND vd.status = 'A' AND vd.is_main = 'S'
LEFT JOIN vehicle v ON vd.vehicle_id = v.id
LEFT JOIN driver_assignments da ON u.id = da.driver_id
WHERE u.role_id = 3 -- Solo conductores
GROUP BY u.id, u.name, u.last_name, u.email, u.license, u.hire_date,
         u.total_deliveries, u.average_grade, u.status, v.plate, v.vehicle_type
ORDER BY u.total_deliveries DESC;

-- Procedimiento para asignar conductor a ruta
CREATE OR REPLACE PROCEDURE sp_assign_driver_to_route(
    p_driver_id        IN NUMBER,
    p_route_id         IN NUMBER,
    p_assignment_date  IN DATE DEFAULT SYSDATE,
    p_start_time       IN DATE DEFAULT NULL,
    p_end_time         IN DATE DEFAULT NULL,
    p_observation      IN VARCHAR2 DEFAULT NULL
) AS
BEGIN
    INSERT INTO driver_assignments (
        driver_id, routes_id, assignment_date, start_time, end_time, status, observation
    ) VALUES (
        p_driver_id, p_route_id, p_assignment_date, p_start_time, p_end_time, 'programada', p_observation
    );

    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20001, 'El conductor ya tiene una asignación para esa fecha');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END sp_assign_driver_to_route;
/

-- Procedimiento para completar una entrega
CREATE OR REPLACE PROCEDURE sp_complete_delivery(
    p_delivery_id IN NUMBER,
    p_actual_time IN NUMBER DEFAULT NULL,
    p_actual_distance IN NUMBER DEFAULT NULL,
    p_route_rating IN NUMBER DEFAULT NULL,
    p_remarks IN VARCHAR2 DEFAULT NULL
) AS
BEGIN
    -- Actualizar la entrega como completada
    UPDATE deliveries
    SET status = 'E',
        delivery_time = CURRENT_TIMESTAMP
    WHERE id = p_delivery_id;

    -- Actualizar información de la ruta utilizada
    UPDATE delivery_routes
    SET usage_type = 'E',
        actual_time_minutes = p_actual_time,
        actual_distance_km = p_actual_distance,
        route_rating = p_route_rating,
        remarks = p_remarks
    WHERE deliveries_id = p_delivery_id;

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Entrega no encontrada');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END sp_complete_delivery;
/

-- Función para obtener el mejor conductor disponible
CREATE OR REPLACE FUNCTION fn_get_best_available_driver(
    p_date IN DATE DEFAULT SYSDATE
) RETURN NUMBER AS
    v_driver_id NUMBER;
BEGIN
    SELECT u.id INTO v_driver_id
    FROM users u
    WHERE u.role_id = 3
    AND u.status = 'A'
    AND NOT EXISTS (
        SELECT 1 FROM driver_assignments da
        WHERE da.driver_id = u.id
        AND da.assignment_date = TRUNC(p_date)
        AND da.status IN ('programada', 'en_curso')
    )
    ORDER BY u.average_grade DESC, u.total_deliveries DESC
    FETCH FIRST 1 ROWS ONLY;

    RETURN v_driver_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RETURN NULL;
END fn_get_best_available_driver;
/

CREATE INDEX idx_orders_requested_date ON orders(requested_delivery_date);
CREATE INDEX idx_deliveries_departure_time ON deliveries(departure_time);
CREATE INDEX idx_delivery_routes_usage_date ON delivery_routes(usage_date);
CREATE INDEX idx_driver_assignments_status ON driver_assignments(status);
CREATE INDEX idx_status_tracking_change_date ON status_tracking(change_date);

-- Reactivar triggers después de las inserciones
ALTER TRIGGER tr_update_route_totals ENABLE;
ALTER TRIGGER tr_update_route_stats ENABLE;
ALTER TRIGGER tr_update_driver_stats ENABLE;
ALTER TRIGGER tr_calculate_order_total ENABLE;