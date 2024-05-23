section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0xdeadbeef
	
	;====================
	; Start snippet
	;====================
	mov		rdx, rax 
	not		rdx
	mov		rcx, 0x8080808080808080
	and		rdx, rcx 
	mov		rcx, 0x0101010101010101
	sub		rax, rcx 
	and		rax, rdx 
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 