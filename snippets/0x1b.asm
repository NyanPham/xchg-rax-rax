section .text
global _start

extern ExitProcess
	
_start:	
	mov		rax, .end_prog
	
	;====================
	; Start snippet
	;====================
	push	rax 
	ret 
	;====================
	; End snippet
	;====================
	
.break_not_ret:
	int 	3
			
.end_prog:

	xor		ecx, ecx 
	call	ExitProcess