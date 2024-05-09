section .text 
global _start

extern ExitProcess

_start:	
	mov		rax, 3h
	mov		rcx, 7h

	;====================
	; Start snippet
	;====================
	push	rax 
	push	rcx 
	pop		rax 
	pop		rcx 
	
	xor		rax, rcx 
	xor		rcx, rax 
	xor		rax, rcx 	
	
	add		rax, rcx 
	sub		rcx, rax 
	add		rax, rcx 
	neg		rcx 
	
	xchg	rax, rcx 
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor		ecx, ecx 
	call	ExitProcess 