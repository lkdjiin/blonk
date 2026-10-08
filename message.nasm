org 0x9000
bits 16

xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00


; ----------------------------------------------------------------------
; Activation de la GDT
cli
lgdt [gdt_pointer]
; On ne réactive pas les interruptions maintenant, on attendra d'en avoir
; besoin.
mov eax, cr0
or eax, 1
mov cr0, eax

; ----------------------------------------------------------------------
; On saute dans le monde du 32 bits!
jmp 8:go_32_bits


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


bits 32
go_32_bits:
  mov ax, 0x10 ; tous les segments de données reçoivent le sélecteur 0x10
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  mov esp, 0x90000 ; la pile commence à 0x90000

; Afficher le numéro de version au centre de l'écran
mov ebx, 0xb8000 + 0x72a
mov byte [ebx], '0'
inc ebx
inc ebx
mov byte [ebx], '0'
inc ebx
inc ebx
mov byte [ebx], '7'

cli
hlt

times 512-($-$$) db 0
