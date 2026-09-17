format ELF

section ".data" writeable
msg db 'Борискин Илья Васильевич', 10
msg_len = $ - msg

section ".text" executable
use32
public _start
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, msg_len
	int 0x80

	mov eax, 1
	xor ebx, ebx
	int 0x80
