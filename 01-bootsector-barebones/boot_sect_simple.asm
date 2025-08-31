    ;; Infinite loop (e9 fd ff)
loop:
    jmp loop
    ;; fill with 510 zeros minus the size of the previous code
    times 510-($-$$) db 0
    ;; magic number
    dw 0xaa55
