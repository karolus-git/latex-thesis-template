
FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && apt-get install -qy \
    texlive-full \
    python-pygments \
    gnuplot \
    biber

WORKDIR /thesis
VOLUME ["/thesis"]