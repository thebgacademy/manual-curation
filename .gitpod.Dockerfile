#
# 1 - Base image, this could be reduced to workspace-base but will require install python and pip
#
FROM dlbpointon/manual-curation:1.0.0

SHELL ["/bin/bash", "-c"]

RUN apt-get update -y && \
    apt-get install sudo -y && \
    apt-get install cowsay -y && \
    apt-get install git -y && \
    apt-get install wget -y

RUN bash


