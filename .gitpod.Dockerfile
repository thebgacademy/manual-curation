#
# 1 - Base image, this could be reduced to workspace-base but will require install python and pip
#
FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]

RUN apt-get update -y && \
    apt-get install sudo -y && \
    apt-get install cowsay -y && \
    apt-get install git -y && \
    apt-get install wget -y

RUN git clone https://github.com/sanger-tol/agp-tpf-utils.git ./workspace/

RUN wget https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_split.pl && \
    wget https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_join.pl && \
    wget https://gitlab.com/wtsi-grit/rapid-curation/-/archive/main/rapid-curation-main.tar.gz && \
    wget "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
    
RUN tar xzf rapid-curation-main.tar.gz

RUN bash Mambaforge-$(uname)-$(uname -m).sh -b

RUN ls ../

#RUN bash mamba create -n rapid -c bioconda perl-bioperl seqtk pyfastaq -y

RUN bash


