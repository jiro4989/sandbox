FROM ubuntu:19.04

RUN apt update -yqq && \
    apt install -y --no-install-recommend \
        python3 \
        python3-pip \
        graphviz \
        pango
RUN pip install -y eralchemy

RUN mkdir /work
WORKDIR /work
