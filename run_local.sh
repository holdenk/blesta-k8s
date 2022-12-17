#!/bin/bash
(docker stop blesta && docker rm blesta) || echo "k"
docker pull holdenk/blesta:latest
docker run -d --name blesta -e TZ=UTC -p 8080:80  holdenk/blesta:latest
docker exec -it blesta /bin/bash
