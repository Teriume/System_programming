# System Programming

Лабораторная работа 1: рабочее окружение, ассемблер и C.

## Что внутри
- `Lab_1/sandbox` — FASM-программа, C-программа, бинарники и дизассемблирование
- `Lab_1/Work` — задания по работе с файлами
- `Lab_1/Work_files` — команды, использованные при работе

## Проверка сборки
```bash
cd Lab_1/sandbox
fasm Boriskin.asm Boriskin.o
ld -m elf_i386 Boriskin.o -o Boriskin
gcc C_version.c -o C_version
./Boriskin
./C_version
```
