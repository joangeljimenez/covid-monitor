# covid-monitor

Es un ambiente de docker que permite obtener la evolución y el estado del proceso de vacunación por covid-19 en Argentina con datos del [Sistema Integrado de Información Sanitaria Argentino.](https://sisa.msal.gov.ar/sisa/)


**Para probar el ambiente seguir los siguientes pasos** 


### Instalación e inicio 
```shell
git clone https://github.com/joangeljimenez/covid-monitor.git 
cd covid-monitor

./control-env.sh start
```
### Ejecución 

1. Para obtener el token e ingresar a Jupyter desde el [localhost:8888](http://localhost:8888/)
 ```shell
./control-env.sh token 
```


2. Correr la notebook **covid_vaccine_data** 



3. Luego de ejecutar la notebook iniciar superset y acceder al dashboard 
```shell
./control-env.sh superset-init 
```

4. Conectar superset con la base de datos, ingresando en [superset](http://localhost:8088/), seleccionar la opción '+ Database', seleccionar SQLite y agregar los campos necesarios: 
      - SQLAlquemy URI: postgresql://covid:c0v1d@postgres/covid  



5. Agregar la conexión del dataset en superset en la opción **Data>Datasets**, luego seleccionar la tabla **vaccine**. 



6. Importar el dashboard a superset 
  ```shell
./control-env.sh superset-import
```

## Finalización 

Terminar los ambientes de docker 
```shell
./control-env.sh stop 
```

## Posibles errores 

- Los datos no se guardan desde la notebook en PostgreSQL por no encontrar el driver. En ese caso enviar al master de spark desde la consola. 

```shell
docker exec -it master bash
pyspark \
  --master 'spark://master:7077' \
  --jars code/app/postgresql-42.1.4.jar
```

- La tabla no se crea en PostgreSQL en el momento de levantar el ambiente. Para este error, chequear y ejecutar desde la consola los siguientes comandos. 
```shell
#Para ingresar a psql 
docker exec -it postgres psql -U covid covid 

#Para crear el esquema y la tabla 

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

#Para chequear las tablas disponibles 
\dt 

#Para volver a la terminal 
\q 

```
- Los comandos de ./control-env.sh no funcionan. Es necesario otorgar permisos de ejecución desde la consola. 
```shell
chmod u+x ./control-env.sh 
```

