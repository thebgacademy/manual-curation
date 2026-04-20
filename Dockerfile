FROM kasmweb/fedora-40-desktop:1.17.0
USER root

ENV HOME="/home/kasm-default-profile"
ENV STARTUPDIR="/dockerstartup"
ENV INST_SCRIPTS="$STARTUPDIR/install"
WORKDIR $HOME


##### Customise container
LABEL org.opencontainers.image.source=https://github.com/thebgacademy/manual-curation

SHELL ["/bin/bash", "-c"]

# Fetch rapid helper scripts and PretextView
RUN curl -L "https://gitlab.com/wtsi-grit/rapid-curation/-/archive/main/rapid-curation-main.tar.gz?path=test_data" -o rapid-curation-main.tar.gz

RUN wget https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_split.pl

RUN wget https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_join.pl

RUN wget https://github.com/wtsi-hpag/PretextView/releases/download/0.2.5/PretextView_Linux-x86-64.zip

RUN unzip PretextView_Linux-x86-64.zip


##### Setup Mamba
RUN set -eux; \
    wget "https://github.com/conda-forge/miniforge/releases/download/24.3.0-0/Mambaforge-24.3.0-0-Linux-x86_64.sh" -O /tmp/Mambaforge.sh; \
    bash /tmp/Mambaforge.sh -b -p /opt/mambaforge; \
    rm -f /tmp/Mambaforge.sh; \
    /opt/mambaforge/bin/mamba init bash || true

# Provide Mambaforge environment and friendly aliases at login for interactive shells
RUN set -eux; \
        cat > /etc/profile.d/mambaforge.sh <<'EOF'
# Add mambaforge to PATH and initialize for interactive shells
export PATH="/opt/mambaforge/bin:$PATH"
if [ -f /opt/mambaforge/etc/profile.d/conda.sh ]; then
    . /opt/mambaforge/etc/profile.d/conda.sh
fi
EOF


# Show the welcome message for interactive shells and provide an alias 'ptt'
RUN set -eux; \
    cat > /home/kasm-user/manual_curation_welcome.sh <<'EOF'
# Show welcome and setup alias when a user opens an interactive shell
if [ -n "$PS1" ]; then
  # Alias to run pretext_to_tpf from the mounted workspace (if present)
  git clone https://github.com/sanger-tol/agp-tpf-utils.git /home/kasm_user/agp-tpf-utils/
  alias ptt="/opt/mambaforge/bin/python3 /home/kasm_user/agp-tpf-utils/src/tola/assembly/scripts/pretext_to_tpf.py"
  if [ -x /home/kasm-user/welcome.sh ]; then
    /home/kasm-user/welcome.sh
  fi
fi
EOF
RUN chmod 644 /home/kasm-user/manual_curation_welcome.sh || true


##### Welcome script
COPY welcome.sh /home/kasm-user
RUN chmod +x /home/kasm-user/welcome.sh

##### EO Customisations
RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME="/home/kasm-user"
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
