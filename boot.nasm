org 0x7c00
bits 16

xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00
cld

mov si, welcome
call print_string

jmp $

welcome db 'Welcome and bienvenue', 0x0d, 0x0a, 0

print_string:
  lodsb
  or al, al
  jz .done
  mov ah, 0x0e
  mov bx, 0x0007
  int 0x10
  jmp print_string
.done:
  ret

times 510-($-$$) db 0
dw 0xaa55
