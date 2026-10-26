section .data
    hw db 'Hello World!'       ;stoque "Hello World!" dans une variable "hw"

section .text
    global _start       ;indique a ld que le debut du code est ici

_start:
    ; afficher la hw
    mov eax, 1          ;syscall "sys_write"
    mov edi, 1          ;1 = sortie standars pour le terminal
    mov esi, hw         ;Adresse de la variable "hw"
    mov edx, 12         ;nombre d'octets a ecrire
    syscall             ;on appel le syscall avec nos parametres

    ; kill le program
    mov eax, 60         ; syscall "exit (60)" linux, dans le registre eax
    mov edi, 0          ; on retounr un code 0
    syscall