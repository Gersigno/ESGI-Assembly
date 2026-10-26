section .data           ;Buffer (zone vide dans la memoire pour stoquer les valeurs des variables)
    letter db 'A'       ;stoque "A" dans une variable "letter"

section .text
    global _start       ;indique a ld que le debut du code est ici

_start:
    ; afficher la letter
    mov eax, 1          ;syscall "sys_write"
    mov edi, 1          ;1 = sortie standars pour le terminal
    mov esi, letter     ;Adresse de la variable "letter"
    mov edx, 1          ;nombre d'octets a ecrire (1 pour "A")
    syscall             ;on appel le syscall avec nos parametres

    ; kill le program
    mov eax, 60         ; syscall "exit (60)" linux, dans le registre eax
    mov edi, 0          ; on retounr un code 0
    syscall