#!/bin/sh

set -eu
set -o pipefail

BASE_DIR=$(dirname $(realpath $0))
OUTPUT_DIR=$PWD

for ARCH in "amd64" "arm64"
do
  echo "Building for $ARCH..."
  export DOCKER_DEFAULT_PLATFORM=linux/$ARCH
  docker run --rm -it \
    -v "$BASE_DIR/scripts:/host-scripts" \
    -v "$OUTPUT_DIR:/host-artifacts" \
    $(docker build -q .) \
    /host-scripts/build-python.sh
done
