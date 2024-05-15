section .text
global _start

extern ExitProcess
	
_start:	
	mov		rax, 0x03
	
	;====================
	; Start snippet
	;====================
	mov		rbx, rax 
	mov		rsi, rax 
.loop:
	mul		rbx
	mov		rcx, rax 
	
	sub		rax, 2
	neg 	rax 
	mul		rsi
	mov		rsi, rax 
	
	cmp		rcx, 1
	ja		.loop
.exit_loop:
	;====================
	; End snippet
	;====================
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess