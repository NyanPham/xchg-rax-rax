section .text
global _start

extern ExitProcess
	
_start:	
	mov		rax, 0x86
	
	;====================
	; Start snippet
	;====================
.loop:
	bsf		rcx, rax 
	shr		rax, cl
	cmp		rax, 1
	je		.exit_loop
	lea 	rax, [rax + 2*rax + 1]
	jmp	.loop
.exit_loop:
	;====================
	; End snippet
	;====================
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess