/* ==============================================================================
   PRACTICA 02 - CREACION DE USUARIOS REMOTOS, ROLES Y PRIVILEGIOS
   Base de datos: db_test_7b
   Ejecutar con el usuario root DESPUES de database_structure.sql
   ============================================================================== */

SET NAMES utf8mb4;

/* ==============================================================================
   1. ELIMINACION PREVIA DE USUARIOS Y ROLES (el script se puede volver a ejecutar)
   ============================================================================== */

DROP USER IF EXISTS 'marco.ramirez'@'%';
DROP USER IF EXISTS 'vanessa.vergara'@'%';
DROP USER IF EXISTS 'mario.banda'@'%';
DROP USER IF EXISTS 'alfonso.garcia'@'%';
DROP USER IF EXISTS 'pablo.martinez'@'%';
DROP USER IF EXISTS 'harold.peralta'@'%';

DROP ROLE IF EXISTS 'superadmin';
DROP ROLE IF EXISTS 'admin';
DROP ROLE IF EXISTS 'seller';
DROP ROLE IF EXISTS 'buyer';
DROP ROLE IF EXISTS 'support';
DROP ROLE IF EXISTS 'common_user';
DROP ROLE IF EXISTS 'user_not_registered';
/* nombres anteriores (con typo) por si quedaron de la primera version */
DROP ROLE IF EXISTS 'common';
DROP ROLE IF EXISTS 'user_not_registred';


/* ==============================================================================
   2. CREACION DE USUARIOS REMOTOS
   ============================================================================== */

CREATE USER 'marco.ramirez'@'%'   IDENTIFIED BY 'qwerty123';
CREATE USER 'vanessa.vergara'@'%' IDENTIFIED BY '240270';
CREATE USER 'mario.banda'@'%'     IDENTIFIED BY '240597';
CREATE USER 'alfonso.garcia'@'%'  IDENTIFIED BY '240904';
CREATE USER 'pablo.martinez'@'%'  IDENTIFIED BY '240701';
CREATE USER 'harold.peralta'@'%'  IDENTIFIED BY '240497';


/* ==============================================================================
   3. CREACION DE ROLES
   ============================================================================== */

CREATE ROLE 'superadmin';
CREATE ROLE 'admin';
CREATE ROLE 'seller';
CREATE ROLE 'buyer';
CREATE ROLE 'support';
CREATE ROLE 'common_user';
CREATE ROLE 'user_not_registered';


/* ==============================================================================
   4. ASIGNACION DE PRIVILEGIOS DIRECTOS A USUARIOS
   ============================================================================== */

/* Vanessa: superadministradora del servidor (puede crear usuarios y dar permisos) */
GRANT ALL PRIVILEGES ON *.* TO 'vanessa.vergara'@'%' WITH GRANT OPTION;

/* Mario: operaciones de datos sobre toda la base db_test_7b */
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test_7b.* TO 'mario.banda'@'%';


/* ==============================================================================
   5. ASIGNACION DE PRIVILEGIOS A LOS ROLES
   ============================================================================== */

/* SUPERADMIN */
GRANT ALL PRIVILEGES ON *.* TO 'superadmin';

/* ADMIN */
GRANT ALL PRIVILEGES ON db_test_7b.* TO 'admin';

/* SUPPORT */
GRANT SELECT, INSERT, UPDATE ON db_test_7b.tb_users    TO 'support';
GRANT SELECT, INSERT, UPDATE ON db_test_7b.tb_products TO 'support';

/* SELLER */
GRANT SELECT, INSERT, UPDATE ON db_test_7b.tb_products TO 'seller';


/* ==============================================================================
   6. ASIGNACION DE ROLES A USUARIOS
   ============================================================================== */

GRANT 'superadmin' TO 'vanessa.vergara'@'%';
GRANT 'admin'      TO 'marco.ramirez'@'%';
GRANT 'support'    TO 'mario.banda'@'%';
GRANT 'seller'     TO 'alfonso.garcia'@'%';
GRANT 'seller'     TO 'pablo.martinez'@'%';
GRANT 'seller'     TO 'harold.peralta'@'%';


/* ==============================================================================
   7. ACTIVACION DE ROLES POR DEFECTO
   ============================================================================== */

SET DEFAULT ROLE 'superadmin' TO 'vanessa.vergara'@'%';
SET DEFAULT ROLE 'admin'      TO 'marco.ramirez'@'%';
SET DEFAULT ROLE 'support'    TO 'mario.banda'@'%';
SET DEFAULT ROLE 'seller'     TO 'alfonso.garcia'@'%';
SET DEFAULT ROLE 'seller'     TO 'pablo.martinez'@'%';
SET DEFAULT ROLE 'seller'     TO 'harold.peralta'@'%';

FLUSH PRIVILEGES;

SELECT 'Los usuarios y privilegios han sido creados correctamente' AS mensaje;