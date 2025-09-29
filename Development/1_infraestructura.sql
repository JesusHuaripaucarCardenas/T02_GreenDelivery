-------------------------------------------------
-- CREACIÓN DE TABLESPACES (consulta actual)
-------------------------------------------------
SELECT username,
       default_tablespace,
       temporary_tablespace,
       account_status
FROM dba_users
ORDER BY username;

-------------------------------------------------
-- CREACIÓN DE USUARIOS
-------------------------------------------------
-- Crear los usuarios en el tablespace DATA
CREATE USER DEVELOPER_01 IDENTIFIED BY Admin12345678;
CREATE USER DEVELOPER_02 IDENTIFIED BY Admin12345678;
CREATE USER DEVELOPER_03 IDENTIFIED BY Admin12345678;

-------------------------------------------------
-- ROLES Y PERMISOS
-------------------------------------------------
-- Otorgar permisos a los usuarios para conexión y recursos (tablas, vistas, etc.)
GRANT CONNECT, RESOURCE TO DEVELOPER_01;
GRANT CONNECT, RESOURCE TO DEVELOPER_02;
GRANT CONNECT, RESOURCE TO DEVELOPER_03;

-------------------------------------------------
-- ACCESO AL REST
-------------------------------------------------
-- Habilitar REST en los esquemas con ORDS
BEGIN
  ORDS.ENABLE_SCHEMA(
    p_enabled => TRUE,                        
    p_schema => 'DEVELOPER_01',               
    p_url_mapping_type => 'BASE_PATH',        
    p_url_mapping_pattern => 'DEVELOPER_01',  
    p_auto_rest_auth => FALSE                 
  );
END;
/

BEGIN
  ORDS.ENABLE_SCHEMA(
    p_enabled => TRUE,                        
    p_schema => 'DEVELOPER_02',               
    p_url_mapping_type => 'BASE_PATH',        
    p_url_mapping_pattern => 'DEVELOPER_02',  
    p_auto_rest_auth => FALSE                 
  );
END;
/

BEGIN
  ORDS.ENABLE_SCHEMA(
    p_enabled => TRUE,                        
    p_schema => 'DEVELOPER_03',               
    p_url_mapping_type => 'BASE_PATH',        
    p_url_mapping_pattern => 'DEVELOPER_03',  
    p_auto_rest_auth => FALSE                 
  );
END;
/

-------------------------------------------------
-- CUOTA ILIMITADA
-------------------------------------------------
-- Dar cuota ilimitada en el tablespace DATA
ALTER USER DEVELOPER_01 QUOTA UNLIMITED ON DATA;
ALTER USER DEVELOPER_02 QUOTA UNLIMITED ON DATA;
ALTER USER DEVELOPER_03 QUOTA UNLIMITED ON DATA;
