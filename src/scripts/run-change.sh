#!/bin/bash

#docker network create reddit
docker run -d --network=reddit --network-alias=mypost_db --network-alias=mycomment_db mongo:latest
docker run -d --network=reddit --network-alias=myposts --env POST_DATABASE_HOST='mypost_db' vasyakrg/post:1.0
docker run -d --network=reddit --network-alias=mycomments --env COMMENT_DATABASE_HOST='mycomment_db' vasyakrg/comment:1.0
docker run -d --network=reddit -p 9292:9292 --env POST_SERVICE_HOST='myposts' --env COMMENT_SERVICE_HOST='mycomments' vasyakrg/ui:3.0
