#!/bin/sh


podman pod exists appweb
if [ $? -eq 1 ]
then
    podman pod create --name appweb -p 8086:8086 -p 3000:3000   --hostname '0.0.0.0'
fi




podman run -dt --env-file='.grafana.env'  --name=grafana --restart=always  --pod appweb grafana/grafana:latest

podman run -dt --env-file='.influxdb.env'  --name=influxdb --restart=always  -v ./influxdb:/var/lib/influxdb --pod appweb influxdb
