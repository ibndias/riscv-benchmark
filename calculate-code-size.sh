#!/bin/bash

# Fail on error
set -e

DIR=.

source env.sh

BENCHMARKS=($(ls -d beebs/src/*/ | xargs -n 1 basename))

EXCLUDE_BENCHMARKS=(ctl matmult sglib-arraysort trio compress ctl-string cover dtoa huffbench levenshtein picojpeg slre qrduino strstr nettle-sha256 miniz nsichneu rijndael wikisort)

for i in "${EXCLUDE_BENCHMARKS[@]}"; do
    DISABLE_BENCHMARKS="$DISABLE_BENCHMARKS --disable-benchmark-$i"
done

for i in "${BENCHMARKS[@]}"; do
    if [[ ${EXCLUDE_BENCHMARKS[*]} =~ $i ]]; then
        continue
    fi
    #echo -n -e "$i\t"
    echo -n -e "$i,"
    llvm-nm --radix=d $DIR/results/$i.elf --numeric-sort --print-size | awk '$3 == "T" {s+=$2} END {printf "%.0f\n", s}'
done
