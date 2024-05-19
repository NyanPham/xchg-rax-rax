section .text
global _start

extern ExitProcess
	
_start:
	mov		rcx, 0x08
	
	;====================
	; Start snippet
	;====================
	xor		eax, eax 
.loop:
	jrcxz	.exit_loop
	inc		rax 
	mov		rdx, rcx 
	dec		rdx 
	and		rcx, rdx
	jmp		.loop
.exit_loop:
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 