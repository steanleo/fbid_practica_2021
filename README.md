# fbid_practica_2021
Practica final de la materia FBID del Máster en Ingienería de Redes y Servicios Telemáticos, UPM, 2021

Asignar permisos de ejecución a docker.sock:
```
sudo chmod 666 /var/run/docker.sock
```
## Crear las imágenes docker para flask, kafka y spark
```
cd flask
docker build -t flask .
cd .. && cd kafka
docker build -t kafka .
cd .. && cd spark
docker build -t spark .
```
## Ejecutando con docker-engine
Crear la red a la que estarán conectados los contenedores
```
docker network create fbid_net
```
Iniciar en segundo plano cada uno de los contenedores
```
docker run -d --network fbid_net --network-alias mongo --name mongoServer mongo:latest
docker run -d --network fbid_net --network-alias kafka --name kafkaServer kafka
docker run -d --network fbid_net --network-alias spark --name sparkServer spark
docker run -d --network fbid_net --network-alias flask --name webServer flask
```
## Ejecutando con docker-compose
Si, previamente, se crearon los contenedores con docker-engine, se recomienda eliminarlos para evitar conflictos
```
docker stop mongoServer kafkaServer sparkServer webServer
docker system prune
```
Iniciar el servicio
```
docker-compose up -d
```
## Acceder al servidor web de predicción
Revisar la ip asignada al contenedor flask
```
docker inspect flask
```
Acceder al servicio
http://x.x.x.x:5000/flights/delays/predict_kafka
