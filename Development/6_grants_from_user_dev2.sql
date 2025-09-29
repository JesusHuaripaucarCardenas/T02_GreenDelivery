-------------------------------------------------
-- PERMISOS DE DEVELOPER_02 A DEVELOPER_01
-------------------------------------------------
GRANT SELECT ON orders TO DEVELOPER_01;
GRANT SELECT ON order_details TO DEVELOPER_01;
GRANT SELECT ON product TO DEVELOPER_01;
GRANT SELECT ON status_tracking TO DEVELOPER_01;

-------------------------------------------------
-- PERMISOS DE DEVELOPER_02 A DEVELOPER_03
-------------------------------------------------
GRANT SELECT ON orders TO DEVELOPER_03;
GRANT SELECT ON order_details TO DEVELOPER_03;
GRANT SELECT ON product TO DEVELOPER_03;
GRANT SELECT ON status_tracking TO DEVELOPER_03;
