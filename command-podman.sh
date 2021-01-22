#!/bin/sh


podman pod exists appweb
if [ $? -eq 1 ]
then
    podman pod create --name appweb -p 8086:8086/udp  -p 3000:3000 -p 8083:8083 -p 8090:8090  --hostname '0.0.0.0'
fi


podman run -dt --env-file='.grafana.env'  --name=grafana --restart=always  --pod appweb grafana/grafana:latest

podman run -dt --env-file='.influxdb.env'  --name=influxdb --restart=always  --pod appweb influxdb
