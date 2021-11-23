#!/bin/bash
mongoimport --host 172.20.0.2 --port 27017 -d agile_data_science -c origin_dest_distances --file origin_dest_distances.jsonl
mongo 172.20.0.2:27017/agile_data_science --eval 'db.origin_dest_distances.createIndex({Origin: 1, Dest: 1})'
python3 train_spark_mllib_model.py .
spark-submit --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.0 flight_prediction_2.12-0.1.jar
