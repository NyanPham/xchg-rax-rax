section .text
global _start

extern ExitProcess

_start:
	mov		rax, 0x2
	
	;====================
	; Start snippet
	;====================
	mov		rdx, rax 
	shr		rdx, 1
	xor		rax, rdx 
	
	popcnt	rax, rax 
	and		rax, 0x3
	;====================
	; End snippet
	;====================
	
	int 	3

	xor		ecx, ecx 
	call	ExitProcess