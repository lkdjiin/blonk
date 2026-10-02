BOOT_DRIVE    equ 0x500
BOOT_ADDRESS  equ 0x7c00
SHELL_ADDRESS equ 0x9000

org BOOT_ADDRESS
bits 16

xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, BOOT_ADDRESS
mov byte [BOOT_DRIVE], dl
cld

; Réinitialisation du disque dur
drive_reset:
  mov ah, 0
  mov dl, [BOOT_DRIVE]
  int 0x13
  jc drive_reset

; Charger le shell à l'adresse 0x9000.
; Il est situé dans le second secteur du disque dur.
mov ax, SHELL_ADDRESS / 16
mov es, ax
xor bx, bx
mov ah, 0x02
mov al, 1
mov ch, 0
mov cl, 2
mov dh, 0
mov dl, [BOOT_DRIVE]
int 0x13
jc drive_reset


; Maintenant que le shell est chargé en mémoire, on y va.
jmp 0:SHELL_ADDRESS

; ----------------------------------------------------------------------
; Table des partitions
times 446-($-$$) nop
db 0x80    ; Partition active
db 0       ; Starting head
db 2       ; Starting sector
db 0       ; Starting cylinder
db 0x20    ; System ID
db 1       ; Ending head
db 0x10    ; Ending sector
db 0x10    ; Ending cylinder
dd 1       ; LBA ?
dd 131072  ; Total de secteurs (64 MB)

times 510-($-$$) db 0
dw 0xaa55
