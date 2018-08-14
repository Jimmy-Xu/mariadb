#!/bin/bash

docker build --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy  -t hyperhq/mariadb-arm64v8:10.3-2 .
docker save -o hyperhq_mariadb-arm64v8_10.3-2.tar hyperhq/mariadb-arm64v8:10.3-2
(hyperctl images | grep hyperhq/mariadb-arm64v8:10.3-2) && hyperctl rmi -f hyperhq/mariadb-arm64v8:10.3-2
hyperctl load -i hyperhq_mariadb-arm64v8_10.3-2.tar
hyperctl images | grep "hyperhq/mariadb-arm64v8.*10.3-2"