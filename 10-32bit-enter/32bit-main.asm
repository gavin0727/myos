    [org 0x7c00]
    mov bp, 0x9000             ; set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print                  ; this will be written after the BIOS messages
    call print_nl

    call switch_to_pm
    jmp $                       ; this will actually never be executed

    %include "../05-bootsector-functions/boot_sect_print.asm"
    %include "../09-32bit-gdt/32bit-gdt.asm"
    %include "../08-32bit-print/32bit-print.asm"
    %include "32bit-switch.asm"

    [bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm        ; Note that this whill be written at the top left corner
    jmp $

    MSG_REAL_MODE db "Started in 16-bit real mode", 0
    MSG_PROT_MODE db "Load 32-bit protected mode", 0

    ;; bootsector
    times 510-($-$$) db 0
    dw 0xaa55
