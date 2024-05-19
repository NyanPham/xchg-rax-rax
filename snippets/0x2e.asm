section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x00
	
	;====================
	; Start snippet
	;====================
	mov		rdx, rax 
	dec		rdx
	xor		rax, rdx 
	shr		rax, 1
	cmp		rax, rdx 
	;====================
	; End snippet
	;====================
	
	jne		.not_equal
	int 	3 
.not_equal:
	
	xor 	ecx, ecx 
	call 	ExitProcess 