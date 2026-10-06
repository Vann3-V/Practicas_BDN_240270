USE db_test_7b;

/*1.Cuantas tablas existen*/
SHOW TABLES;

/*2. Cuantos triggers existen en la base de datso*/
SHOW triggers FROM db_test_7b;

/*3. Cuantos registros existen en la tabla users*/
SELECT count(*) as total_registros FROM tb_users;

/*4. Cuantos registros existen en la tabla bitacora*/
SELECT count(*) as total_registros from tb_logs;

/*5. Consultar todas las operaciones realizadas en l abase de datos*/
select * FROM tb_logs;

/*6. Verificar wue los usuarios remotos hayan sido creados*/
SELECT user,host from mysql.user where host ='%' and account_locked = 'N';

/*7. Verificar losroles dque fueron creados*/
Select user,host from mysql.user where host= '%' and account_locked ='Y';

/*8. Verificar que usuarios tienen roles*/
SELECT TO_USER as usuario, TO_HOST as host, FROM_USER as rol, FROM_HOST as rol_host
from mysql.role_edges order by TO_USER, FROM_USER; 

/*9. Verificar el total de procedimientos almacenados que existen en la bd*/
SHOW PROCEDURE STATUS WHERE Db= 'db_test_7b';


/* 10. Verificación de productos */
SELECT * FROM tb_products;

/* 11. Contabilizar los productos */
SELECT COUNT(*) AS total_productos FROM tb_products;

/* 12. Trazabilidad de los productos */
SELECT * FROM vw_trazabilidad_productos ORDER BY operation_date DESC LIMIT 10;

/* 13. Trazabilidad de usuarios */
SELECT * FROM vw_trazabilidad_usuarios ORDER BY operation_date ASC;

/* 14. Cuántos productos insertó cada usuario */
SELECT COUNT(*) AS total_productos, vp.inserted_by
FROM vw_trazabilidad_productos vp
GROUP BY vp.inserted_by;