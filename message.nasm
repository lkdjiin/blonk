org 0x9000
bits 16

xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00

mov si, message
call print_string

jmp $

message db 'BLONK! 0.0.4', 0

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

times 512-($-$$) db 0
