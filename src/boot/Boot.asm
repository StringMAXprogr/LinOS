bits 16
org 0x7C00

start:
    cli

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Kernel von Disk laden
    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0x80
    mov bx, 0x1000
    int 0x13

    jc disk_error

    ; Protected Mode vorbereiten
    cli

    lgdt [gdt_descriptor]

    mov eax, cr0
    or eax, 1
    mov cr0, eax

    jmp 0x08:protected_mode

disk_error:
    mov si, error_message

print_error:
    lodsb
    test al, al
    jz halt

    mov ah, 0x0E
    int 0x10

    jmp print_error

halt:
    cli
    hlt
    jmp halt


bits 32

protected_mode:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov ss, ax

    ; Zum Kernel springen
    jmp 0x1000


; -------------------------
; Global Descriptor Table
; -------------------------

gdt_start:

gdt_null:
    dq 0

gdt_code:
    dw 0xFFFF
    dw 0
    db 0
    db 10011010b
    db 11001111b
    db 0

gdt_data:
    dw 0xFFFF
    dw 0
    db 0
    db 10010010b
    db 11001111b
    db 0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start


error_message:
    db "LINOS: Disk read error", 13, 10
    db 0


times 510 - ($ - $$) db 0
dw 0xAA55
