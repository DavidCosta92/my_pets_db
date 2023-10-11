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
  `medicine` VARCHAR(50),
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
-- LOG TABLES
CREATE TABLE IF NOT EXISTS log_appointment (
	id_log_app INT PRIMARY KEY AUTO_INCREMENT,
    real_user VARCHAR(50),
    real_date DATE,
    real_time TIME,
    type_op VARCHAR(50),
    id_appointment INT,    
    id_vet INT,
    id_pet INT,
    app_date DATETIME,
    diagnosis TEXT
);
CREATE TABLE IF NOT EXISTS log_medicine (
	id_log_medicine INT PRIMARY KEY AUTO_INCREMENT,
    id_medicine INT,
    id_pet INT,
    real_user VARCHAR(50),
    real_date DATE,
    real_time TIME,
    type_op VARCHAR(50)
);
