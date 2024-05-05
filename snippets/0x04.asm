section .text
global _start

extern ExitProcess


_start:
	xor 	rax, rax 
	mov		al, 'n'
	
	;==================
	; Start snippet
	;==================
	xor 	al, 0x20
	;==================
	; End snippet
	;==================
	
	int		3
	
	xor 	ecx, ecx
	call	ExitProcess