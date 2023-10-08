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

/*El otro S.P. qué crearás, puede (1: insertar registros en una tabla de tu proyecto. 2: eliminar algún registro específico de una tabla de tu proyecto.)*/

