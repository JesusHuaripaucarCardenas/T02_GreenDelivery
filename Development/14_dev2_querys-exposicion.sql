-- =====================================================
-- EJEMPLOS SIMPLES DE JOINS Y FUNCIONES - T02_GreenDelivery
-- =====================================================

-- =====================================================
-- EJEMPLO 1: Información Básica de Pedidos con Cliente
-- =====================================================

SELECT 
    o.order_code,
    u.name || ' ' || u.last_name AS cliente,
    UPPER(u.email) AS email_mayusculas,
    TO_CHAR(o.order_date, 'DD/MM/YYYY') AS fecha_pedido,
    ROUND(o.total, 2) AS total_redondeado,
    o.status
FROM orders o
INNER JOIN users u ON o.users_id = u.id
WHERE o.status != 'X'
ORDER BY o.order_date DESC;

-- =====================================================
-- EJEMPLO 2: Productos con Precio y Características
-- =====================================================

SELECT 
    p.code,
    SUBSTR(p.name, 1, 20) AS nombre_corto,
    LENGTH(p.description) AS longitud_desc,
    FLOOR(p.unit_weight) AS peso_kg_abajo,
    CEIL(p.unit_weight) AS peso_kg_arriba,
    NVL(p.reference_price, 0) AS precio_referencia,
    o.order_code
FROM product p
INNER JOIN orders o ON p.orders_id = o.id
LEFT JOIN order_details od ON o.id = od.orders_id
WHERE p.status = 'A'
ORDER BY p.code;

-- =====================================================
-- EJEMPLO 3: Seguimiento de Estados de Pedidos
-- =====================================================

SELECT 
    o.order_code,
    TRIM(st."comment") AS comentario,
    COALESCE(st.previous_status, 'NUEVO') AS estado_anterior,
    st.new_status AS estado_nuevo,
    TO_CHAR(st.change_date, 'DD/MM/YYYY HH24:MI') AS fecha_cambio,
    EXTRACT(HOUR FROM st.change_date) AS hora_cambio,
    ROUND(EXTRACT(DAY FROM (st.change_date - o.order_date)) * 24 + 
          EXTRACT(HOUR FROM (st.change_date - o.order_date)), 1) AS horas_desde_pedido
FROM status_tracking st
INNER JOIN orders o ON st.orders_id = o.id
INNER JOIN users u ON o.users_id = u.id
ORDER BY st.change_date DESC;

-- =====================================================
-- EJEMPLO 4: Detalles de Pedido con Cantidades
-- =====================================================

SELECT 
    o.order_code,
    u.name AS cliente,
    COUNT(od.id) AS total_items,
    SUM(od.quantity) AS unidades_totales,
    AVG(od.unit_price) AS precio_promedio,
    TO_CHAR(SUM(od.quantity * od.unit_price), '$9,999.99') AS subtotal,
    TO_NUMBER(TRUNC(SYSDATE) - TRUNC(o.order_date)) AS dias_desde_pedido
FROM order_details od
INNER JOIN orders o ON od.orders_id = o.id
INNER JOIN users u ON o.users_id = u.id
LEFT JOIN product p ON o.id = p.orders_id
GROUP BY o.order_code, o.order_date, u.name
ORDER BY o.order_code;
