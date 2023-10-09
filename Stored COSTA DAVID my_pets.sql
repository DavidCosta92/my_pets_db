USE my_pets;

/*
Stored procedure para consultar una tabla por nombre y ordernarla de forma ascendente o descendente por determinado campo
Los parametros de ingreso son opcionales, execpto el nombre de tabla
Ejemplos: 
	call my_pets.obtener_tabla_ordenada_por('medicine', '', ''); 
	call my_pets.obtener_tabla_ordenada_por('medicine', 'drug', ''); 
	call my_pets.obtener_tabla_ordenada_por('medicine', 'drug', 'desc'); 
*/
DELIMITER $$_stored_precedure_$$
CREATE PROCEDURE `obtener_tabla_ordenada_por` (IN tableName VARCHAR(30) , IN orderBy VARCHAR(30) , IN sortBy VARCHAR(4))
BEGIN	
	IF tableName = '' THEN /* SI NOMBRE DE TABLA VACIO, RETORNAR UN MENSAJE QUE DIGA QUE NECESITAMOS EL NOMBRE */    
		SELECT "Nececitamos al menos el nombre de la tabla!";     
	ELSE
		IF orderBy = '' THEN /* SI VIENE NOMBRE DE TABLA, SIN CAMPOS DE ORDEN, SIMPLEMENTE HACER EL SELECT  */
			SET @queryToExc = CONCAT("SELECT * FROM ", tableName );		
		ELSEIF orderBy <> '' THEN /* SI VIENE NOMBRE DE TABLA, CON CAMPOS DE ORDEN, HACER EL SELECT ORDER BY  */
			SET @queryToExc = CONCAT("SELECT * FROM ", tableName , " ORDER BY `", orderBy , "` ", sortBy);
            SELECT @queryToExc;
		END IF;       
        PREPARE executableQuery FROM @queryToExc;
        EXECUTE executableQuery;
        DEALLOCATE PREPARE executableQuery;
	END IF;      
END $$_stored_precedure_$$
DELIMITER ;

/*
Este Stored procedure es para eliminar aquellos owners que no tengan ninguna mascota registrada a su nombre. Ademas, elimina el usuario relacionado al owner.
Este procedimiento esta pensado para hacer eventuales limpiezas de las tablas user y owner.
	call my_pets.eliminar_owners_sin_mascotas();
*/
DELIMITER $$_stored_precedure_$$
CREATE PROCEDURE `eliminar_owners_sin_mascotas`()
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	SET @owners_name_to_delete = (SELECT GROUP_CONCAT(CONCAT(owner.name , " ", owner.last_name) SEPARATOR ", ") FROM owner
									WHERE owner.id_owner NOT IN (SELECT id_owner FROM pet));	
    SET @owners_id_to_delete = (SELECT GROUP_CONCAT(owner.id_owner) FROM owner
									WHERE owner.id_owner NOT IN (SELECT id_owner FROM pet));         
    SET @users_id_to_delete = (SELECT GROUP_CONCAT(owner.id_user) FROM owner
									WHERE owner.id_owner NOT IN (SELECT id_owner FROM pet));          
                                
	IF @owners_name_to_delete IS NULL THEN
		SELECT "Tabla ya esta limpia, previamente se borraron los registros.";
	ELSE 
		DELETE FROM owner 
        WHERE find_in_set(id_owner , @owners_id_to_delete);                
		 
        DELETE FROM user
        WHERE find_in_set(id_user , @users_id_to_delete);
        
        SELECT @owners_name_to_delete "Dueños eliminados";        
    END IF;
	SET SQL_SAFE_UPDATES = 1;
END $$_stored_precedure_$$
DELIMITER ;
