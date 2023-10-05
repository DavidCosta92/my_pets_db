CREATE SCHEMA IF NOT EXISTS my_pets;
USE my_pets;

CREATE TABLE IF NOT EXISTS `user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(50) NOT NULL UNIQUE,
  `password` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_user`)
  );
CREATE TABLE IF NOT EXISTS `owner` (
  `id_owner` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `last_name` VARCHAR(30) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_owner`),
  CONSTRAINT `id_user_owner`
	FOREIGN KEY (`id_user`) 
    REFERENCES `user` (`id_user`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
  );
CREATE TABLE IF NOT EXISTS `vet` (
  `id_vet` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `last_name` VARCHAR(30) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `emergency` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_vet`),
  CONSTRAINT `id_user_vet`
	FOREIGN KEY (`id_user`) 
    REFERENCES `user` (`id_user`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `pet` (
  `id_pet` INT NOT NULL AUTO_INCREMENT,
  `id_owner` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `species` VARCHAR(30) NOT NULL,
  `description` TEXT NOT NULL,
  `birthday` DATE NOT NULL,
  `breed` VARCHAR(100),
  PRIMARY KEY (`id_pet`),
  CONSTRAINT `id_owner`
	FOREIGN KEY (`id_owner`) 
    REFERENCES `owner` (`id_owner`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS `medical_history` (
  `id_medical_history` INT NOT NULL AUTO_INCREMENT,
  `id_pet` INT NOT NULL,
  `weight` FLOAT NOT NULL,
  `medical_summary` TEXT NOT NULL,
  PRIMARY KEY (`id_medical_history`),
  CONSTRAINT `id_pet_medical_history`
	FOREIGN KEY (`id_pet`) 
    REFERENCES `pet` (`id_pet`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);
  
CREATE TABLE IF NOT EXISTS `appointment` (
  `id_appointment` INT NOT NULL AUTO_INCREMENT,
  `id_vet` INT NOT NULL,
  `id_medical_history` INT NOT NULL,
  `date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `diagnosis` TEXT,
PRIMARY KEY (`id_appointment`),
CONSTRAINT `id_appointment_vet`
	FOREIGN KEY (`id_vet`) 
    REFERENCES `vet` (`id_vet`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
CONSTRAINT `id_appointment_id_medical_history`
	FOREIGN KEY (`id_medical_history`) 
    REFERENCES `medical_history` (`id_medical_history`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
  );

CREATE TABLE IF NOT EXISTS `surgery` (
  `id_surgery` INT NOT NULL AUTO_INCREMENT,
  `id_vet` INT NOT NULL,
  `id_medical_history` INT NOT NULL,
  `date` DATETIME,
  `diagnosis` TEXT,
PRIMARY KEY (`id_surgery`),
CONSTRAINT `id_surgery_vet`
	FOREIGN KEY (`id_vet`) 
    REFERENCES `vet` (`id_vet`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
CONSTRAINT `id_surgery_id_medical_history`
	FOREIGN KEY (`id_medical_history`) 
    REFERENCES `medical_history` (`id_medical_history`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
  );

CREATE TABLE IF NOT EXISTS `treatment` (
  `id_treatment` INT NOT NULL AUTO_INCREMENT,
  `id_appointment` INT NOT NULL,
  `date` DATE,
  `name` VARCHAR(50),
  `end_date` DATETIME,
  `description` TEXT,
PRIMARY KEY (`id_treatment`),
CONSTRAINT `id_treatment_appointment`
	FOREIGN KEY (`id_appointment`) 
    REFERENCES `appointment` (`id_appointment`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
  );
  

    
CREATE TABLE IF NOT EXISTS `medicine` (
  `id_medicine` INT NOT NULL AUTO_INCREMENT,  
  `name` VARCHAR(30),
  `drug` VARCHAR(50),
  `administration` VARCHAR(30),
  `type` VARCHAR(30),
  `periodic` INT DEFAULT 0,
PRIMARY KEY (`id_medicine`)
);
CREATE TABLE IF NOT EXISTS `treatment_medicine` (
  `id_treatment_medicine` INT NOT NULL AUTO_INCREMENT,  
  `id_treatment` INT NOT NULL,
  `id_medicine` INT NOT NULL,
PRIMARY KEY (`id_treatment_medicine`),
CONSTRAINT `id_treatment_medicine_id_treatment`
	FOREIGN KEY (`id_treatment`) 
    REFERENCES `treatment` (`id_treatment`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
CONSTRAINT `id_treatment_medicine_id_medicine`
	FOREIGN KEY (`id_medicine`) 
    REFERENCES `medicine` (`id_medicine`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);
-- INSERTS USER
INSERT INTO `my_pets`.`user` (`email`, `password`) VALUES 
('magdalena.aviles@hotmail.com' , 'password' ),
('xrodarte@gmail.com', 'password' ),
('krobles@yahoo.com', 'password' ),
('mascarenas.montserrat@gmail.com', 'password' ),
('longoria@tovar.org', 'password' ),
('emmanuel77@hotmail.com', 'password' ),
('santino.gaytan@vargas.com', 'password' ),
('corona.rebeca@yahoo.com', 'password' ),
('ian89@vela.com', 'password' ),
('oliva.delarosa@guajardo.info', 'password' ),
('toro.juansebastian@collado.info', 'password' ),
('micaela19@quezada.com', 'password' ),
('vcamarillo@gmail.com', 'password' ),
('adriana97@pantoja.org', 'password' ),
('wflores@gmail.com', 'password' ),
('jrubio@acosta.com', 'password' ),
('juansebastian.banda@melgar.com', 'password' ),
('jmendoza@garcia.net', 'password' ),
('jmendoz@garcia.net', 'password' ),
('ybravo@gmail.com', 'password' );


-- INSERTS VET
INSERT INTO `my_pets`.`vet` (id_user, name, last_name, phone, address, emergency) 
VALUES (1 ,'Matías' , 'Saavedra' , '6443797' , 'Ponce  4', 1),
(2 ,'Josué' , 'Feliciano' , '(474)441-4256' , 'Ibarra  7543 1 A', 1),
(3 ,'Christopher' , 'Munguía' , '(468)456-7495' , 'Orta  3'),
(4 ,'Clara' , 'Barraza' , '(33)5624-6260' , 'Julián  5 1 5'),
(5 ,'Jesús' , 'Velásquez' , '(0155)49-1607' , 'Amanda  84181 4 E', 1),
(6 ,'Luciana' , 'Alicea' , '(642)432-8165' , 'María José  51816'),
(7 ,'Elena' , 'Cortés' , '201-415-9834' , 'María  875'),
(8 ,'Jacobo' , 'Ulibarri' , '(1540)40-3738' , 'Andrés  74021 1 A', 1),
(9 ,'Valentina' , 'Díaz' , '(490)459-1341' , 'Juan Diego  44 60 D'),
(10 ,'Micaela' , 'Flores' , '+68666346' , 'Alexander  9567', 1);

-- INSERTS OWNER
INSERT INTO `my_pets`.`owner` (id_user, name, last_name, phone, address) 
VALUES (11 ,'Matías' , 'Saavedra' , '6443797' , 'Ponce  4'),
(12 ,'Josué' , 'Feliciano' , '(474)441-4256' , 'Ibarra  7543 1 A'),
(13 ,'Christopher' , 'Munguía' , '(468)456-7495' , 'Orta  3'),
(14 ,'Clara' , 'Barraza' , '(33)5624-6260' , 'Julián  5 1 5'),
(15 ,'Jesús' , 'Velásquez' , '(0155)49-1607' , 'Amanda  84181 4 E'),
(16 ,'Luciana' , 'Alicea' , '(642)432-8165' , 'María José  51816'),
(17 ,'Elena' , 'Cortés' , '201-415-9834' , 'María  875'),
(18 ,'Jacobo' , 'Ulibarri' , '(1540)40-3738' , 'Andrés  74021 1 A'),
(19 ,'Valentina' , 'Díaz' , '(490)459-1341' , 'Juan Diego  44 60 D'),
(20 ,'Micaela' , 'Flores' , '+68666346' , 'Alexander  9567');

-- INSERTS PET
INSERT INTO `my_pets`.`pet` (id_owner, name, species, description, birthday, breed) 
VALUES (1,'Salomé', 'perro', 'marron y negro' , '2017-07-10', 'beagle'),
(2,'Franco', 'perro', 'negro' , '1979-05-30', 'grandanes'),
(4,'Sophie', 'gato', 'beige' , '2022-11-20', 'desconocido'),
(2,'Ashley', 'gato', 'blanco' , '1995-02-24', 'desconocido'),
(5,'Christian', 'perro', 'manchas blancas y negras' , '2009-08-20', 'dalmata'),
(6,'Magdalena', 'gato', 'negro' , '1970-12-21', 'desconocido'),
(7,'Ariana', 'pez', 'naranja' , '1995-09-13', 'desconocido'),
(8,'Andrés', 'ave', 'amarillo' , '2005-08-04', 'catita'),
(9,'Alexander', 'ave', 'verde' , '2007-08-2', 'tucan');

-- INSERTS MEDICAL HISTORY
INSERT INTO `my_pets`.`medical_history` (id_pet , weight , medical_summary)
VALUES (1 , 10 , 'mascota que consulta por apendicitis') ,
(2 , 4.15 , 'mascota que consulta por dolor de pata derecha') ,
(3 , 7.25 , 'mascota que consulta por accidente vial') ,
(4 , 3.9 , 'mascota que consulta por herida cortante en muslo') ,
(5 , 15.6 , 'mascota que consulta por fiebre') ,
(6 , 9.2 , 'mascota que consulta por apendicitis');

-- INSERTS APPOINTMENT
INSERT INTO `my_pets`.`appointment` (id_vet, id_medical_history, date, diagnosis) 
VALUES (1 , 1, '2021-11-20 08:10:00', 'dolor abd'),
(2 , 1, '2021-12-25 09:20:00', 'post operatorio'),
(3 , 1, '2022-04-10 09:30:00', 'curación'),
(3 , 2, '2022-05-20 10:45:00', 'dolor abdomen'),
(2 , 2, '2022-06-02 10:57:00', 'gastritis'),
(4 , 1, '2023-01-20 12:38:00', 'dolor de pierna'),
(2 , 3, '2023-03-15 12:40:00', 'herida cortante'),
(1 , 4, '2023-05-07 12:55:00', 'alopecia');

-- INSERTS SURGERY
INSERT INTO `my_pets`.`surgery` (id_vet, id_medical_history, date, diagnosis) 
VALUES (1 , 1, '2021-11-20 12:55:00', 'extirpacion testicular'),
(2 , 3, '2022-12-25 10:55:00', 'castramiento'),
(2 , 4, '2022-12-25 10:55:00', 'castramiento'),
(3 , 5, '2022-12-25 10:55:00', 'castramiento'),
(3 , 6, '2022-12-25 10:55:00', 'castramiento'),
(1 , 3, '2022-12-25 10:55:00', 'castramiento'),
(4 , 4, '2022-12-25 10:55:00', 'castramiento'),
(7 , 5, '2022-12-25 10:55:00', 'castramiento'),
(2 , 6, '2022-12-25 10:55:00', 'castramiento'),
(9 , 5, '2023-04-10 12:55:00', 'extirpacion testicular');

-- INSERTS TREATMENT
INSERT INTO `my_pets`.`treatment` (id_appointment, date, name, end_date, description) 
VALUES (1, '2021-11-20','antibióticos', '2022-01-20', 'tratamiento de una gripe'),
(1, '2021-12-25','antiácido', '2021-12-25','paliativo para tratar ulcera'),
(3, '2022-04-10','tratamiento del dolor','2022-10-10', 'post fractura'),
(3, '2022-05-20','tratamiento dolor', '2024-05-20', 'tratamiento paliativo'),
(5, '2022-06-02','tratamiento gastritis', '2022-10-02', 'gastritis');

-- INSERTS MEDICINE
INSERT INTO `my_pets`.`medicine` (name, drug, administration, type, periodic) 
VALUES 
('honguil', 'azitromicina', 'pastillas','antibiotico', true),
('amoxidal', 'amoxilina', 'pastillas','antibiotico', false),
('gastrix', 'pantoprazol', 'pastillas','protector gastrico', true),
('stop aler', 'pseudoefedrina', 'insyectable','antialergico', false);

-- INSERTS TREATMENT_MEDICINE
INSERT INTO `my_pets`.`treatment_medicine` (id_treatment , id_medicine)
VALUES (1,2),
(1,3),
(1,1),
(2,2),
(2,3),
(2,1);

