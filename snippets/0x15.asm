section .text 
global _start

extern ExitProcess

_start:	
	mov		rax, 0x0000000083560000
	;====================
	; Start snippet
	;====================
	mov		rdx, 0xffffffff80000000
	add		rax, rdx 
	xor		rax, rdx 
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor		ecx, ecx 
	call	ExitProcess 