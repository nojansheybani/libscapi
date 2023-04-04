
## Some cmake problems
FROM ubuntu:18.04 as base

ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install \
    -y build-essential cmake git libgmp3-dev libprocps-dev libboost-all-dev libssl-dev libsodium-dev nano curl liblog4cpp5-dev zlib1g-dev wget libicu-dev

RUN apt-get install -y libssl-ocaml-dev g++ gcc

RUN wget https://boostorg.jfrog.io/artifactory/main/release/1.71.0/source/boost_1_71_0.tar.bz2 && \
    tar -xf boost_1_71_0.tar.bz2 && \
    cd boost_1_71_0/ && \
    ./bootstrap.sh --prefix=/usr/local --with-libraries=all && \
    ./b2 install

RUN /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/boost.conf'

RUN ldconfig

RUN cd /home && git clone https://github.com/nojansheybani/libscapi.git

WORKDIR /home/libscapi

RUN cmake . && make