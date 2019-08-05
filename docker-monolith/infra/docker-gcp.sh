#!/bin/bash

GOOGLE_PROJECT=docker-123456

docker-machine create --driver google \
 --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
 --google-machine-type n1-standard-1 \
 --google-zone europe-west1-b \
 --google-project $GOOGLE_PROJECT \
 docker-host

sleep 10
eval $(docker-machine env docker-host)
