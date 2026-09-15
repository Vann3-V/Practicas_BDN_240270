CREATE USER 'marco.ramirez'@'%' IDENTIFIED BY 'querty123';
CREATE USER 'vanessa.vergara'@'%' IDENTIFIED BY '240270';
CREATE USER 'mario.banda'@'%' IDENTIFIED BY '240597';
CREATE USER 'jessy.barona'@'%' IDENTIFIED BY ' 240491';

/*Asignar privilegios a los usuarios*/
CREATE ALL PRIVILEGES ON *.* TO 'vanessa.vergara'@'%';

CREATE SELECT, INSERT, UPDATE, DELETE ON `db_test_7b`.* TO 'mario.banda'@'%';

/*cREACIÓN DE ROLES PARA EL SISTEMA DE ECOMERCE*/
CREATE ROLE 'admin';
CREATE ROLE 'seller';
CREATE ROLE 'buyer';
CREATE ROLE 'support';
CREATE ROLE 'common';
CREATE ROLE 'user_not_registered';

/*ASIGNACIÓN DE PRIVILEGIOS A LOS ROLES*/
GRANT ALL PRIVILEGES ON *.* TO 'admin';
--SUPPORT
GRANT SELECT, INSERT, UPDATE, DELETE ON `db_test_7b`.* TO 'support';

/* ASIGNAR ROLES A LOS USUARIOS */
GRANT 'admin' TO 'marco.ramirez'@'%';
GRANT 'support' TO 'vanessa.vergara'@'%';

