#include <stdint.h>


#define length 47 
volatile uint32_t fibbonacci[length];



void main() {
    
    for (int i = 0; i < length; i++) {
        if (i == 0)
            fibbonacci[i] = 0;
        else if (i == 1)
            fibbonacci[i] = 1;
        else
            fibbonacci[i] = fibbonacci[i - 1] + fibbonacci[i - 2];
    }
    
}
