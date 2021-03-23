# Benchmarking for MTE-MPK

Setup Benchmark Environment
Make sure these tools already set up.

- riscv-llvm
- riscv-gnu-toolchain
- riscv-pk

Clone the RIMI benchmark Repository

```sh
$ git clone https://git.crypto.islab.re.kr/scm/cap/rimi-benchmarks.git
```

Update the beebs repository for RIMI Benchmarking

```sh
$ source init_submodules.sh
```

Now open the env.sh, update the environment variables to match with our current RISCV toolchain configuration.

```sh
export RISCV=/opt/riscv #change to toolchain path
export PK=$RISCV/riscv32-unknown-elf/bin/pk
export PATH=$RISCV/bin:$PATH
export RISCV_XLEN=64
```

Now we can proceed to benchmarking process.

## Run the benchmark using

```sh
$ source run-benchmark.sh
```
This will generate the logs and instruction histogram for each test in results.

In order to collect and summarize all of the test result for visualization

```sh
$ python instruction-histogram.py
```
Then we can calculate the code size using

```sh
$ source calculate-code-size.sh
```
