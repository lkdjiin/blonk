org 0x9000
bits 16

xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00

; Afficher le numéro de version dans le coin supérieur gauche.
mov ebx, 0xb8000
mov byte [ebx], '0'
inc ebx
inc ebx
mov byte [ebx], '0'
inc ebx
inc ebx
mov byte [ebx], '6'

cli
hlt

; ----------------------------------------------------------------------
; Définition de la Global Descriptor Table
;
gdt_start:
  ; Null descriptor
  dd 0, 0

  ; Code descriptor
  dw 0xffff     ;  0 - 15
  dw 0          ; 16 - 31
  db 0          ; 32 - 39
  db 0b10011010 ; 40 - 47
  db 0b11001111 ; 48 - 55
  db 0          ; 56 - 63

  ; Data descriptor
  dw 0xffff
  dw 0
  db 0
  db 0b10010010
  db 0b11001111
  db 0
gdt_end:

gdt_pointer:
  dw gdt_end - gdt_start - 1
  dd gdt_start

times 512-($-$$) db 0
