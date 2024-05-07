section .text 
global _start 

extern ExitProcess


_start:
	mov		rax, 14h
	
	;====================
	; Start snippet
	;====================
	shr		rax, 3
	adc		rax, 0
	;====================
	; End snippet
	;====================
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess