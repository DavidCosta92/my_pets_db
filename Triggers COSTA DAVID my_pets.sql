-- TRIGGER a dispararse en los inserts y updates de la citas medicas
-- Creacion table log
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
-- INSERT => Guarda datos de creacion como fecha y usuario, y ademas copia el estado inicial del registro, LUEGO de ingresar registro
CREATE DEFINER=`root`@`localhost` TRIGGER `log_appointment_insert`
AFTER INSERT ON `appointment`
FOR EACH ROW
INSERT INTO log_appointment (real_user , real_date , real_time , type_op, id_appointment, id_vet , id_pet , app_date , diagnosis)
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
);

-- UPDATE => Guarda datos de modificacion (fecha y usuario), y copia el estado del registro ANTES de ser cambiado
CREATE DEFINER=`root`@`localhost` TRIGGER `log_appointment_update`
BEFORE UPDATE ON `appointment`
FOR EACH ROW
INSERT INTO log_appointment (real_user , real_date , real_time , type_op, id_appointment, id_vet , id_pet , app_date , diagnosis)
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
);


-- TRIGGER a dispararse en los inserts y updates de la tabla medicine
-- Creacion table log
CREATE TABLE IF NOT EXISTS log_medicine (
	id_log_medicine INT PRIMARY KEY AUTO_INCREMENT,
    real_user VARCHAR(50),
    real_date DATE,
    real_time TIME,
    type_op VARCHAR(50),    
    id_medicine INT,
    name VARCHAR(30),
	drug VARCHAR(50),
	administration VARCHAR(30),
	type VARCHAR(30),
	periodic INT 
); 
-- INSERT => Guarda datos de creacion como fecha y usuario, y ademas copia el estado inicial del registro, LUEGO de ingresar registro
CREATE DEFINER=`root`@`localhost` TRIGGER `log_medicine_insert`
AFTER INSERT ON `medicine`
FOR EACH ROW
INSERT INTO log_medicine (real_user , real_date , real_time , type_op, id_medicine , name, drug, administration, type , periodic) 
VALUES ( 
	session_user() , 
	current_date() , 
	current_time() , 
	"INSERT" ,
	NEW.id_medicine ,
	NEW.name , 
	NEW.drug ,
	NEW.administration , 
	NEW.type ,
	NEW.periodic 
);

-- UPDATE => Guarda datos de modificacion (fecha y usuario), y copia el estado del registro ANTES de ser cambiado
CREATE DEFINER=`root`@`localhost` TRIGGER `log_medicine_update`
BEFORE UPDATE ON `medicine`
FOR EACH ROW
INSERT INTO log_medicine (real_user , real_date , real_time , type_op, id_medicine , name, drug, administration, type , periodic) 
VALUES ( 
	session_user() , 
	current_date() , 
	current_time() , 
	"UPDATE" ,
	OLD.id_medicine ,
	OLD.name , 
	OLD.drug ,
	OLD.administration , 
	OLD.type ,
	OLD.periodic 
);

-- DELETE => Guarda datos de operacion (fecha y usuario), y guarda una copia del registro antes de borrarlo
CREATE DEFINER=`root`@`localhost` TRIGGER `log_medicine_delete`
BEFORE DELETE ON `medicine`
FOR EACH ROW
INSERT INTO log_medicine (real_user , real_date , real_time , type_op, id_medicine , name, drug, administration, type , periodic) 
VALUES ( 
	session_user() , 
	current_date() , 
	current_time() , 
	"DELETE" ,
	OLD.id_medicine ,
	OLD.name , 
	OLD.drug ,
	OLD.administration , 
	OLD.type ,
	OLD.periodic 
);