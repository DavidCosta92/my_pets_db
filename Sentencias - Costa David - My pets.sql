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
