USE my_pets;
SELECT @@autocommit; -- REVISO ESTADO DE AUTOCOMMIT
SET @AUTOCOMMIT = 0; -- DESHABILITO AUTOCOMMIT

-- --------- TABLA USER ----
-- ESTA TABLA TIENE RESTRICCIONES, POR LO QUE SE CREAN DATOS NUEVOS QUE PERMITAN ELIMINAR
/*
DATOS A ELIMINAR
INSERT INTO `my_pets`.`user` (`email`, `password`) VALUES 
('1@gmail.com', 'password' ),
('2@gmail.com', 'password' ),
('3@gmail.com', 'password' ),
('4@gmail.com', 'password' ),
('5@gmail.com', 'password' ),
('6@gmail.com', 'password' ),
('7@gmail.com', 'password' );
*/
START TRANSACTION;
DELETE FROM user
WHERE user.email LIKE "1%" 
	OR user.email LIKE "2%" 
	OR user.email LIKE "3%" 
	OR user.email LIKE "4%"
	OR user.email LIKE "5%" 
	OR user.email LIKE "6%" 
	OR user.email LIKE "7%";
    
-- ROLLBACK; -- PARA DESHACER TRANSACCION
-- COMMIT; -- PARA CONFIRMAR DELETES
-- SELECT * FROM user;
-- --------- TABLA USER --------- 

-- --------- TABLA TREATMENT_MEDICINE -- ESTA TABLA NO TIENE RESTRICCIONES ------- 
START TRANSACTION;
INSERT INTO `my_pets`.`treatment_medicine` (id_treatment , id_medicine)
VALUES 
(1,2),
(1,3),
(1,1),
(2,2);
SAVEPOINT primer_cuarteto; -- GUARDAR PUNTO DE PRIMERAS INSERCIONES

INSERT INTO `my_pets`.`treatment_medicine` (id_treatment , id_medicine)
VALUES 
(2,3),
(2,1),
(2,3),
(2,1);
SAVEPOINT segundo_cuarteto; -- GUARDAR PUNTO DE SEGUNDAS INSERCIONES

RELEASE SAVEPOINT primer_cuarteto; -- ELIMINAR EL PUNTO DE LAS PRIMERAS INSERCIONES
-- SELECT * FROM treatment_medicine;
-- --------- TABLA TREATMENT_MEDICINE --------- 

SET @AUTOCOMMIT = 1; -- VUELVO A HABLITAR AUTOCOMMIT
