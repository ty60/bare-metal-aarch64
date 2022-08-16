#include "asm.h"

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long uint64_t;

typedef void (*fp_t)(void);
extern fp_t *Vector_table_el1;

#define UART_BASE (0x9000000UL)


#define UART_MMIO(offset) (*(volatile uint16_t *)(UART_BASE + offset))

#define UARTDR (UART_MMIO(0x000))
#define UARTFR (UART_MMIO(0x018))

#define TXFE (1 << 5) // Transmit FIFO is full
#define RXFE (1 << 4) // Receive FIFO is empty

int putchar(int c) {
    while (UARTFR & TXFE) {
    }

    uint16_t d = c;
    UARTDR = d;
    return c;
}

int puts(const char *s) {
    const char *p = s;
    while (*p != '\x00') {
        putchar(*p++);
    }
    putchar('\n');
    return 1;
}

void hello_svc(void) {
    puts("Hello SVC");
}

void unknown(void) {
    puts("Unknown interrupt");
}

void main(void) {
    load_vbar_el1(&Vector_table_el1);
    svc();
}
