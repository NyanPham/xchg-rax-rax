section .text
global _start

extern ExitProcess
	
_start:
		
	;====================
	; Start snippet
	;====================
	call	.next 
.next:
	pop		rax
	;====================
	; End snippet
	;====================	
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess