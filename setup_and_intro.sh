#!/usr/bin/env bash
set -euo pipefail

micromamba create -n curation python uv -y
micromamba activate curation

git clone https://github.com/sanger-tol/agp-tpf-utils.git /home/kasm-user/agp-tpf-utils/
cd /home/kasm-user/agp-tpf-utils/
uv pip install ./

if [ -x /home/kasm-user/intro.sh ]; then
    /home/kasm-user/intro.sh
fi
