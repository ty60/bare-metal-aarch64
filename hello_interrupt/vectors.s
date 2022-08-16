// https://developer.arm.com/documentation/100933/0100/AArch64-exception-vector-table

.global Vector_table_el1

.extern hello_world
.extern unknown

// Typical exception vector table code.
.balign 0x800
Vector_table_el1:
curr_el_sp0_sync:        // The exception handler for a synchronous 
                         // exception from the current EL using SP0.
bl unknown
b .
.balign 0x80
curr_el_sp0_irq:         // The exception handler for an IRQ exception
                         // from the current EL using SP0.
bl unknown
b .
.balign 0x80
curr_el_sp0_fiq:         // The exception handler for an FIQ exception
                         // from the current EL using SP0.
bl unknown
b .
.balign 0x80
curr_el_sp0_serror:      // The exception handler for a System Error 
                         // exception from the current EL using SP0.
bl unknown
b .
.balign 0x80
curr_el_spx_sync:        // The exception handler for a synchrous 
                         // exception from the current EL using the
                         // current SP.
bl hello_svc
b .
.balign 0x80
curr_el_spx_irq:         // The exception handler for an IRQ exception from 
                         // the current EL using the current SP.
bl unknown
b .

.balign 0x80
curr_el_spx_fiq:         // The exception handler for an FIQ from 
                         // the current EL using the current SP.
bl unknown
b .

.balign 0x80
curr_el_spx_serror:      // The exception handler for a System Error 
                         // exception from the current EL using the
                         // current SP.
bl unknown
b .

 .balign 0x80
lower_el_aarch64_sync:   // The exception handler for a synchronous 
                         // exception from a lower EL (AArch64).
bl unknown
b .

.balign 0x80
lower_el_aarch64_irq:    // The exception handler for an IRQ from a lower EL
                         // (AArch64).
bl unknown
b .

.balign 0x80
lower_el_aarch64_fiq:    // The exception handler for an FIQ from a lower EL
                         // (AArch64).
bl unknown
b .

.balign 0x80
lower_el_aarch64_serror: // The exception handler for a System Error 
                         // exception from a lower EL(AArch64).
bl unknown
b .

.balign 0x80
lower_el_aarch32_sync:   // The exception handler for a synchronous 
                         // exception from a lower EL(AArch32).
bl unknown
b .
.balign 0x80
lower_el_aarch32_irq:    // The exception handler for an IRQ exception 
                         // from a lower EL (AArch32).
bl unknown
b .
.balign 0x80
lower_el_aarch32_fiq:    // The exception handler for an FIQ exception from 
                         // a lower EL (AArch32).
bl unknown
b .
.balign 0x80
lower_el_aarch32_serror: // The exception handler for a System Error
                         // exception from a lower EL(AArch32).
bl unknown
b .

