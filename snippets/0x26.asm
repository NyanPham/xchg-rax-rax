section .text
global _start

extern ExitProcess
	
_start:	
	mov		rax, 0x1D103DCDE0045312
	mov		rcx, rax 
	mov		rbx, rax 
	
	;====================
	; Start snippet
	;====================
	mov		rdx, rax 
	shr		rax, 7
	shl		rdx, 0x39 
	or		rax, rdx 
	
	;====================
	; End snippet
	;====================
	ror		rcx, 7
	rol		rbx, 0x39
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess