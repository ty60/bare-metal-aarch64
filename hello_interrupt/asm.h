#ifndef ASM_H
#define ASM_H

static inline void load_vbar_el1(void *vectors) {
    __asm__ volatile (
            "mov x0, %0 \n\t"
            "msr vbar_el1, x0 \n\t"
            :
            : "r" (vectors)
            : "x0"
            );
}

static inline void svc(void) {
    __asm__ volatile (
            "svc #0\n\t"
            );
}


#endif
