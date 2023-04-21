FROM ubuntu:20.04

RUN apt-get update

RUN apt-get install -y zip unzip

# Install recommended tools
RUN apt-get install -y arping netperf iperf3

# Install BCC dependencies for Ubuntu 20.04
# Change TZ to fit needs
RUN DEBIAN_FRONTEND=noninteractive \
  TZ=Asia/Singapore \ 
  apt-get install -y \
  bison build-essential cmake flex git libedit-dev \
  libllvm12 llvm-12-dev libclang-12-dev python zlib1g-dev libelf-dev libfl-dev python3-setuptools

# Install LuaJIT for BCC 
RUN apt-get -y install luajit luajit-5.1-dev

RUN apt-get -y install liblzma-dev

# Build BCC from source
RUN git clone https://github.com/iovisor/bcc.git
RUN mkdir bcc/build && cd bcc/build && \ 
      cmake .. && \
      make install && \
      cmake -DPYTHON_CMD=python3 .. && \ 
      cd src/python/ && \
      make && \
      make install && \
      cd ../..

# Kernel Headers
RUN apt-get install linux-headers-$(uname -r)


# Set working directory
WORKDIR /src