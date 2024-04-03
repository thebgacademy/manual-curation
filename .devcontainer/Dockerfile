FROM mcr.microsoft.com/devcontainers/base:jammy

SHELL ["/bin/bash", "-c"]

RUN curl -L "https://gitlab.com/wtsi-grit/rapid-curation/-/archive/main/rapid-curation-main.tar.gz?path=test_data" -o rapid-curation-main.tar.gz

RUN wget https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_split.pl \
    https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_join.pl \
    https://github.com/wtsi-hpag/PretextView/releases/download/0.2.5/PretextView_Linux-x86-64.zip

RUN git clone https://github.com/sanger-tol/agp-tpf-utils.git
