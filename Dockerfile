FROM mcr.microsoft.com/devcontainers/base:jammy

SHELL ["/bin/bash", "-c"]

RUN curl -L "https://gitlab.com/wtsi-grit/rapid-curation/-/archive/main/rapid-curation-main.tar.gz?path=test_data" -o rapid-curation-main.tar.gz

RUN git clone https://github.com/sanger-tol/agp-tpf-utils.git

# "postCreateCommand": "git clone https://github.com/sanger-tol/agp-tpf-utils.git && pip install click ruff && pip install agp-tpf-utils/ && curl -L 'https://gitlab.com/wtsi-grit/rapid-curation/-/archive/main/rapid-curation-main.tar.gz?path=test_data' | tar xzf - && wget https://github.com/wtsi-hpag/PretextView/releases/download/0.2.5/PretextView_Linux-x86-64.zip https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_split.pl https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_join.pl && unzip PretextView_Linux-x86-64.zip &&"
# add a small script to do the welcome message?

# mamba activate rapid just has to be run in the users terminal
