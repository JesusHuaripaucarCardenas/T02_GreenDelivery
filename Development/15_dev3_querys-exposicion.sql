
-- =====================================================
-- JOINS Y FUNCIONES - T02_GreenDelivery
-- =====================================================

-- =====================================================
-- EJEMPLO 1: Pedidos con cliente, aplicando transformaciones de texto
-- =====================================================

SELECT 
    o.id AS order_id,
    o.order_code AS order_code,
    UPPER(u.name) AS name_upper, -- Convierte a MAYÚSCULAS
    INITCAP(u.last_name) AS last_name_initcap, -- Capitaliza palabras
    (u.name || ' ' || u.last_name) AS full_name_concat, -- Concatenación con ||
    SUBSTR(o.order_code, 1, 3) AS order_prefix, -- Subcadena (primeros 3 chars)
    REGEXP_REPLACE(u.email, '(^.).(@.$)', '\1***\2') AS email_masked, -- Enmascara email
    LENGTH(u.email) AS email_len -- Longitud del email
FROM developer_02.orders o
JOIN developer_02.users u ON u.id = o.users_id;

-- =====================================================
-- EJEMPLO 2: Totalización por usuario de importes estimados según detalle (order_details)
-- =====================================================

SELECT 
    u.id AS user_id,
    u.name AS name,
    u.last_name AS last_name,
    ROUND(NVL(SUM(od.quantity * NVL(od.unit_price, 0)), 0), 2) AS gross_amount, -- Monto bruto
    ROUND( NVL(SUM(od.quantity * NVL(od.unit_price, 0)), 0) * 0.18, 2) AS tax_igv, -- 18% IGV referencial
    FLOOR( NVL(SUM(od.quantity), 0) ) AS items_floor, -- Ejemplo de FLOOR
    CEIL( NVL(AVG(NVL(od.unit_price,0)), 0) )  AS avg_price_ceil, -- CEIL sobre promedio
    CASE
    WHEN NVL(SUM(od.quantity * NVL(od.unit_price, 0)), 0) >= 1000 THEN 'ALTO'
    WHEN NVL(SUM(od.quantity * NVL(od.unit_price, 0)), 0) >= 300  THEN 'MEDIO'
    WHEN NVL(SUM(od.quantity * NVL(od.unit_price, 0)), 0) > 0     THEN 'BAJO'
    ELSE 'SIN CONSUMO'
    END AS consumo_clase
FROM developer_02.users u
LEFT JOIN developer_02.orders o ON o.users_id = u.id
LEFT JOIN developer_02.order_details od ON od.orders_id = o.id
GROUP BY u.id, u.name, u.last_name;

-- =====================================================
-- EJEMPLO 3: Entregas (todas) y su uso de rutas, calculando duraciones y formateos
-- =====================================================

SELECT 
    d.id AS delivery_id,
    TO_CHAR(TRUNC(d.departure_time), 'YYYY-MM-DD') AS dep_date, -- Solo fecha
    EXTRACT(HOUR FROM d.departure_time) AS dep_hour, -- Hora de salida
    TO_CHAR(d.delivery_time, 'YYYY-MM-DD HH24:MI') AS deliv_ts, -- Timestamp formateado
    ROUND( (NVL(CAST(d.delivery_time AS DATE), SYSDATE) - CAST(d.departure_time AS DATE)) * 24 * 60 ) AS mins_elapsed, -- Minutos
    TO_CHAR(ADD_MONTHS(TRUNC(d.departure_time), 1), 'YYYY-MM-DD') AS dep_plus_1m, -- Fecha +1 mes
    dr.usage_type  AS route_usage,
    o.order_code  AS order_code
FROM developer_02.delivery_routes dr
RIGHT JOIN developer_02.deliveries d ON d.id = dr.deliveries_id
LEFT JOIN developer_02.orders o ON o.id = d.orders_id;

-- =====================================================
-- EJEMPLO 4: Pedidos vs Entregas: incluye pedidos sin entrega y entregas (teóricamente) sin pedido
-- =====================================================

SELECT 
    NVL2(o.id, 'ORDER', 'NO_ORDER') AS side_order_flag, -- Indica si viene del lado pedido
    COALESCE(o.order_code, TO_CHAR(d.id)) AS ref_code,  -- Código de pedido o id de entrega
    TO_CHAR(o.order_date, 'YYYY-MM-DD HH24:MI') AS order_dt,
    TO_CHAR(d.departure_time, 'YYYY-MM-DD HH24:MI') AS dep_dt,
    TO_CHAR(d.delivery_time, 'YYYY-MM-DD HH24:MI')  AS deliv_dt,
    TO_CHAR(d.delivery_cost, 'FM999G999D00') AS delivery_cost_fmt,
    CASE WHEN d.status IS NULL THEN 'SIN_ENTREGA' ELSE 'CON_ENTREGA' END AS entrega_flag
FROM developer_02.orders o
FULL OUTER JOIN developer_02.deliveries d ON d.orders_id = o.id;




