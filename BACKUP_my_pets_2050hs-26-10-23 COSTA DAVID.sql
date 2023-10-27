-- **********************************************************************************
-- **********************************************************************************

-- Se hace backup de todas las tablas
-- con execpcion de las tablas 'medicine' y 'log_medicine'
-- Esto es porque asumimos que las medicinas y sus caracteristicas no cambian constantemente, sino de forma mas esporadica

-- **********************************************************************************
-- **********************************************************************************

-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: my_pets
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,1,1,'2021-11-20 08:10:00','dolor abd'),(2,2,1,'2021-12-25 09:20:00','post operatorio'),(3,3,1,'2022-04-10 09:30:00','curación'),(4,3,2,'2022-05-20 10:45:00','dolor abdomen'),(5,2,2,'2022-06-02 10:57:00','gastritis'),(6,4,1,'2023-01-20 12:38:00','dolor de pierna'),(7,2,3,'2023-03-15 12:40:00','herida cortante'),(8,1,4,'2023-05-07 12:55:00','alopecia'),(9,1,1,'2023-10-01 03:33:00','CAMBIO DE NOM'),(10,3,1,'2023-10-11 10:00:00','UPDATEEEEE');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `log_appointment_insert` AFTER INSERT ON `appointment` FOR EACH ROW INSERT INTO log_appointment (real_user , real_date , real_time , type_op, id_appointment, id_vet , id_pet , app_date , diagnosis)
VALUES ( 
	session_user() , 
	current_date() , 
	current_time() , 
	"INSERT" ,
	NEW.id_appointment ,
	NEW.id_vet , 
	(SELECT id_pet FROM appointment JOIN medical_history ON  appointment.id_medical_history = NEW.id_medical_history LIMIT 1) ,
	NEW.date , 
	NEW.diagnosis
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `log_appointment_update` BEFORE UPDATE ON `appointment` FOR EACH ROW INSERT INTO log_appointment (real_user , real_date , real_time , type_op, id_appointment, id_vet , id_pet , app_date , diagnosis)
VALUES ( 
	session_user() , 
	current_date() , 
	current_time() , 
	"UPDATE" ,
	OLD.id_appointment ,
	OLD.id_vet , 
	(SELECT id_pet FROM appointment JOIN medical_history ON  appointment.id_medical_history = NEW.id_medical_history LIMIT 1) ,
	OLD.date , 
	OLD.diagnosis
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `log_appointment`
--

LOCK TABLES `log_appointment` WRITE;
/*!40000 ALTER TABLE `log_appointment` DISABLE KEYS */;
INSERT INTO `log_appointment` VALUES (1,'root@localhost','2023-10-11','10:45:03','INSERT',10,5,1,'2023-10-11 10:00:00','PRUEBA 2'),(2,'root@localhost','2023-10-11','10:46:46','INSERT',10,5,1,'2023-10-11 10:00:00','PRUEBA 2'),(3,'root@localhost','2023-10-11','13:53:30','UPDATE',10,3,1,'2023-10-11 10:00:00','UPDATEEEEE');
/*!40000 ALTER TABLE `log_appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `medical_history`
--

LOCK TABLES `medical_history` WRITE;
/*!40000 ALTER TABLE `medical_history` DISABLE KEYS */;
INSERT INTO `medical_history` VALUES (1,1,10,'mascota que consulta por apendicitis'),(2,2,4.15,'mascota que consulta por dolor de pata derecha'),(3,3,7.25,'mascota que consulta por accidente vial'),(4,4,3.9,'mascota que consulta por herida cortante en muslo'),(5,5,15.6,'mascota que consulta por fiebre'),(6,6,9.2,'mascota que consulta por apendicitis');
/*!40000 ALTER TABLE `medical_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `owner`
--

LOCK TABLES `owner` WRITE;
/*!40000 ALTER TABLE `owner` DISABLE KEYS */;
INSERT INTO `owner` VALUES (1,11,'Matías','Saavedra','6443797','Ponce  4'),(2,12,'Josué','Feliciano','(474)441-4256','Ibarra  7543 1 A'),(4,14,'Clara','Barraza','(33)5624-6260','Julián  5 1 5'),(5,15,'Jesús','Velásquez','(0155)49-1607','Amanda  84181 4 E'),(6,16,'Luciana','Alicea','(642)432-8165','María José  51816'),(7,17,'Elena','Cortés','201-415-9834','María  875'),(8,18,'Jacobo','Ulibarri','(1540)40-3738','Andrés  74021 1 A'),(9,19,'Valentina','Díaz','(490)459-1341','Juan Diego  44 60 D');
/*!40000 ALTER TABLE `owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pet`
--

LOCK TABLES `pet` WRITE;
/*!40000 ALTER TABLE `pet` DISABLE KEYS */;
INSERT INTO `pet` VALUES (1,1,'Salomé','perro','marron y negro','2017-07-10','beagle'),(2,2,'Franco','perro','negro','1979-05-30','grandanes'),(3,4,'Sophie','gato','beige','2022-11-20','desconocido'),(4,2,'Ashley','gato','blanco','1995-02-24','desconocido'),(5,5,'Christian','perro','manchas blancas y negras','2009-08-20','dalmata'),(6,6,'Magdalena','gato','negro','1970-12-21','desconocido'),(7,7,'Ariana','pez','naranja','1995-09-13','desconocido'),(8,8,'Andrés','ave','amarillo','2005-08-04','catita'),(9,9,'Alexander','ave','verde','2007-08-02','tucan'),(10,2,'otro nombre','D','D','2009-08-20','A');
/*!40000 ALTER TABLE `pet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `surgery`
--

LOCK TABLES `surgery` WRITE;
/*!40000 ALTER TABLE `surgery` DISABLE KEYS */;
INSERT INTO `surgery` VALUES (1,1,1,'2021-11-20 12:55:00','extirpacion testicular'),(2,2,2,'2022-12-25 10:55:00','castramiento'),(3,3,5,'2023-04-10 12:55:00','extirpacion testicular'),(4,1,1,'2021-11-20 12:55:00','extirpacion testicular'),(5,2,3,'2022-12-25 10:55:00','castramiento'),(6,2,4,'2022-12-25 10:55:00','castramiento'),(7,3,5,'2022-12-25 10:55:00','castramiento'),(8,3,6,'2022-12-25 10:55:00','castramiento'),(9,1,3,'2022-12-25 10:55:00','castramiento'),(10,4,4,'2022-12-25 10:55:00','castramiento'),(11,7,5,'2022-12-25 10:55:00','castramiento'),(12,2,6,'2022-12-25 10:55:00','castramiento'),(13,9,5,'2023-04-10 12:55:00','extirpacion testicular');
/*!40000 ALTER TABLE `surgery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `treatment`
--

LOCK TABLES `treatment` WRITE;
/*!40000 ALTER TABLE `treatment` DISABLE KEYS */;
INSERT INTO `treatment` VALUES (1,1,'2021-11-20','antibióticos','2022-01-20 00:00:00','tratamiento de una gripe'),(2,1,'2021-12-25','antiácido','2021-12-25 00:00:00','paliativo para tratar ulcera'),(3,3,'2022-04-10','tratamiento del dolor','2022-10-10 00:00:00','post fractura'),(4,3,'2022-05-20','tratamiento dolor','2024-05-20 00:00:00','tratamiento paliativo'),(5,5,'2022-06-02','tratamiento gastritis','2022-10-02 00:00:00','gastritis');
/*!40000 ALTER TABLE `treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `treatment_medicine`
--

LOCK TABLES `treatment_medicine` WRITE;
/*!40000 ALTER TABLE `treatment_medicine` DISABLE KEYS */;
INSERT INTO `treatment_medicine` VALUES (1,1,2),(2,1,3),(3,1,1),(4,2,2),(5,2,3),(6,2,1),(7,1,2),(8,1,3),(9,1,1),(10,2,2),(11,2,3),(12,2,1),(13,2,3),(14,2,1);
/*!40000 ALTER TABLE `treatment_medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'magdalena.aviles@hotmail.com','password'),(2,'xrodarte@gmail.com','password'),(3,'krobles@yahoo.com','password'),(4,'mascarenas.montserrat@gmail.com','password'),(5,'longoria@tovar.org','password'),(6,'emmanuel77@hotmail.com','password'),(7,'santino.gaytan@vargas.com','password'),(8,'corona.rebeca@yahoo.com','password'),(9,'ian89@vela.com','password'),(10,'oliva.delarosa@guajardo.info','password'),(11,'toro.juansebastian@collado.info','password'),(12,'micaela19@quezada.com','password'),(14,'adriana97@pantoja.org','password'),(15,'wflores@gmail.com','password'),(16,'jrubio@acosta.com','password'),(17,'juansebastian.banda@melgar.com','password'),(18,'jmendoza@garcia.net','password'),(19,'jmendoz@garcia.net','password'),(32,'1@gmail.com','password'),(33,'2@gmail.com','password'),(34,'3@gmail.com','password'),(35,'4@gmail.com','password'),(36,'5@gmail.com','password'),(37,'6@gmail.com','password'),(38,'7@gmail.com','password');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `vet`
--

LOCK TABLES `vet` WRITE;
/*!40000 ALTER TABLE `vet` DISABLE KEYS */;
INSERT INTO `vet` VALUES (1,1,'Matías','Saavedra','6443797','Ponce  4',1),(2,2,'Josué','Feliciano','(474)441-4256','Ibarra  7543 1 A',1),(3,3,'Christopher','Munguía','(468)456-7495','Orta  3',0),(4,4,'Clara','Barraza','(33)5624-6260','Julián  5 1 5',0),(5,5,'Jesús','Velásquez','(0155)49-1607','Amanda  84181 4 E',1),(6,6,'Luciana','Alicea','(642)432-8165','María José  51816',0),(7,7,'Elena','Cortés','201-415-9834','María  875',0),(8,8,'Jacobo','Ulibarri','(1540)40-3738','Andrés  74021 1 A',1),(9,9,'Valentina','Díaz','(490)459-1341','Juan Diego  44 60 D',0),(10,10,'Micaela','Flores','+68666346','Alexander  9567',1);
/*!40000 ALTER TABLE `vet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'my_pets'
--
/*!50003 DROP FUNCTION IF EXISTS `Buscar_cirujano_mas_experimentado_por_apellido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `Buscar_cirujano_mas_experimentado_por_apellido`(lastNameInput VARCHAR(30)) RETURNS varchar(200) CHARSET utf8mb4
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `validar_stock_por_id_medicine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `validar_stock_por_id_medicine`(id_medicine_input INT , stock_inicial_input INT , stock_actual_input INT) RETURNS int
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_owners_sin_mascotas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_owners_sin_mascotas`()
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	SET @owners_name_to_delete = (SELECT GROUP_CONCAT(CONCAT(owner.name , " ", owner.last_name) SEPARATOR ", ") FROM owner
									WHERE owner.id_owner NOT IN (SELECT id_owner FROM pet));	
    SET @owners_id_to_delete = (SELECT GROUP_CONCAT(owner.id_owner) FROM owner
									WHERE owner.id_owner NOT IN (SELECT id_owner FROM pet));         
    SET @users_id_to_delete = (SELECT GROUP_CONCAT(owner.id_user) FROM owner
									WHERE owner.id_owner NOT IN (SELECT id_owner FROM pet));          
                                
	IF @owners_name_to_delete IS NULL THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Tabla ya esta limpia, previamente se borraron los registros.";
	ELSE 
		DELETE FROM owner 
        WHERE find_in_set(id_owner , @owners_id_to_delete);                
		 
        DELETE FROM user
        WHERE find_in_set(id_user , @users_id_to_delete);
        
        SELECT @owners_name_to_delete "Dueños eliminados";        
    END IF;
	SET SQL_SAFE_UPDATES = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_tabla_ordenada_por` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_tabla_ordenada_por`(IN tableName VARCHAR(30) , IN orderBy VARCHAR(30) , IN sortBy VARCHAR(4))
BEGIN	
	IF tableName = '' THEN /* SI NOMBRE DE TABLA VACIO, RETORNAR UN MENSAJE QUE DIGA QUE NECESITAMOS EL NOMBRE */    
		-- SELECT "Nececitamos al menos el nombre de la tabla!";     
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Nececitamos al menos el nombre de la tabla!";
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_tabla_ordenada_poreeeeeeee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_tabla_ordenada_poreeeeeeee`(IN tableName VARCHAR(30) , IN orderBy VARCHAR(30) , IN sortBy VARCHAR(4))
BEGIN	
	IF tableName = '' THEN /* SI NOMBRE DE TABLA VACIO, RETORNAR UN MENSAJE QUE DIGA QUE NECESITAMOS EL NOMBRE */    
		-- SELECT "Nececitamos al menos el nombre de la tabla!";     
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Nececitamos al menos el nombre de la tabla!";
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-26 20:51:55
