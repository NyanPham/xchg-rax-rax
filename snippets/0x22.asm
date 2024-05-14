section .text
global _start 

extern ExitProcess

_start:
	mov		rax, 0xffffab
	
	;====================
	; Start snippet
	;====================
	mov		rdx, 0xaaaaaaaaaaaaaaab
	mul		rdx,
	shr		rdx, 1
	mov		rax, rdx 
	;====================
	; End snippet
	;====================
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess