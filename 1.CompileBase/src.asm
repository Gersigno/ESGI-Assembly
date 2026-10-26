global _start       ;indique a ld que le debut du code est ici

section .text
_start:
    mov eax, 60     ; syscall "exit (60)" linux, dans le registre eax
    mov edi, 1      ; inject "1" dans l'edi (pour que le program retourne 1 via echo)
    syscall