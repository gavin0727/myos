    mov ah, 0x0e                    ; tty mode
    mov al, 'H'
    int 0x10                    ; general interrupt for video services
    mov al, 'e'
    int 0x10
    mov al, 'l'
    int 0x10
    int 0x10                    ; 'l' is still on al
    mov al, 'o'
    int 0x10
    mov al, ','
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 'g'
    int 0x10
    mov al, 'a'
    int 0x10
    mov al, 'v'
    int 0x10
    mov al, 'i'
    int 0x10
    mov al, 'n'
    int 0x10
    jmp $                       ; jump to current address = infinite loop
    times 510-($-$$) db 0
    ;; magic number
    dw 0xaa55
