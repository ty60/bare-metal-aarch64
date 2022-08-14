typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long uint64_t;

/*
 * Dump dtb to check where the mmio for uart is located at.
 *   qemu-system-aarch64 -cpu cortex-a57 -M virt   --machine dumpdtb=aarch64-virt.dtb
 *   dtc -o aarch64-virt.dts -O dts -I dtb aarch64-virt.dtb
 *   Reference: https://github.com/uchan-nos/os-from-zero/wiki/kaz399;-QEMU-aarch64-virt-%E3%81%AE%E3%83%87%E3%83%90%E3%82%A4%E3%82%B9%E3%83%84%E3%83%AA%E3%83%BC

pl011@9000000 {
        clock-names = "uartclk\0apb_pclk";
        clocks = <0x8000 0x8000>;
        interrupts = <0x00 0x01 0x04>;
        reg = <0x00 0x9000000 0x00 0x1000>;
        compatible = "arm,pl011\0arm,primecell";
};
*/

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
    return 1;
}

void main(void) {
    puts("Hello world!");
}
