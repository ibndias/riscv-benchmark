for entry in "$1"/*
do
  time qemu-riscv64 $entry
done