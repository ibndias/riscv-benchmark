#include <stdio.h>

#define read_csr(reg)                                  \
    ({                                                 \
        unsigned long __tmp;                           \
        asm volatile("csrr %0 , " #reg : "=r"(__tmp)); \
        __tmp;                                         \
    })

int main() {
    unsigned long cycle_start;

    cycle_start = read_csr(0x001);

    printf("cycles = %ld\n", cycle_start);
}
