USE my_pets;
-- OBTENER EL APELLIDO DEL CIRUJANO CON MAS EXPERIENCIA, BUSCANDO POR ALGUN CARACTER COINCIDIENTE EN SU APELLIDO
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `Buscar_cirujano_mas_experimentado_por_apellido` (lastNameInput VARCHAR(30)) RETURNS varchar(200) CHARSET utf8mb4
READS SQL DATA
BEGIN
		DECLARE last_name VARCHAR(30);   
		DECLARE surgeries INT;   
		DECLARE response VARCHAR(200);   
		SET last_name = (
				SELECT vet.last_name
				FROM surgery JOIN vet ON surgery.id_vet = vet.id_vet
				WHERE vet.last_name LIKE CONCAT ("%" , lastNameInput , "%" )
				GROUP BY vet.id_vet
				ORDER BY COUNT(*) DESC
				LIMIT 1
			);    
		SET surgeries = (
				SELECT COUNT(*)
				FROM surgery JOIN vet ON surgery.id_vet = vet.id_vet
				WHERE vet.last_name LIKE CONCAT ("%" , lastNameInput , "%" )
				GROUP BY vet.id_vet
				ORDER BY COUNT(*) DESC
				LIMIT 1
			);    
		IF (last_name IS NULL)
			THEN SET response = CONCAT("No hay un cirujano con un apellido que contenga el parametro " , lastNameInput);
		ELSE
			SET response = CONCAT (last_name, " es el cirujano mas experimentado,tiene ", surgeries, " cirugias y concuerda con el parametro." );
		END IF;        
		RETURN response;
END $$
DELIMITER ;
-- -------------------------------------------------

-- CORROBORAR VALIDEZ DE UN STOCK, Ingresar id_medicine, Stock inicial y stock actual; 
-- Devuelve 1 si el stock es correcto o 0 si no lo es.
-- SELECT my_pets.validar_stock_por_id_medicine(1, 30, 28); 30 - 28 = 2 = 2Un vendidas => retorna 1
-- SELECT my_pets.validar_stock_por_id_medicine(1, 30, 29);  30 - 29 = 1 != 2Un vendidas => retorna 0
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `validar_stock_por_id_medicine` (id_medicine_input INT , stock_inicial_input INT , stock_actual_input INT) 
RETURNS INT
READS SQL DATA
BEGIN
		DECLARE stock_vendido INT;           
		DECLARE response VARCHAR(200);   
		SET stock_vendido = (
							SELECT drogas_usadas_cantidad_para_reposicion.`Unidades usadas`
                            FROM drogas_usadas_cantidad_para_reposicion
							WHERE drogas_usadas_cantidad_para_reposicion.Medicina = id_medicine_input
							);    
		IF (stock_inicial_input - stock_vendido = stock_actual_input)
			THEN SET response = 1;
		ELSE
			SET response = 0;
		END IF;        
		RETURN response;
END $$
DELIMITER ;
