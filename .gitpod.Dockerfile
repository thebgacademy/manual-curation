#
# 1 - Base image, this could be reduced to workspace-base but will require install python and pip
#
FROM gitpod/workspace-full-vnc

#
# 2- Standard update
#
RUN sudo apt-get update

#
# 3 - Download test data and unzip
#
RUN cd /workspace \
    && curl -L "https://gitlab.com/wtsi-grit/rapid-curation/-/archive/main/rapid-curation-main.tar.gz?path=test_data" | tar xzf - \
    && mv rapid-curation-main-test_data/test_data ./ \
    && rm -rf rapid-curation-main-test_data \
    && gunzip test_data/*.gz

#
# 4 - Download perl scripts used in curation
#
RUN cd /workspace \
    && wget https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_split.pl \
      https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_join.pl

#
# 5 - Download agp tpf utils
#
RUN cd /workspace \
    && git clone https://github.com/sanger-tol/agp-tpf-utils.git

#
# 6 - Download and install mamba / setup the rapid environment
#
RUN unset PROMPT_COMMAND

RUN cd /workspace \
    && wget "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"

RUN cd /workspace \
    && bash Mambaforge-$(uname)-$(uname -m).sh -b -p /workspace/mambaforge \
    && rm Mambaforge-$(uname)-$(uname -m).sh

RUN cd /workspace \
    && /workspace/mambaforge/bin/mamba init bash

RUN ["/bin/bash", "-c", "source /home/gitpod/.bashrc"]

RUN ["/bin/bash", "-c", "/workspace/mambaforge/bin/mamba create -n rapid -c bioconda perl-bioperl seqtk pyfastaq -y"]

#
# 7 - Change permissions on perl scripts / Add alias for agp tp tpf / activate rapid env
#
RUN cd /workspace \
    && chmod a+x *.pl

RUN echo 'alias ptt="/workspace/mambaforge/bin/python3 /workspace/agp-tpf-utils/src/tola/assembly/scripts/pretext_to_tpf.py"' >> /home/gitpod/.bashrc

RUN ["/bin/bash", "-c", "source /home/gitpod/.bashrc"]

RUN /workspace/mambaforge/bin/mamba init

RUN /workspace/mambaforge/bin/mamba activate rapid

#
# 8 - Install click and ruff for agp to tpf
#
RUN /workspace/mambaforge/bin/pip3 install click ruff

#
# 9 - Install agp to tpf (otherwise will not run)
#
RUN /workspace/mambaforge/bin/python3 -m pip install agp-tpf-utils/
