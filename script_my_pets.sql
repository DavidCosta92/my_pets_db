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
  `id_user_owner` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `last_name` VARCHAR(30) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_owner`),
  CONSTRAINT `id_user_owner`
	FOREIGN KEY (`id_user_owner`) 
    REFERENCES `user` (`id_user`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
  );
  
CREATE TABLE IF NOT EXISTS `vet` (
  `id_vet` INT NOT NULL AUTO_INCREMENT,
  `id_user_vet` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `last_name` VARCHAR(30) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `emergency` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_vet`),
  CONSTRAINT `id_user_vet`
	FOREIGN KEY (`id_user_vet`) 
    REFERENCES `user` (`id_user`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
  );
  

