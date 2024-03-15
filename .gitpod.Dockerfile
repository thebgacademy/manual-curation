FROM gitpod/workspace-full-vnc

RUN sudo apt-get update

RUN cd /workspace
  && curl -L "https://gitlab.com/wtsi-grit/rapid-curation/-/archive/main/rapid-curation-main.tar.gz?path=test_data" | tar xzf - \
  && mv rapid-curation-main-test_data/test_data ./ \
  && rm -rf rapid-curation-main-test_data \
  && gunzip test_data/*.gz

RUN cd /workspace
  && wget https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_split.pl \
    https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_join.pl

RUN cd /workspace
  && git clone https://github.com/sanger-tol/agp-tpf-utils.git

RUN cd /workspace
    && wget "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
    && bash Mambaforge-$(uname)-$(uname -m).sh -b -p /workspace/mambaforge && rm Mambaforge-$(uname)-$(uname -m).sh

RUN /workspace/mamba/bin/mamba init bash
  && source ~./bashrc
  && mamba create -n rapid -c bioconda perl-bioperl seqtk pyfastaq -y

RUN cd /workspace
  && chmod a+x *.pl *.py
  && /workspace/mambaforge/bin/mamba init bash
  && echo 'alias ptt="/workspace/mambaforge/bin/python3 /workspace/agp-tpf-utils/src/tola/assembly/scripts/pretext_to_tpf.py"' >> ${HOME}/.bashrc
  && source ~/.bashrc
  && mamba activate rapid

RUN /workspace/mambaforge/bin/pip3 install click ruff

RUN /workspace/mambaforge/bin/python3 -m pip install agp-tpf-utils/

RUN export PATH=/workspace:$PATH

RUN clear
  && echo "Welcome GRIT's curation tutorial"
  && echo "typing './PretextView' will run PretextView - Remember to allow pop-ups!"
  && echo "'ptt' is the alias for the pretext-to-tpf script!"
  && echo " Run this for the tutorial: 'gp preview https://thebgacademy.org/BGA24/sessions/Genome-Curation'"
  && echo "---- Have Fun ----"

  
