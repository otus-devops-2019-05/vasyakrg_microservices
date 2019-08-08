#!/bin/bash

docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
docker run -d --network=reddit --network-alias=myposts vasyakrg/post:1.0
docker run -d --network=reddit --network-alias=mycomments vasyakrg/comment:1.0
docker run -d --network=reddit -p 9292:9292  --env POST_SERVICE_HOST='myposts' --env COMMENT_SERVICE_HOST='mycomments' vasyakrg/ui:3.0
