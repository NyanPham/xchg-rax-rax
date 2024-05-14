section .text
global _start 

extern ExitProcess

_start:
	mov		rax, 0x1c
	
	;====================
	; Start snippet
	;====================
.loop:
	cmp		rax, 5
	jbe		.exit_loop
	mov		rdx, rax 
	shr		rdx, 2 
	and		rax, 3
	add		rax, rdx 
	jmp		.loop
.exit_loop:

	cmp		rax, 3 
	cmc 
	sbb		rdx, rdx 
	and		rdx, 3
	sub		rax, rdx 
	;====================
	; End snippet
	;====================
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess