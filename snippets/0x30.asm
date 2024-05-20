section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x5
	mov		rdx, 0x2
		
	;====================
	; Start snippet
	;====================
	and		rax, rdx 
	
	sub		rax, rdx 
	and		rax, rdx 
	
	dec		rax 
	and		rax, rdx 
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 