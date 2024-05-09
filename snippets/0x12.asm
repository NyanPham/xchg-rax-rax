
section .text 
global _start

extern ExitProcess

_start:	
	mov		rax, 86h
	mov		rdx, 0xd9
				
	;====================
	; Start snippet
	;====================
	mov		rcx, rdx 
	and		rdx, rax
	or		rax, rcx
	add		rax, rdx
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor		ecx, ecx 
	call	ExitProcess 