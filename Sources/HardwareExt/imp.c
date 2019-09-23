#include <stdlib.h>
#include <stdint.h>

void _sleep_ms(uint32_t ms) __attribute__((weak));

void _sleep_ms(uint32_t ms) {
    abort();
}
