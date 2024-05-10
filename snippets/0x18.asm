section .text 
global _start

extern ExitProcess

_start:	
	xor		rax, rax 
	xor		rdx, rdx 

	;====================
	; Start snippet
	;====================
	rdtsc
	shl		rdx, 0x20
	or 		rax, rdx 
	mov		rcx, rax 
	
	rdtsc
	shl		rdx, 0x20
	or		rax, rdx 
	
	cmp		rcx, rax
	;====================
	; End snippet
	;====================
	
	int 	3
		
	xor		ecx, ecx 
	call	ExitProcess 