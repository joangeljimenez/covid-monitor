
CREATE SCHEMA covid;

DROP TABLE IF EXISTS vaccine;
CREATE TABLE vaccine (
    id SERIAL PRIMARY KEY,
    fecha_aplicacion DATE,
    orden_dosis VARCHAR(2) NOT NULL,  
    provincia VARCHAR(22) NOT NULL,
    sexo VARCHAR(2) NOT NULL, 
    cantidad_vacunas INT NOT NULL, 
);




