FROM debian:buster-slim
ENV PROTOBUF_VERSION=3.6.1
RUN apt-get update && \
    apt-get install -y wget autoconf automake libtool curl make g++ unzip
WORKDIR /tmp
RUN wget -c https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/protobuf-all-${PROTOBUF_VERSION}.tar.gz -O - | tar -xz && \
    cd protobuf-${PROTOBUF_VERSION} && \
    ./configure && \
    make && \
    make check && \
    make install && \
    ldconfig && \
    cd .. && \
    rm -rf protobuf-${PROTOBUF_VERSION}
RUN apt-get -y remove --purge wget autoconf automake libtool curl make g++ unzip && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/*

WORKDIR /src
ENTRYPOINT [ "protoc" ]