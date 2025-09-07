gdt_start:
    ;; the GDT starts with a null 8-byte
    dd 0x0
    dd 0x0

    ;; Segment Descriptor
    ;; +-------------+--------+---------+-------------+-------------+
    ;; | 63       56 | 55  52 | 51   48 | 47       40 | 39       32 |
    ;; +-------------+--------+---------+-------------+-------------+
    ;; | Base        | Flags  | limit   | Access Byte | Base        |
    ;; | 31       24 | 3    0 | 19   16 | 7         0 | 23       16 |
    ;; +-------------+--------+---------+-------------+-------------+
    ;; | 31                          16 | 15                      0 |
    ;; +--------------------------------+---------------------------+
    ;; | Base                           | limit                     |
    ;; | 15                           0 | 15                      0 |
    ;; +--------------------------------+---------------------------+

    ;; Access Byte
    ;; +---+---+---+---+---+----+----+---+
    ;; | 7 | 6 | 5 | 4 | 3 | 2  | 1  | 0 |
    ;; +---+-------+---+---+----+----+---+
    ;; | P |  DPL  | S | E | DC | RW | A |
    ;; +---+-------+---+---+----+----+---+

    ;; Flags
    ;; +---+-----+---+-----+
    ;; | 3 |  2  | 1 |  0  |
    ;; +---+-------+-------+
    ;; | G | DB  | L | rsv |
    ;; +---+-----+---+-----+

    ;; GDT for code segment. base = 0x00000000, length = 0xfffff
gdt_code:
    dw 0xffff                   ; segment length, bits 0-15
    dw 0x0                       ; segment base, bits 0-15
    db 0x0                       ; segment base, bits 16-23
    db 10011010b                 ; flags (8 bits)
    db 11001111b                 ; flags (4-bits) + segment length, bits 16-19
    db 0x0                       ; segment base, bits 24-31

gdt_data:
    ;; GDT ofr data segment
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; size (16 bit), always one less of its true size
    dd gdt_start                ; address (32 bit)

    ;; define some constants
    CODE_SEG equ gdt_code - gdt_start
    DATA_SEG equ gdt_data - gdt_start
