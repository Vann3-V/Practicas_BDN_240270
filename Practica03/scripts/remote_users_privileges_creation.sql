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

CREATE USER 'marco.ramirez'@'%'   IDENTIFIED BY 'qwerty123';   -- Prof. Marco
CREATE USER 'vanessa.vergara'@'%' IDENTIFIED BY '240270';      -- Superadministradora
CREATE USER 'mario.banda'@'%'     IDENTIFIED BY '240597';
CREATE USER 'alfonso.garcia'@'%'  IDENTIFIED BY '240904';
CREATE USER 'pablo.martinez'@'%'  IDENTIFIED BY '240701';
CREATE USER 'harold.peralta'@'%'  IDENTIFIED BY '240497';


/* ==============================================================================
   3. CREACION DE ROLES PARA EL SISTEMA E-COMMERCE
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

/*
IMPORTANTE:
Este privilegio solamente debe asignarse al usuario administrador.
Vanessa: superadministradora del servidor (puede crear usuarios y dar permisos).
*/
GRANT ALL PRIVILEGES ON *.* TO 'vanessa.vergara'@'%' WITH GRANT OPTION;

/*
Asignar privilegios a un usuario sin rol: no es una buena practica,
pero es bueno saber que se puede realizar y no esta obligatoriamente
ligado con el rol.
*/
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test_7b.tb_users TO 'harold.peralta'@'%';

/*
Asignar privilegios CRUD sobre toda la base db_test_7b.
*/
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test_7b.* TO 'mario.banda'@'%';

/*
Asignar privilegio de manipulacion de archivos para poder cargar
los productos desde un archivo CSV.
*/
GRANT FILE ON *.* TO 'pablo.martinez'@'%';


/* ==============================================================================
   5. ASIGNACION DE PRIVILEGIOS A LOS ROLES
   ============================================================================== */

/* SUPERADMIN */
GRANT ALL PRIVILEGES ON *.* TO 'superadmin';

/* ADMIN */
GRANT ALL PRIVILEGES ON db_test_7b.* TO 'admin';

/* SUPPORT */
GRANT SELECT, INSERT, UPDATE ON db_test_7b.tb_users TO 'support';
GRANT SELECT, UPDATE         ON db_test_7b.tb_products TO 'support';
GRANT SELECT, INSERT, UPDATE ON db_test_7b.tbc_categories TO 'support';

/* SELLER */
GRANT SELECT, INSERT, UPDATE ON db_test_7b.tb_products TO 'seller';


/* ==============================================================================
   6. ASIGNACION DE ROLES A USUARIOS
   ============================================================================== */

-- Este debe ser el Prof. Marco
GRANT 'admin'      TO 'marco.ramirez'@'%';

-- Este eres tu
GRANT 'superadmin' TO 'vanessa.vergara'@'%';

-- IZQUIERDA
GRANT 'support'    TO 'mario.banda'@'%';

-- DERECHA
GRANT 'seller'     TO 'alfonso.garcia'@'%';
GRANT 'seller'     TO 'pablo.martinez'@'%';
GRANT 'seller'     TO 'harold.peralta'@'%';


/* ==============================================================================
   7. ESTABLECER ROLES PREDETERMINADOS
   ============================================================================== */

/*
Esto permite que el rol se active automaticamente cuando
el usuario inicia sesion.
*/
SET DEFAULT ROLE 'admin'      TO 'marco.ramirez'@'%';
SET DEFAULT ROLE 'superadmin' TO 'vanessa.vergara'@'%';
SET DEFAULT ROLE 'support'    TO 'mario.banda'@'%';
SET DEFAULT ROLE 'seller'     TO 'alfonso.garcia'@'%';
SET DEFAULT ROLE 'seller'     TO 'pablo.martinez'@'%';
SET DEFAULT ROLE 'seller'     TO 'harold.peralta'@'%';

FLUSH PRIVILEGES;


/* ==============================================================================
   8. VERIFICACION
   ============================================================================== */

/* Mostrar usuarios remotos creados */
SELECT user, host
FROM mysql.user
WHERE user IN ('marco.ramirez','vanessa.vergara','mario.banda',
               'alfonso.garcia','pablo.martinez','harold.peralta');

SELECT 'Los usuarios y privilegios han sido creados correctamente' AS mensaje;