#!/bin/bash

docker pull mongo:latest
docker build -t vasyakrg/post:1.0 ./post-py
docker build -t vasyakrg/comment:1.0 ./comment
docker build -t vasyakrg/ui:1.0 ./ui

# docker network create reddit
