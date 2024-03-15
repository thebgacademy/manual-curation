#
# 1 - Base image, this could be reduced to workspace-base but will require install python and pip
#
FROM gitpod/workspace-full-vnc

RUN sudo apt-get update && sudo apt install cowsay

RUN git clone https://github.com/sanger-tol/agp-tpf-utils.git

