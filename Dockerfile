# TODO: implement tiered docker images
# tier 1: gcc python3 python2 clang fpc pypy3 go
# tier 2: more runtimes such as kotlin, java, csharp, etc..
# tier 3: rarely used languages like brainfuck, whitespace, moo, ...

FROM --platform=${BUILDPLATFORM} debian:bookworm AS tier-1

ARG DEBIAN_FRONTEND=noninteractive
RUN echo 'deb http://deb.debian.org/debian bookworm-backports main\n' >> /etc/apt/sources.list
RUN echo 'deb http://deb.debian.org/debian bullseye main' >> /etc/apt/sources.list
RUN apt update && apt install -y gcc-13 python3.11 python2.7 clang-15 fpc pypy3 && rm -rf /var/lib/apt/lists/*

FROM --platform=${BUILDPLATFORM} tier-1 AS tier-2

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y golang-1.21-go mono-runtime openjdk-17-jdk openjdk-11-jdk openjdk-8-jdk ruby3.1 && rm -rf /var/lib/apt/lists/*