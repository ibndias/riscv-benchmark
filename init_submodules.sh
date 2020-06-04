#!/bin/bash

PATCHDIR=$PWD
git submodule update --init --recursive

pushd beebs
git apply --whitespace=nowarn ${PATCHDIR}/beebs-rimi.patch
popd

