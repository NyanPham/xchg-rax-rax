section .text 
global _start

extern ExitProcess

_start:	
	mov		rax, 0xfffffffffffffffd
	
	;====================
	; Start snippet
	;====================
	cqo
	xor		rax, rdx
	sub		rax, rdx
	;====================
	; End snippet
	;====================
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess 