section .text
global _start

extern ExitProcess
	
_start:	
	mov		rax, 0x5e
	mov		rbx, 0x12
	mov		rcx, 0xc7
	mov		rdx, 0x20
		
	;====================
	; Start snippet
	;====================
	mov		rsi, rax 
	add		rax, rbx
	mov		rdi, rdx 
	sub		rdx, rcx 
	add		rdi, rcx 
	
	imul	rax, rcx 
	imul	rsi, rdx 
	imul	rdi, rbx
	
	add		rsi, rax 
	mov		rbx, rsi
	sub		rax, rdi
	;====================
	; End snippet
	;====================
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess