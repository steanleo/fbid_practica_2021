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
docker network create --subnet=172.20.0.0/24 fbid_net
```
Iniciar en segundo plano cada uno de los contenedores
```
docker run -d --network fbid_net --ip 172.20.0.2 --name mongoServer mongo:latest
docker run -d --network fbid_net --ip 172.20.0.3 --name kafkaServer kafka
docker run -d --network fbid_net --ip 172.20.0.4 --name sparkServer spark
docker run -d --network fbid_net --ip 172.20.0.5 --name webServer flask
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
http://172.20.0.5:5000/flights/delays/predict_kafka
