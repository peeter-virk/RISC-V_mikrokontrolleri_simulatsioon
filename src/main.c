#include <stdint.h>

// Declare the external assembly function
extern void test_arithmetic_instructions(uint32_t* result_addr);
extern void test_csr_registers(uint32_t* result_addr);

void main() {
    uint32_t arithmetic_results[56];
    uint32_t CSR_results[52];   

    // Pass the address of the first element (correct way)
    test_csr_registers(arithmetic_results);

    // You can now read result[0], result[1], etc.
    // For example: if (result[0] != 8) { /* fail */ }
}
