section .text 
global _start

extern ExitProcess

_start:
	mov		rdx, 7h
	mov		rax, 3h
	
	;====================
	; Start snippet
	;====================
	not		rdx 
	neg		rax
	sbb		rdx, -1
	;====================
	; End snippet
	;====================
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess 