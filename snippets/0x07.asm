section .text 
global _start

extern ExitProcess


_start:
	mov		rax, 7h
	
	;====================
	; Start snippet
	;====================
	inc		rax
	neg		rax 
	inc		rax 
	neg		rax 
	;====================
	; End snippet
	;====================
	
	int		3

	xor		ecx, ecx 
	call	ExitProcess