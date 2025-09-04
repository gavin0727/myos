print_hex:
    pusha

    mov cx, 0                   ; index variable

hex_loop:
    cmp cx, 4                   ; loop 4 times
    je end

    ;; convert last char of 'dx' to ascii
    mov ax, dx
    and ax, 0x000F              ; get the last char
    add al, 0x30
    cmp al, 0x39
    jle step2
    add al, 7

step2:
    ;; get the correct position of the string to place ascii char
    mov bx, HEX_OUT + 5
    sub bx, cx
    mov [bx], al
    ror dx, 4                   ; circular right shift

    add cx, 1
    jmp hex_loop
end:
    mov bx, HEX_OUT
    call print

    popa
    ret

HEX_OUT:
    db '0xABCD', 0              ; reserve memory for new string
