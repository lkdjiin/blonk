org 0x9000
bits 16

xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00

mov ebx, 0xb8000
mov byte [ebx], 3
inc ebx
mov byte [ebx], 0x0f
inc ebx
mov byte [ebx], 66
inc ebx
mov byte [ebx], 0xe4
inc ebx
mov byte [ebx], 130
inc ebx
mov byte [ebx], 0x0f

cli
hlt

times 512-($-$$) db 0
