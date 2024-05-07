section .text 
global _start

extern ExitProcess


_start:
	mov		rax, 0xFFFFFFFFFFFFFFFF
	mov		rdx, 0xFFFFFFFFFFFFFFFF
	
	;====================
	; Start snippet
	;====================
	add		rax, rdx 
	rcr		rax, 1 
	;====================
	; End snippet
	;====================
		
	int		3

	xor		ecx, ecx 
	call	ExitProcess