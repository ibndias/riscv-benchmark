#!/bin/bash

# Compile and run regregator benchmark

# Fail on error
#set -e

source env.sh

#RISCV_CC="clang --target=riscv32 -march=rv32g"
#RISCV_CC="riscv64-unknown-elf-gcc -march=rv64g"
#RISCV_CC="riscv64-unknown-elf-gcc"
#RISCV_CC="clang -march=rv64g"

BENCHMARKS=($(ls -d beebs/src/*/ | xargs -n 1 basename))

#EXCLUDE_BENCHMARKS=(ctl matmult sglib-arraysort trio compress ctl-string cover dtoa huffbench levenshtein picojpeg slre qrduino strstr nettle-sha256 miniz nsichneu rijndael wikisort)
EXCLUDE_BENCHMARKS=(ctl matmult sglib-arraysort trio)

echo "Using Proxy Kernel"
CHIP=mte-mpk
BOARD=generic

rm -rf results/*.elf
rm -rf results/*.out
rm -rf results/*.log
rm -rf results/*.hist
mkdir results
# compile beebs
cd beebs
# set -o xtrace
./configure CC="clang" CFLAGS="-g -O0 -static -march=rv64g" --host=riscv${RISCV_XLEN}-unknown-elf --with-chip=$CHIP --with-board=$BOARD
make clean
make
for i in "${BENCHMARKS[@]}"; do
    if [[ ${EXCLUDE_BENCHMARKS[*]} =~ $i ]]; then
        continue
    fi

    cp src/$i/$i ../results/$i.elf 
    echo -n "Executing $i"
    # spike -l $PK ../results/$i.elf 1> ../results/$i.out 2> ../results/$i.log
    # ../parse-log ../results/$i.log > ../results/$i.hist
    echo " [DONE]"
done

cd - > /dev/null
echo "DONE"
