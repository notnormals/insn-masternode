FROM ubuntu:16.04
MAINTAINER Karsten Kaj Jakobsen <karsten@karstenjakobsen.dk>

ENV DEBIAN_FRONTEND=noninteractive
ENV INSN_VERSION=INSN-v1.0.5.5-Membrane-11

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
      apt-utils \
      git \
      libwww-perl \
      build-essential \
      libtool \
      automake \
      autotools-dev \
      autoconf \
      pkg-config \
      libssl-dev \
      libgmp3-dev \
      libevent-dev \
      bsdmainutils \
      libdb++-dev \
      libboost-all-dev \
      libqrencode-dev \
      libminiupnpc-dev \
      libcurl4-openssl-dev \
      libdb-dev \
      libdb++-dev \
      unzip

RUN apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Set workdir and extract package
WORKDIR /usr/local/src
RUN git clone --single-branch --branch "$INSN_VERSION" https://github.com/CryptoCoderz/INSN.git

# Set workdir for compiling
WORKDIR /usr/local/src/INSN/src

RUN chmod +x leveldb/build_detect_platform && \
    chmod +x secp256k1/autogen.sh && \
    make -f makefile.unix USE_UPNP= && \
    strip INSaNed && \
    cp INSaNed /usr/local/bin/ && \
    make -f makefile.unix clean

# Copy package
COPY config/INSaNe.conf /tmp/INSaNe.conf

# Copy our entrypoint file
COPY entrypoint.sh /

CMD ["/entrypoint.sh"]
