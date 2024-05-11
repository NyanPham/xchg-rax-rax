section .text
global _start

extern ExitProcess
	
_start:
	call	.next
.next:
	pop		rax
	
	;====================
	; Start snippet
	;====================
	push	rax 
	ret 
	;====================
	; End snippet
	;====================	
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess