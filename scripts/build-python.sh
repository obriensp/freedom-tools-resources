#!/bin/bash
set -eux
set -o pipefail

PYTHON_VERSION=3.7.7
TARGET=linux-ubuntu14

BASE_DIR=/tmp/python-build
SRC_DIR=$BASE_DIR/source
BUILD_DIR=$BASE_DIR/build
STAGING_DIR=$BASE_DIR/staging

mkdir $BASE_DIR
mkdir $SRC_DIR
mkdir $BUILD_DIR
mkdir $STAGING_DIR

cd $SRC_DIR
curl -L -f -s -o Python-3.7.7.tgz https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
tar -xzf Python-$PYTHON_VERSION.tgz

cd $BUILD_DIR
$SRC_DIR/Python-$PYTHON_VERSION/configure --prefix=$STAGING_DIR
make
make install

tar -czf Python.tgz -C $STAGING_DIR .
cp Python.tgz /host-artifacts/python-$PYTHON_VERSION-$(uname -m)-$TARGET.tar.gz
