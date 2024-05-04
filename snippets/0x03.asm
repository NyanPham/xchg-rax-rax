section .text
global _start

extern ExitProcess

_start:
	mov		rax, 7d
	mov		rdx, 3d
	
	;====================
	; Start snippet
	;====================
	sub 	rdx, rax 
	sbb		rcx, rcx 
	and		rcx, rdx
	add		rax, rcx 
	;====================
	; End snippet
	;====================
	
	int		3 
	
	xor 	ecx, ecx 
	call	ExitProcess