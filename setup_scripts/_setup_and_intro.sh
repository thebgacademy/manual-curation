#!/usr/bin/env bash
set -euo pipefail

echo "Setting up environment..."
micromamba shell init -s bash -r ~/micromamba
source ~/.bashrc
micromamba activate
micromamba install python=3.14 uv -y

echo "Setting up test data..."
tar -xzf /home/kasm-user/rapid-curation-main.tar.gz

echo "Setting up AGP-TPF-utils..."
git clone https://github.com/sanger-tol/agp-tpf-utils.git /home/kasm-user/agp-tpf-utils/
cd /home/kasm-user/agp-tpf-utils/
uv pip install ./
cd /home/kasm-user/


if [ -x /home/kasm-user/intro.sh ]; then
    /home/kasm-user/intro.sh
fi
