echo compiling...
nasm -f elf64 src.asm -o compiled.o

echo linking...
ld compiled.o -o linked

echo running...
./linked

echo exit with code $?