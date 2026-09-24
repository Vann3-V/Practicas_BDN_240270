/* ===================================================
   1. ELIMINACIÓN PREVIA DE USUARIOS Y ROLES
   =================================================== */
DROP USER IF EXISTS 'marco.ramirez'@'%';
DROP USER IF EXISTS 'alfonso.garcia'@'%';
DROP USER IF EXISTS 'mario.banda'@'%';
DROP USER IF EXISTS 'vanessa.vergara'@'%';
DROP USER IF EXISTS 'pablo.martinez'@'%';

DROP ROLE IF EXISTS 'superadmin';
DROP ROLE IF EXISTS 'admin';
DROP ROLE IF EXISTS 'seller';
DROP ROLE IF EXISTS 'buyer';
DROP ROLE IF EXISTS 'support';
DROP ROLE IF EXISTS 'common';
DROP ROLE IF EXISTS 'user_not_registred';

/* ===================================================
   2. CREACIÓN DE USUARIOS
   =================================================== */
CREATE USER 'marco.ramirez'@'%' IDENTIFIED BY 'querty123';
CREATE USER 'vanessa.vergara'@'%' IDENTIFIED BY '240270';
CREATE USER 'mario.banda'@'%' IDENTIFIED BY '240597';
CREATE USER 'alfonso.garcia'@'%' IDENTIFIED BY '240904';
CREATE USER 'pablo.martinez'@'%' IDENTIFIED BY '240701';

/* ===================================================
   3. CREACIÓN DE ROLES
   =================================================== */
CREATE ROLE 'superadmin';
CREATE ROLE 'admin';
CREATE ROLE 'seller';
CREATE ROLE 'buyer';
CREATE ROLE 'support';
CREATE ROLE 'common';
CREATE ROLE 'user_not_registred';

/* ===================================================
   4. ASIGNACIÓN DE PRIVILEGIOS A LOS ROLES Y USUARIOS
   =================================================== */
-- Permisos directos a usuarios
GRANT ALL PRIVILEGES ON *.* TO 'vanessa.vergara'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test_7b.* TO 'mario.banda'@'%';

-- Permisos a roles
GRANT ALL PRIVILEGES ON *.* TO 'superadmin';
GRANT ALL PRIVILEGES ON db_test_7b.* TO 'admin';

GRANT SELECT, UPDATE, INSERT ON db_test_7b.tb_users TO 'support';
GRANT SELECT, UPDATE, INSERT ON db_test_7b.tb_products TO 'support';

GRANT SELECT, INSERT, UPDATE ON db_test_7b.tb_products TO 'seller';

/* ===================================================
   5. ASIGNACIÓN DE ROLES A USUARIOS
   =================================================== */
GRANT 'superadmin' TO 'vanessa.vergara'@'%';
GRANT 'admin' TO 'marco.ramirez'@'%';
GRANT 'support' TO 'mario.banda'@'%';
GRANT 'seller' TO 'alfonso.garcia'@'%';
GRANT 'seller' TO 'pablo.martinez'@'%';

/* ===================================================
   6. DEFINIR ROLES POR DEFECTO
   =================================================== */
SET DEFAULT ROLE 'support' TO 'mario.banda'@'%';
SET DEFAULT ROLE 'seller' TO 'pablo.martinez'@'%';
SET DEFAULT ROLE 'seller' TO 'alfonso.garcia'@'%';

/* ===================================================
   7. APLICAR CAMBIOS
   =================================================== */
FLUSH PRIVILEGES;

SELECT 'Usuarios y roles creados correctamente' AS mensaje;


