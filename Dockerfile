FROM ubuntu:22.04

RUN apt-get update && \
  apt-get install -y build-essential curl zlib1g-dev
