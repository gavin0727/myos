[org 0x7c00]
    mov bp, 0x8000              ; set the stack safely away from us
    mov sp, bp

    mov bx, 0x9000              ; es:bx = 0x0000:0x9000 = 0x09000
    mov dh, 2                    ; read 2 sectors

    call disk_load

    mov dx, [0x9000]            ; retrieve the first loaded word, 0xdada
    call print_hex
    call print_nl

    mov dx, [0x9000 + 512]      ; first word from second loader sector, 0xface
    call print_hex

    jmp $

    %include "../05-bootsector-functions/boot_sect_print.asm"
    %include "../05-bootsector-functions/boot_sect_print_hex.asm"
    %include "boot_sect_disk.asm"

    times 510 - ($-$$) db 0
    dw 0xaa55

    times 256 dw 0xdada
    times 256 dw 0xface

