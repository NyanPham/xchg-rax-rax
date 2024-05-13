section .text
global _start

extern ExitProcess
	
_start:	
	mov		rax, 0x5e
		
	;====================
	; Start snippet
	;====================
	mov		rcx, rax 
	shl		rcx, 2 
	add		rcx, rax 
	shl		rcx, 3
	add		rcx, rax 
	shl		rcx, 1
	add		rcx, rax 
	shl		rcx, 1
	add		rcx, rax 
	shl		rcx, 3
	add		rcx, rax
	;====================
	; End snippet
	;====================
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess