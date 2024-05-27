section .text
global _start

extern ExitProcess
	
_start:
	mov		eax, 0xFFFFFFFD
	
	;====================
	; Start snippet
	;====================
	cdq
	shl		eax, 1
	and 	edx, 0xc0000401
	xor		eax, edx 
	;====================
	; End snippet
	;====================
	
	int 	3 

	xor 	ecx, ecx 
	call 	ExitProcess 