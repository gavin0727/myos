    ;; load 'dh' sectors from drive 'dl' into ES:BX
    ;; dl <- drive number
    ;; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
disk_load:
    pusha
    ;; reading from disk requires setting specific values in all registers
    ;; so we will overwrite our input parameters from 'dx'. Let's save it
    ;; to the stack for later use.
    push dx

    mov ah, 0x02                ; ah <- int 0x13 function. 0x02 = 'read'
    mov al, dh                  ; al <- number of sectors to read
    mov cl, 0x02                ; cl <- start sector
                                ; 0x01 is boot sector, 0x02 is the first 'available' sector
    mov ch, 0x00                ; ch <- cylinder
    mov dh, 0x00                ; dh <- head number

    ;; [es:bx] <- pointer to buffer where the data will be stored
    int 0x13
    jc disk_error

    pop dx
    cmp al, dh                  ; BIOS sets 'al' to the # of sectors read.
    jne sectors_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR:
    db "Disk read error", 0
SECTORS_ERROR:
    db "Incorrect number of sectors read", 0
