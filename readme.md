# Mes notes :

## Registres

### 16 bits

| Registre | Definition          | Description                                                                         |
| -------- | ------------------- | ----------------------------------------------------------------------------------- |
| `AX`     | Accumulator         | Stoque souvent un résultat ou une valeur qui va etre lue comme input d'une fonction |
| `BX`     | Base                | Adresse memoire                                                                     |
| `CX`     | Counter             | COmpteur (souvent incrémenté)                                                       |
| `DX`     | Data                | Manip de données                                                                    |
| `SI`     | Source index        | Stock souvent l'input d'une operation                                               |
| `DI`     | Destination Index   | Stock l'output d'une operation                                                      |
| `IP`     | Instruction Pointer | Pointeur vers la prochaine instruction                                              |
| `BP`     | Base Pointer        | Lis les données de la stack lors d'un appel system                                  |
| `SP`     | Stack Pointer       | Pointe vers le haut de la stack actuel                                              |

attention: techniquement on s'en sert comme on veux

#### Si `32` bits :

les instructions sont préfixé de E (pour "extended", par exemple : `EAX` = Extended Accumulator)

#### Si `64` bits :

les instructions sont préfixé de R (pour "register", par exemple : `RAX` = Register Accumulator)

## Flags

le plus important :
`ZF` (Zero Flag) : `ZF = 1` si resultat de l'operation précédente == 0, sinon `ZF = 0`

## Instructions

### Instructions basiques

| Instruction         | Definition | Description                                                | Exemple                      |
| ------------------- | ---------- | ---------------------------------------------------------- | ---------------------------- |
| `MOV <Dest>, <Src>` | Deplacer   | DEplace dans une destination (registre) la source (valeur) | `MOV AX, 1337` -> AX= `1337` |
| `ADD <Dest>, <Src>` | Ajouter    | Ajoute dans une destination la source                      | `ADD AX, 3` -> AX= `1340`    |
| `SUB <Dest>, <Src>` | Soustrait  | Soustrait dans une destination la source                   | `SUB AX, 340` -> AX= `1000`  |
| `INC <Dest>`        | Increment  | Incremente une destination                                 | `INC AX` -> AX= `1001`       |
| `DEC <Dest>`        | Decrement  | Decremente une destination                                 | `DEC AX` -> AX= `1000`       |
| `NEG <Dest>`        | Negative   | Rend negative la destination                               | `NEG AX` -> AX= `-1000`      |

Il existe aussi `MUL` (multiplier), `DIV` (diviser) etc...

### Instructions logiques

`NOT`, `OR`, `AND`, `XOR`, `NAND`, `NOR`...

### Instructions speciales

| Instruction    | Definition   | Description                                                | Exemple                                                                                  |
| -------------- | ------------ | ---------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `NOP`          | No operation | ne fait rien                                               |                                                                                          |
| `JMP EBX`      | Jump         | Saute vers une adresse memoire                             | `JMP EBX` -> Saut vers l'adresse stoqué dans la valeur de EBX                            |
| `CALL EBX`     | Appel        | --- mais reviens au flux initial apres                     | `CALL EBX` -> ---, puis une fois executé reviens à l'instruction suivant le call initial |
| `CMP EDI, ESI` | Comparer     | Compare valeur de dest et src, retourne 0 si égal          | `CMP EBX, ESI` -> Compare les valeurs stoqués dans EBX et ESI (Donc ZF == 1 si égal)     |
| `PUSH <value>` | Pousse       | Pousse une valeur au haut de la stack                      | `PUSH 0x42` -> Pousse `0x42` en haut de la pile                                          |
| `POP EAX`      | Recupere     | Recup la valeur dans EAX et passe a l'instruction suivante |                                                                                          |
| `INT 0x80`     | Stop         | Interuption systeme                                        |                                                                                          |

### Sauts conditionnets (if en gros)

| Instruction | Definition             | Description                                | Exemple |
| ----------- | ---------------------- | ------------------------------------------ | ------- |
| `JZ`        | Jump if Zero           | Jump si il y a pas de diff en regardant ZF | TODO    |
| `JNZ`       | Jump if **not** Zero   | Jump si il y a une diff en regardant ZF    | TODO    |
| `JE`        | Jump if equal          | Exactement pareil que `JZ`                 | TODO    |
| `JNE`       | Jump if **not** equal  | Exactement pareil que `JNZ`                | TODO    |
| `JA`        | Jump if above          | seulement pour unsigned                    | TODO    |
| `JB`        | Jump if below          | seulement pour unsigned                    | TODO    |
| `JG`        | Jump if greater        | seulement pour signed                      | TODO    |
| `JL`        | Jump if lower          | seulement pour signed                      | TODO    |
| `JLE`       | Jump if lower or equal |                                            | TODO    |

## La syntax

Elle depend de l'architecture _(ARM, x86, x16, x64, PowerPC)_

Les deux majeurs sont :

- Proc INTEL : `mov eax, ebx` (la plus commune)
- Proc AT&T : `movl %ebx, %eax`

**L'algo assembleur varie aussi en fonction de l'OS a cause des appels systemes entre autre !**

## Exemple

## Une boucle for classique

Code C++

```cpp
int num = 0;
for(int i = 0, i <= 10, i++) {
    num += i;
}
```

Équivalent assembleur (32 bits):

```asm
MOV ECX, 0           ; Initialise CX à zero (c'est le "int i = 0;" de la boucle)
MOV EBX, 0           ; Initialise BX à zero (notre variable "num")

for:                 ; Création d'un tag nommé "for"
    ADD EBX, ECX     ; On ajoute dans BX la valeur de CX (c'est la ligne "num +=i")
    INC ECX          ; On incremente CX (c'est le i++ de la boucle)
    CMP ECX, 10      ; Compare CX avec 10 (c'est le "i <= 10" de la boucle)
    JLE for          ; Si BX <= 10, Jump vers le debut de la boucle pour commencer une nouvelle itération

end:                 ; Sortie de la boucle
exit                 ; Fin du program
```
