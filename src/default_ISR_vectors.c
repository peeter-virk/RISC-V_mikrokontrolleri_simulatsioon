#include <stdint.h>

// trap the code in a safe enviroment
void __attribute__((weak)) _DEFAULT_ISR(void) {
    while (1);
}

void __attribute__((weak)) _VJKA_ISR(void){
    _setup();
}

void __attribute__((weak)) _TIMER0_OCR0_MATCH_ISR(void){}
void __attribute__((weak)) _TIMER0_OCR1_MATCH_ISR(void){}
void __attribute__((weak)) _TIMER0_OVERFLOW_ISR(void){}