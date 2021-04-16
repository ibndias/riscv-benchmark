#!/bin/bash
filename="${1##*/}"

set -x
#xterm -e ./scripts/start-qemu.sh $1 &

test -d benchmark || mkdir benchmark
#rm gdb.txt
#rm result.txt
#run gdb
export PATH="$HOME/Documents/Project/riscv-gnu-toolchain/install/bin:$PATH"
riscv64-unknown-linux-gnu-gdb $1 -ex "target extended-remote :9999" -ex "set remote exec-file $1" -x script_remote.gdb -batch \
| grep "=>" \
| awk '{ for (i=1; i<=NF; ++i) { if ($i ~ ":$") print $(i+1) } }' \
| tr ' ' '\12' | sort | uniq -c | awk ' {print $2 "," $1} ' > benchmark/$filename.hist

mv gdb.txt benchmark/$filename.log