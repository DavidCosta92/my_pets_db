-- Obtener cantidad de mascotas por dueño, ordenar por cantidad de mascotas y solo mostrar aquellos que tengan mas de 1.
CREATE OR REPLACE VIEW dueños_con_mas_mascotas AS
(SELECT owner.id_owner "Dueño", owner.name "Nombre", COUNT(owner.id_owner)  "Cant. de Mascotas" FROM pet
JOIN owner ON pet.id_owner =  owner.id_owner
GROUP BY (owner.id_owner)
HAVING COUNT(owner.id_owner) > 1
ORDER BY COUNT(owner.id_owner) DESC ) ;

SELECT * FROM dueños_con_mas_mascotas;

-- Obtener dueños que NO registren mascotas para ofrecer mascotas en adopcion
CREATE OR REPLACE VIEW dueños_sin_mascotas_para_ofrecer_adopcion AS (
	SELECT  owner.id_owner id, owner.name "Nombre", owner.phone "Tel contacto" FROM owner
	WHERE owner.id_owner NOT IN (
		SELECT owner.id_owner FROM pet
		JOIN owner ON pet.id_owner =  owner.id_owner
		GROUP BY (owner.id_owner)
		ORDER BY COUNT(owner.id_owner) DESC 
		)
);
SELECT * FROM dueños_sin_mascotas_para_ofrecer_adopcion;

-- Obtener las mascotas Id, nombre, especie y cantidad de atenciones recibidas
CREATE OR REPLACE VIEW mascotas_segun_cantidad_atenciones_nombre_especie AS (
	SELECT pet.id_pet "Mascota", pet.name "Nombre",  pet.species "Especie", (SELECT COUNT(*) FROM medical_history 
																				JOIN appointment ON appointment.id_medical_history = medical_history.id_medical_history
																				WHERE medical_history.id_pet = pet.id_pet
																				) "Cant visitas al vet"                                                                             
	FROM pet
);
SELECT * FROM mascotas_segun_cantidad_atenciones_nombre_especie;

-- Obtener las cantidades de medicinas (Un) para su reposicion
CREATE OR REPLACE VIEW drogas_usadas_cantidad_para_reposicion AS (
	SELECT medicine.id_medicine "Medicina", 
			medicine.name "Nombre comercial" , 
			medicine.drug "Droga" , 
			(SELECT COUNT(*)
			FROM treatment_medicine 
			GROUP BY id_medicine
			HAVING treatment_medicine.id_medicine = medicine.id_medicine )  "Unidades usadas"
	FROM medicine
);
SELECT * FROM drogas_usadas_cantidad_para_reposicion;

-- Obtener datos contacto de veterinarios con experiencia en cirugias y que puedan hacer urgencias
CREATE OR REPLACE VIEW cirujanos_que_hacen_emergencias AS (
	SELECT vet.name "Nombre", vet.last_name "Apellido", vet.phone "Tel contacto" FROM surgery 
	JOIN vet ON surgery.id_vet = vet.id_vet
	WHERE vet.emergency = 1
);
SELECT * FROM cirujanos_que_hacen_emergencias;

