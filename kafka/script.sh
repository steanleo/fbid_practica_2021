#!/bin/bash
#zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties &
systemctl enable zookeeper.service
systemctl enable kafka.service
systemctl start zookeeper.service
systemctl start kafka.service
kafka-topics.sh \
      --create \
      --bootstrap-server kafka:9092 \
      --replication-factor 1 \
      --partitions 1 \
      --topic flight_delay_classification_request
systemctl stop kafka.service
kafka-server-start.sh $KAFKA_HOME/config/server.properties 
