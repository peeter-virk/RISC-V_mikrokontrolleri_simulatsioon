#include <stdint.h>

// Declare the external assembly function
extern void test_arithmetic_instructions(uint32_t* result_addr);
extern void test_csr_registers(uint32_t* result_addr);
extern void test_memory_instructions(uint32_t* result_addr);
extern void test_control_transfer(uint32_t* result_addr);


uint32_t arithmetic_results[56];
uint32_t CSR_results[52];   
uint32_t memory_results[7];   
uint32_t control_transfer_results[20];   

void main() {
    


    // Pass the address of the first element (correct way)
    test_arithmetic_instructions(arithmetic_results);
    test_csr_registers(arithmetic_results);
    test_memory_instructions(memory_results);
    test_control_transfer(control_transfer_results);
}
