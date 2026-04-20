FROM kasmweb/fedora-40-desktop:1.17.0
USER root

ENV HOME="/home/kasm-default-profile"
ENV STARTUPDIR="/dockerstartup"
ENV INST_SCRIPTS="$STARTUPDIR/install"
WORKDIR $HOME


##### Customise container
LABEL org.opencontainers.image.source=https://github.com/thebgacademy/manual-curation

SHELL ["/bin/bash", "-c"]

RUN curl -L "https://gitlab.com/wtsi-grit/rapid-curation/-/archive/main/rapid-curation-main.tar.gz?path=test_data" -o rapid-curation-main.tar.gz

RUN wget https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_split.pl

RUN wget https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_join.pl

RUN wget https://github.com/wtsi-hpag/PretextView/releases/download/0.2.5/PretextView_Linux-x86-64.zip

RUN unzip PretextView_Linux-x86-64.zip


##### EO Customisations
RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME="/home/kasm-user"
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
