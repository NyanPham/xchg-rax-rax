section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x0b
		
	;====================
	; Start snippet
	;====================
	mov		rdx, rax 
	shr		rdx, 0x1
	xor		rax, rdx 
	
	mov		rdx, rax 
	shr		rdx, 0x2 
	xor		rax, rdx 
	
	mov		rdx, rax 
	shr		rdx, 0x4
	xor		rax, rdx 
	
	mov		rdx, rax 
	shr		rdx, 0x8 
	xor		rax, rdx 
	
	mov		rdx, rax 
	shr		rdx, 0x10
	xor		rax, rdx 
	
	mov		rdx, rax 
	shr		rdx, 0x20
	xor		rax, rdx 
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 