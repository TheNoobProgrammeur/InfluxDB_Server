#!/bin/sh

podman pod exists apps
if [ $0 -eq 1 ];
then
    podman pod create --name apps -p 3000:3000 -p 8086:8086
fi    
podman run -dt –env-file=env.grafana  –name=grafana –restart=always -v ./grafana:/var/lib/grafana --pod apps grafana/grafana:latest
podman run -dt –env-file=env.influxdb  –name=influxdb –restart=always  -v ./influxdb:/var/lib/influxdb --pod apps influxdb
