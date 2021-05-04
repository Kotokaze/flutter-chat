FROM ubuntu:20.04

RUN apt update -y

RUN apt install -y curl openjdk-11-jre-headless

RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -

RUN apt install -y nodejs

RUN npm install -g firebase-tools
