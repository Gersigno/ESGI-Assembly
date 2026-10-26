;Linux syscall table : https://filippo.io/linux-syscall-table/

section .data
    title db 'Tapez du text:'

section .bss
    input_buffer resb 10    ;buffer pour stoquer l'entrée utilisateur de 10 octets (donc taille max du text ?)

section .text
    global _start           ;indique a ld que le debut du code est ici

_start:
    mov eax, 1              ;syscall "sys_write"
    mov edi, 1              ;1 = sortie standars pour le terminal
    mov esi, title          ;Adresse de la variable "title"
    mov edx, 15             ;nombre d'octets a ecrire ()
    syscall                 ;on appel le syscall avec nos parametres

    call read_user_input     ;appel de la fonction read user input
    call display_user_input  ;appel de la fonction pour afficher l'input

    cmp eax, 10
    jl stop                 ; si longueur input <= 10, on stop

    call flush_input        ;par contre, si input > 10, on flush l'input pour eviter les debordement, puis on stop
    call stop


read_user_input:
    ; lire l'input du terminal
    mov eax, 0               ; stock le syscall 0 (sys_read)
    mov edi, 0               ; fichier d'entrée (stdin donc clavier/terminal)
    mov esi, input_buffer    ; ou stocker l'entrée (dans notre variable)
    mov edx, 10              ; taille max en ovtets ?
    syscall

    ret                 ; retourne au pointer d'execution d'appel (call) de la fonction

display_user_input:
    mov edx, eax            ;stock la valeur de aex (taille de l'input enregistré dans aex par le syscall sys_read) dans dex pour la garder en memoire
    mov eax, 1              ;syscall "sys_write"
    mov edi, 1              ;1 = sortie standars pour le terminal
    mov esi, input_buffer   ;Adresse de la variable "input_buffer"
    ;mov edx, dex            ;nombre d'octets a ecrire (taille de l'input stocké dans eax par sys_read)
    syscall                 ;on appel le syscall avec nos parametres

    ret


flush_input:
    mov eax, 0          ; re lecture de sys_read
    mov edi, 0          ; stdin
    mov esi, input_buffer  ; on prend l'input
    mov edx, 1          ; et on lit qu'un seul octet
    syscall

    ; si sys_read retourne 0 ou moins, on stop car fin du fichier
    cmp rax, 0
    jle flush_done     ;sortie de la fonction (jle pour <= 0)

    cmp byte [input_buffer], 0x0A      ;dernier character est "\n" ? (0x0A en hex)
    jne flush_input    ; si != '\n', on re boucle sur l'octet suivant

flush_done:
    ret             ; obliger de faire ca car on dois sortir uniquement sur la condition jump if less or equal
                    ; si on met ret direct, alors on sort forcement sans passer par la condition

stop:
    mov eax, 60         ; syscall "exit (60)" linux, dans le registre eax
    mov edi, 0          ; on retounr un code 0
    syscall