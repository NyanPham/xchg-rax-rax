section .text 
global _start

extern ExitProcess

_start:	
	mov		rax, 0ch
	mov		rbx, 15h
	mov		rcx, 20h
	
	;====================
	; Start snippet
	;====================
	mov		rdx, rbx
	
	xor 	rbx, rcx
	and		rbx, rax
	
	and		rdx, rax 
	and		rax, rcx
	xor		rax, rdx
	
	cmp		rax, rbx
	;====================
	; End snippet
	;====================
	jne		.not_equal
		
	int 	3

.not_equal:
	
	xor		ecx, ecx 
	call	ExitProcess 