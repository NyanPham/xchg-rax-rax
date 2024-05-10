section .text 
global _start

extern ExitProcess

_start:	
	mov		rax, 0xcf
	mov		rbx, 8ch
	mov		rcx, 18h
	
	;====================
	; Start snippet
	;====================
	xor		rax, rbx
	xor		rbx, rcx 
	mov		rsi, rax 
	add		rsi, rbx
	cmovc	rax, rbx
	xor		rax, rbx 
	cmp		rax, rsi
	;====================
	; End snippet
	;====================
	
	jl		.less
	jmp		.end_prog
	
.less:
	mov		rax, 1 
	
.end_prog:	
	xor		ecx, ecx 
	call	ExitProcess 