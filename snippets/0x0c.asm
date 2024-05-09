section .text 
global _start

extern ExitProcess

_start:	
	mov		rax, 15h
	mov		rbx, 0ch
	;====================
	; Start snippet
	;====================
	mov		rcx, rax 
	xor		rcx, rbx
	ror		rcx, 0xd
	
	ror		rax, 0xd
	ror		rbx, 0xd 
	xor		rax, rbx
	
	cmp		rax, rcx 
	;====================
	; End snippet
	;====================
	jne		.not_equal
	
	int 	3

.not_equal:
	
	xor		ecx, ecx 
	call	ExitProcess 