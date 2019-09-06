#!/bin/bash

docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db --name=mongodb mongo:latest
docker run -d --network=reddit --network-alias=post --name=post vasyakrg/post:logging
docker run -d --network=reddit --network-alias=comment --name=comment vasyakrg/comment:logging
docker run -d --network=reddit -p 9292:9292 --name=ui vasyakrg/ui:logging
