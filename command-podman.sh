#!/bin/sh

#FILE_INFLUX=./influxdb
#FILE_GRAFANA=./grafana

#if [ ! -d "$FILE_INFLUX" ];then
#    mkdir  "$FILE_INFLUX"
#fi   

#if [ ! -d "$FILE_GRAFANA" ];then
#    mkdir "$FILE_GRAFANA"
#fi   

podman pod exists appweb
if [ $? -eq 1 ]
then
    podman pod create --name appweb -p 3000:3000 --hostname '0.0.0.0'
fi

podman pod exists appbd
if [ $? -eq 1 ]
then
    podman pod create --name appbd  -p 8086:8086 --hostname '0.0.0.0'
fi



podman run -dt --env-file='.grafana.env'  --name=grafana --restart=always  --pod appweb grafana/grafana:latest

podman run -dt --env-file='.influxdb.env'  --name=influxdb --restart=always  -v ./influxdb:/var/lib/influxdb --pod appbd influxdb
