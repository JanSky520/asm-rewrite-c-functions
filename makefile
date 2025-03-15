main: test.o print.o scan.o
	gcc -g -o main test.o print.o scan.o -no-pie

test.o: test.asm
	nasm -f elf64 -g -F dwarf test.asm -l test.lst

print.o: print.asm
	nasm -f elf64 -g -F dwarf print.asm -l print.lst

scan.o: scan.asm
	nasm -f elf64 -g -F dwarf scan.asm -l scan.lst