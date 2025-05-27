#include <stdint.h>

// Declare the external assembly function
extern void test_arithmetic_instructions(uint32_t* result_addr);
extern void test_csr_registers(uint32_t* result_addr);
extern void test_memory_registers(uint32_t* result_addr);

void main() {
    uint32_t arithmetic_results[56];
    uint32_t CSR_results[52];   
    uint32_t memory_results[7];   


    // Pass the address of the first element (correct way)
    test_arithmetic_instructions(arithmetic_results);
    test_csr_registers(arithmetic_results);
    test_memory_registers(memory_results);
}
