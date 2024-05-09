section .text 
global _start

extern ExitProcess

_start:	
	mov		rax, 4ah
	mov		rbx, 09h
	
	;====================
	; Start snippet
	;====================
	mov		rcx, rax 
	and		rcx, rbx
	not		rcx 
	
	not		rax
	not		rbx 
	or		rax, rbx 
	
	cmp		rax, rcx
	;====================
	; End snippet
	;====================
	jne		.not_equal
		
	int 	3

.not_equal:
	
	xor		ecx, ecx 
	call	ExitProcess 