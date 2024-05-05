section .text
global _start 

extern ExitProcess

_start:
	mov		rax, 9
	
	;==================
	; Start snippet
	;==================
	sub		rax, 5
	cmp		rax, 4
	;==================
	; End snippet
	;==================
	
	jbe		.in_range_5_9
	jmp		.end_prog
.in_range_5_9:
	int 	3
	
.end_prog:
	xor 	ecx, ecx 
	call	ExitProcess
	