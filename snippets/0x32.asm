section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x4
		
	;====================
	; Start snippet
	;====================
	mov		rcx, rax 
	
	mov		rdx, rax 
	shr		rdx, 1
	xor		rax, rdx 
	
	popcnt	rax, rax 
	xor		rax, rcx 
	and		rax, 1
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 