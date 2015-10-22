FROM ubuntu:trusty

MAINTAINER Michele Dolfi <dolfim@phys.ethz.ch>

RUN apt-get update
RUN apt-get -yq install wget
RUN apt-get -yq install build-essential cmake \
                        libhdf5-serial-dev libfftw3-dev gfortran python-matplotlib \
                        python-scipy liblapack-dev xsltproc python-dev libboost-all-dev

RUN apt-get -yq install gfortran

RUN mkdir src && cd src; \
    wget http://alps.comp-phys.org/static/software/releases/alps-2.2.b4-src.tar.gz; \
    tar xzf alps-2.2.b4-src.tar.gz

RUN cd src/alps-2.2.b4-src; \
    mkdir build && cd build; \
    cmake -DALPS_BUILD_FORTRAN=ON \
          -DALPS_ENABLE_OPENMP=ON \
          ../alps; \
    make -j2; \
    ctest -j2; \
    make install -j2

ENV PATH /opt/alps/bin:$PATH
ENV LD_LIBRARY_PATH /opt/alps/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH /opt/alps/lib:$PYTHONPATH 

RUN rm -rf src

RUN mkdir /output
VOLUME /output
WORKDIR /output

