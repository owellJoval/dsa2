#!/bin/bash
# Kafka topics setup
docker exec kafka kafka-topics --create --topic logistics-topic --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
docker exec kafka kafka-topics --create --topic standard-delivery --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
docker exec kafka kafka-topics --create --topic express-delivery --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
docker exec kafka kafka-topics --create --topic international-delivery --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
