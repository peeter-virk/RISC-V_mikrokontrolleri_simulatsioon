#include <stdint.h>

// Microcontroller-specific addresses
#define TIMER_BASE        0x100
#define TIMER_CTRL        (*(volatile uint32_t *)(TIMER_BASE + 0x0))
#define TIMER_COUNTER     (*(volatile uint32_t *)(TIMER_BASE + 0x4))
#define TIMER_OCR0        (*(volatile uint32_t *)(TIMER_BASE + 0x8))
#define INTERRUPT_VECTOR  0x28
#define TIMER_INTERRUPT   (*(volatile uint32_t *)INTERRUPT_VECTOR)

// Constants
#define CLOCK_FREQUENCY   1000000  // Assume 1 MHz clock
#define SECONDS_TO_TICKS(sec) ((sec) * CLOCK_FREQUENCY)  // Convert seconds to clock ticks

// Global variable incremented by the interrupt
volatile uint32_t interrupt_counter = 0;

// Interrupt Service Routine (ISR) for the timer
void timer_isr() {
    interrupt_counter++;
    // Clear the interrupt flag (if required by your system)
}

// Main program
int main() {
    // Disable the timer during setup
    TIMER_CTRL = 0;

    // Set the timer compare value to 5 seconds (in ticks)
    TIMER_OCR0 = SECONDS_TO_TICKS(5);

    // Configure the timer:
    // - Enable timer (b0 = 1)
    // - Clock division: clock/1 (b1-b2 = 00)
    // - Standard clock input (b3-b4 = 00)
    // - Increment mode (b5 = 1)
    // - Reset on OCR match (b6-b7 = 01)
    TIMER_CTRL = (1 << 0) | (1 << 5) | (1 << 6);

    // Enable OCR interrupt in the microcontroller
    TIMER_INTERRUPT = (1 << 0);  // Assuming b0 enables OCR interrupt

    // Main loop (does nothing)
    while (1) {
        // Do nothing
    }

    return 0;
}
