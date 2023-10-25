-- USER NORMAL
CREATE USER 'user_david'@'localhost' IDENTIFIED BY 'userDavid';  -- CREACION USUARIO
-- PERMISOS PARA USER NORMAL (Solo lectura en todas las tablas)
GRANT SELECT ON my_pets.* TO 'user_david'@'localhost';  -- TODOS LOS PERMISOS SOBRE TODOS LOS OBJETOS PARA SELECT
-- PARA TESTEAR permisos de user normal
SHOW GRANTS FOR 'user_david'@'localhost'; 
-- Test SELECT user normal
SELECT * FROM my_pets.pet;
-- Test INSERT user normal
INSERT INTO pet  (id_owner , name, species, description, birthday, breed)
values (2, 'D', 'D', 'D', '2009-08-20', 'A');
-- Test UPDATE user normal
UPDATE pet
SET name = 'otro nombre' WHERE (`id_pet` = '9');
-- Test DELETE user normal
DELETE FROM pet
WHERE id_pet = 5;


-- USER ADMIN
CREATE USER 'admin_david'@'localhost' IDENTIFIED BY 'adminavid'; -- CREACION USUARIO
ALTER USER 'admin_david'@'localhost' IDENTIFIED BY 'adminDavid'; -- Cambio password

-- PERMISOS PARA USER admin (todos los permisos menos eliminacion, sobre todas las tablas)
GRANT ALL ON my_pets.* TO 'admin_david'@'localhost';  -- TODOS LOS PERMISOS SOBRE TODOS LOS OBJETOS
REVOKE DELETE ON my_pets.* FROM 'admin_david'@'localhost'; -- ELIMINO PERMISO DE ELIMINACION, lo hago asi para practicar

-- PARA TESTEAR permisos de user admin
SHOW GRANTS FOR 'admin_david'@'localhost';
-- Test SELECT user admin
SELECT * FROM my_pets.pet;
-- Test INSERT user admin
INSERT INTO pet  (id_owner , name, species, description, birthday, breed)
values (2, 'D', 'D', 'D', '2009-08-20', 'A');
-- Test UPDATE user admin
UPDATE pet
SET name = 'otro nombre' WHERE (`id_pet` = '10');
-- Test DELETE user admin
DELETE FROM pet
WHERE id_pet = 10;



USE mysql;
SELECT * FROM user;

CREATE USER 'costa_david'@'%' IDENTIFIED BY 'password123';  -- % seria para cualquier Entorno de aplicacion o dominio ip host que se conecta
CREATE USER 'costa_david'@'127.0.0.1' IDENTIFIED BY 'password123';

ALTER USER 'costa_david'@'localhost' IDENTIFIED BY 'password-CAMBIADO'; 

-- CAMBIAR CONTRASEÑA EN VERSIONES VIEJAS DE SQL
UPDATE USER 
SET Password = PASSWORD('password-CAMBIADO')
WHERE  User = 'costa_david' AND Host = 'localhost';

DROP USER 'costa_david'@'localhost';
RENAME USER 'costa_david'@'localhost' TO 'DAVID'@'localhost';
SHOW GRANTS FOR 'costa_david'@'localhost';


-- PERMISOS
 GRANT ALL ON *.* TO 'costa_david'@'localhost';  -- TODOS LOS PERMISOS SOBRE TODOS LOS OBJETOS
 GRANT ALL ON my_pets.* TO 'costa_david'@'localhost';  -- TODOS LOS PERMISOS SOBRE OBJETOS DE LA BD my_pets
 GRANT ALL ON my_pets.medicine TO 'costa_david'@'localhost';  -- TODOS LOS PERMISOS SOBRE OBJETOS DE LA TABLA medicine
 GRANT SELECT, UPDATE ON my_pets.medicine TO 'costa_david'@'localhost'; -- PERMISOS ESPECIFICOS SOLAMENTE
 GRANT SELECT (campo1 , campo2) ON my_pets.medicine TO 'costa_david'@'localhost';  -- PERMISOS PARA DETERMINADOS CAMPOS, EN ESTE CASO, SELECT * DARIA ERROR, DEBE SER UN SELECT CAMPO1, CAMPO2
 
 REVOKE ALL ON *.* FROM 'costa_david'@'localhost'; 
