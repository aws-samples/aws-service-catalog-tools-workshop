FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y wget

RUN wget https://github.com/gohugoio/hugo/releases/download/v0.61.0/hugo_extended_0.61.0_Linux-64bit.deb
RUN dpkg -i hugo_extended_0.61.0_Linux-64bit.deb

RUN mkdir /content

WORKDIR /content

EXPOSE 1313

ENTRYPOINT ["/usr/local/bin/hugo"]