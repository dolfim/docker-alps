# ALPS Project
http://alps.comp-phys.org

* Tags: 2.2b4
* Volumes: /output
* [Dockerfile-trusty64](v2.2.b4/ubuntu/Dockerfile)
* Image at [https://hub.docker.com/r/dolfim/alps]()

It can run the ALPS applications as `docker run alps APP`.

Input and output files should be provided in the /output volume, such that a usual simulation workflow looks like:
```sh
docker run -v `pwd`:/output alps parameters2xml parms
docker run -v `pwd`:/output alps spinmc --write-xml parms.in.xml
```