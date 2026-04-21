#!/bin/bash
# Adapted from https://github.com/mamba-org/micromamba-docker/blob/main/_download_micromamba.sh

set -euo pipefail

test "${TARGETARCH}" = 'amd64' && export ARCH='64'
test "${TARGETARCH}" = 'arm64' && export ARCH='aarch64'
test "${TARGETARCH}" = 'ppc64le' && export ARCH='ppc64le'
echo "Downloading micromamba for ${TARGETARCH} (${VERSION})..."
curl -L "https://micro.mamba.pm/api/micromamba/linux-${ARCH}/${VERSION}" \
| tar -xj -C "/" "bin/micromamba"
