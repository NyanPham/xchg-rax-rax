section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x09
	
	;====================
	; Start snippet
	;====================
	mov		rdx, rax 
	dec		rax 
	and		rax, rdx 
	;====================
	; End snippet
	;====================
		
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 