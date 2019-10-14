#include <stdlib.h>
#include <stdint.h>

void _hardware_sleep_ms(uint32_t ms) __attribute__((weak));

void _hardware_sleep_ms(uint32_t ms) {
    abort();
}
