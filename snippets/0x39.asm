section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x08
	
	;====================
	; Start snippet
	;====================
	mov 	rdx, 0xaaaaaaaaaaaaaaaa
	add		rax, rdx 
	xor		rax, rdx 
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 