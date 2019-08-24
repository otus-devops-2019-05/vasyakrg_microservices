#!/bin/bash

docker build -t vasyakrg/alertmanager ./alertmanager
docker build -t vasyakrg/blackbox-exporter ./blackbox-exporter
docker build -t vasyakrg/prometheus ./prometheus
