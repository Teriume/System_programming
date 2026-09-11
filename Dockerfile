FROM ubuntu:22.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    gcc \
    gdb \
    fasm \
    nasm \
    binutils \
    libc6-dev-i386 \
    gcc-multilib \
    make \
    git \
    vim \
    nano \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["/bin/bash"]
