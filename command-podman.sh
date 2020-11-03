#!/bin/sh

podman run -dt –env-file=env.grafana -p 3000:3000 –name=grafana –restart=unless-stopped -v ./grafana:/var/lib/grafana --pod new:apps grafana/grafana:latest
podman run -dt –env-file=env.influxdb -p 8083:8083 8086:8086 8090:8090 –name=influxdb –restart=unless-stopped -v ./influxdb:/var/lib/influxdb --pod new:apps influxdb
