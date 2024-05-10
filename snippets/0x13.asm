section .text 
global _start

extern ExitProcess

_start:	
	mov		rax, 6h
	mov		rbx, 1h
	;====================
	; Start snippet
	;====================
	mov		rcx, 0x40
.loop:
	mov		rdx, rax 
	xor		rax, rbx
	and		rbx, rdx 
	shl		rbx, 0x1 
	loop	.loop
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor		ecx, ecx 
	call	ExitProcess 