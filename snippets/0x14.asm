section .text 
global _start

extern ExitProcess

_start:	
	mov		rax, 0ch
	mov		rdx, 0fh
	
	;====================
	; Start snippet
	;====================
	mov		rcx, rax 
	and		rcx, rdx 
	
	xor		rax, rdx 
	shr		rax, 1
	
	add		rax, rcx 
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor		ecx, ecx 
	call	ExitProcess 