#!/usr/bin/env bash
set -euo pipefail

# Script to build the FASM and C binaries and produce Disassemble via gdb
# Run this inside a Linux environment with fasm, ld, gcc and gdb installed

cd "$(dirname "$0")"

echo "Building FASM binary..."
fasm Boriskin.asm Boriskin.o
ld -m elf_i386 Boriskin.o -o Boriskin

echo "Building C binary..."
gcc C_version.c -o C_version

echo "Generating Disassemble..."
gdb -batch -ex "set pagination off" -ex "disassemble _start" Boriskin > Disassemble
gdb -batch -ex "set pagination off" -ex "disassemble main" C_version >> Disassemble

echo "Disassemble written to: $(pwd)/Disassemble"
