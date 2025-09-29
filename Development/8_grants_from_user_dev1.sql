-------------------------------------------------
-- PERMISOS DE DEVELOPER_01 A DEVELOPER_02
-------------------------------------------------
GRANT SELECT ON deliveries TO DEVELOPER_02;
GRANT SELECT ON routes TO DEVELOPER_02;
GRANT SELECT ON routes_points TO DEVELOPER_02;
GRANT SELECT ON delivery_routes TO DEVELOPER_02;

-------------------------------------------------
-- PERMISOS DE DEVELOPER_01 A DEVELOPER_03
-------------------------------------------------
GRANT SELECT ON deliveries TO DEVELOPER_03;
GRANT SELECT ON routes TO DEVELOPER_03;
GRANT SELECT ON routes_points TO DEVELOPER_03;
GRANT SELECT ON delivery_routes TO DEVELOPER_03;
