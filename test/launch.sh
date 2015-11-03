#!/bin/sh

## Launch three machines
## - shared volume with input/output
## - shared volume with ssh keys
docker run -d -P -h node1 --name test_alps_mpi_1 -v `pwd`:/output -v `pwd`/ssh:/root/.ssh dolfim/alps:2.2b4-mpi
docker run -d -P -h node2 --name test_alps_mpi_2 -v `pwd`:/output -v `pwd`/ssh:/root/.ssh dolfim/alps:2.2b4-mpi
docker run -d -P -h node3 --name test_alps_mpi_3 -v `pwd`:/output -v `pwd`/ssh:/root/.ssh dolfim/alps:2.2b4-mpi

## Obtain ip of the machines we just launched
ips=`docker inspect -f '{{ .NetworkSettings.IPAddress }}' test_alps_mpi_1 test_alps_mpi_2 test_alps_mpi_3`
ips=`echo $ips | sed 's/ /,/g'`
echo "Started machines with ip: $ips"

## Generate input files
docker exec test_alps_mpi_1 parameter2xml -f parm1a

## Run on two core of each container
docker exec test_alps_mpi_1 mpirun -host $ips -np 6 spinmc --mpi --write-xml parm1a.in.xml

## Stop and cleanup
docker stop test_alps_mpi_1 test_alps_mpi_2 test_alps_mpi_3
docker rm test_alps_mpi_1 test_alps_mpi_2 test_alps_mpi_3
