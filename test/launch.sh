#!/bin/sh

docker run -d -P -h node1 --name a1 -v `pwd`:/output -v `pwd`/ssh:/root/.ssh dolfim/alps:2.2b4-mpi
docker run -d -P -h node2 --name a2 -v `pwd`:/output -v `pwd`/ssh:/root/.ssh dolfim/alps:2.2b4-mpi
docker run -d -P -h node3 --name a3 -v `pwd`:/output -v `pwd`/ssh:/root/.ssh dolfim/alps:2.2b4-mpi

echo "Started machines with ip:"
docker inspect -f '{{ .NetworkSettings.IPAddress }}' a1 a2 a3
#docker inspect -f '{{ .NetworkSettings.IPAddress }}' dolfim/alps:2.2b4-mpi
