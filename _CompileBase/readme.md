# Compilation

Pour compiler, on utilise le package `nasm`, via la commande

```bash
nasm -f elf64 src.asm -o compiled.o
```

# Linkage

Pour executer notre code compiler, il faut le lier le fichier objet avec le package `ld`

```bash
ld compiled.o -o linked
```

# Tester

Enfin, il ne reste plus qu'a executer le fichier linké, pour voir le code retourné, on peut echo le resultat de la derniere commande avec

```bash
echo $?
```

## Pour tout executer en meme temps, utilisez le fichier `build.sh`
