#include <stdint.h>

void _RESET();

// trap the code in a safe enviroment
void __attribute__((weak)) _ISR(void) {
    while (1);
}