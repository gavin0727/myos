    mov ah, 0x0e                ; tty mode

    mov bp, 0x8000             ; far away from 0x7c00
    mov sp, bp                  ; empty stack

    push 'A'
    push 'B'
    push 'C'

    ;; stack grows downwards
    mov al, [0x7ffe]            ; 0x8000 - 2 --> 'A'
    int 0x10

    mov al, [0x8000]
    int 0x10

    pop bx
    mov al, bl
    int 0x10                    ; prints 'C'

    pop bx
    mov al, bl
    int 0x10                    ; prints 'B'

    pop bx
    mov al, bl
    int 0x10                    ; prints 'A'

    mov al, [0x8000]
    int 0x10

    jmp $
    times 510-($-$$) db 0
    dw 0xaa55
