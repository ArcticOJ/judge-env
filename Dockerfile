# TODO: implement tiered docker images
# tier 1: gcc python3 python2 clang fpc pypy3 go
# tier 2: more runtimes such as kotlin, java, csharp, etc..
# tier 3: rarely used languages like brainfuck, whitespace, moo, ...

FROM --platform=${BUILDPLATFORM} debian:bookworm-slim AS base

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends wget apt-transport-https ca-certificates

RUN mkdir -p /etc/apt/keyrings
RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc

COPY igloo-runner.list /etc/apt/sources.list.d/igloo-runner.list

RUN apt clean

FROM --platform=${BUILDPLATFORM} base AS tier-1

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install --no-install-recommends -y gcc-12 python3.11 python2.7 clang-15 fpc pypy3

FROM --platform=${BUILDPLATFORM} tier-1 AS tier-2

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install --no-install-recommends -y golang-1.21-go mono-runtime temurin-21-jdk temurin-17-jdk temurin-11-jdk temurin-8-jdk ruby3.1