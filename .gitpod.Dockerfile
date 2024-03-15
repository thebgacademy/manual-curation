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
ADD https://gitlab.com/wtsi-grit/rapid-curation/-/archive/main/rapid-curation-main.tar.gz ./
ADD https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_split.pl ./
ADD https://gitlab.com/wtsi-grit/rapid-curation/-/raw/main/rapid_join.pl ./


# RUN tar xzf ./test.tar.gz \
#    && mv rapid-curation-main-test_data/test_data ./ \
#    && rm -rf rapid-curation-main-test_data \
#    && gunzip test_data/*.gz
