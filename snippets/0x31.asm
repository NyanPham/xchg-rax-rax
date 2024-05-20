section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x3
		
	;====================
	; Start snippet
	;====================
	mov		rcx, rax
	shr		rcx, 1 
	xor		rcx, rax 
		
	inc		rax 
	
	mov		rdx, rax 
	shr		rdx, 1
	xor		rdx, rax 
	
	xor		rdx, rcx 
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 