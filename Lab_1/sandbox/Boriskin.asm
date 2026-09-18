format ELF64

section ".data" writeable
fam db 'Борискин', 10
fam_len = $ - fam
name db 'Илья', 10
name_len = $ - name
pat db 'Васильевич', 10
pat_len = $ - pat

section ".text" executable
public _start
_start:
	; write(fileno=1, buf=fam, len=fam_len)
	mov rax, 1
	mov rdi, 1
	mov rsi, fam
	mov rdx, fam_len
	syscall

	; write name
	mov rax, 1
	mov rdi, 1
	mov rsi, name
	mov rdx, name_len
	syscall

	; write patronymic
	mov rax, 1
	mov rdi, 1
	mov rsi, pat
	mov rdx, pat_len
	syscall

	; exit(0)
	mov rax, 60
	xor rdi, rdi
	syscall
