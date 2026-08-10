bits 16
org 0x7C00

start:
    cli

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov si, message

print:
    lodsb
    test al, al
    jz halt

    mov ah, 0x0E
    mov bh, 0x00
    int 0x10

    jmp print

halt:
    cli
    hlt
    jmp halt

message:
    db "LINOS", 13, 10
    db "Booting Lin Kernel...", 13, 10
    db 0

times 510 - ($ - $$) db 0
dw 0xAA55
