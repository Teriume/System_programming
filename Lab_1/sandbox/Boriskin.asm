; Сборка:
;   nasm -f elf32 Boriskin.asm -o Boriskin.o
;   ld -m elf_i386 Boriskin.o -o Boriskin
;
; Выводит фамилию, имя, отчество, каждую строку с новой строки.

section .data
    fam db 'Борискин', 0x0A
    fam_len equ $ - fam

    name db 'Илья', 0x0A
    name_len equ $ - name

    pat db 'Отчество', 0x0A
    pat_len equ $ - pat

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, fam
    mov edx, fam_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, name_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, pat
    mov edx, pat_len
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
