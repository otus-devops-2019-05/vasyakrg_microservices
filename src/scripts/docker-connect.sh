#!/bin/bash

docker-machine create --driver google --google-address docker1.aits.life --google-username appuser --google-zone "us-west1-b" --google-use-existing stage-docker1
eval $(docker-machine env stage-docker1)
