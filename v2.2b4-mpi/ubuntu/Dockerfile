FROM ubuntu:trusty

MAINTAINER Michele Dolfi <dolfim@phys.ethz.ch>


ENV HOME /root
ENV PARALLEL_BUILD 1

RUN apt-get update

## Install tools and ssh server (needed by MPI)
RUN apt-get -yq install wget openssh-server

## .ssh as volume to customize keys
RUN mkdir -p /root/.ssh
VOLUME /root/.ssh
RUN echo "AuthorizedKeysFile /root/.ssh/authorized_keys\n" >> /etc/ssh/sshd_config
RUN sed -i 's/StrictModes yes/StrictModes no/g' /etc/ssh/sshd_config
RUN echo "    IdentityFile /root/.ssh/id_rsa\n" >> /etc/ssh/ssh_config
RUN echo "    StrictHostKeyChecking no\n" >> /etc/ssh/ssh_config

## Install ALPS dependencies
RUN apt-get -yq install build-essential gfortran cmake \
                        libhdf5-serial-dev libfftw3-dev gfortran python-matplotlib \
                        python-scipy liblapack-dev xsltproc python-dev libboost-all-dev

## Download sources
RUN mkdir src && cd src; \
    wget http://alps.comp-phys.org/static/software/releases/alps-2.2.b4-src.tar.gz; \
    tar xzf alps-2.2.b4-src.tar.gz

## Compile and install ALPS
RUN cd src/alps-2.2.b4-src; \
    mkdir build && cd build; \
    cmake -DALPS_BUILD_FORTRAN=ON \
          -DALPS_ENABLE_OPENMP=ON \
          ../alps; \
    make -j$PARALLEL_BUILD; \
    ctest -j$PARALLEL_BUILD; \
    make install -j$PARALLEL_BUILD

## remove compilation folder
RUN rm -rf src

## Setup environment
ENV PATH /opt/alps/bin:$PATH
ENV LD_LIBRARY_PATH /opt/alps/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH /opt/alps/lib:$PYTHONPATH
## /etc/environment used by SSH connections
RUN sed -i 's,PATH=",PATH="/opt/alps/bin:,g'  /etc/environment
RUN echo 'LD_LIBRARY_PATH="/opt/alps/lib"' >>  /etc/environment
RUN echo 'PYTHONPATH="/opt/alps/lib"' >>  /etc/environment

## Working directory
RUN mkdir /output
VOLUME /output
WORKDIR /output

## Start ssh server
RUN mkdir /var/run/sshd
EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
