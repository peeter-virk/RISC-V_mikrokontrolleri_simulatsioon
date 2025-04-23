#include <stdint.h>

void main(){
    volatile int32_t x = 10;
    volatile int32_t y = 12;
    x+=y;
    x+=y;
    while (1){}
    
}