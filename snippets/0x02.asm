section .text
global _start


extern ExitProcess

_start:
	mov		rax, 0xfffffffffffffffd
	
	;==================
	; Start snippet
	;==================
	neg 	rax 
	sbb		rax, rax 
	neg		rax 
	;==================
	; End snippet
	;==================
	
	int 	3
	
	xor 	ecx, ecx 
	call	ExitProcess