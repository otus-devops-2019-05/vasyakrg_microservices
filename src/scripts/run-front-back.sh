#!/bin/bash

docker run -d --network=back_net --network-alias=post_db --network-alias=comment_db --name mongo_db mongo:latest
docker run -d --network=back_net --name post vasyakrg/post:1.0
docker run -d --network=back_net --name comment vasyakrg/comment:1.0

docker run -d --network=front_net -p 9292:9292 --name ui vasyakrg/ui:1.0

docker network connect front_net post
docker network connect front_net comment
