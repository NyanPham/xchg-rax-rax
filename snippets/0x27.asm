section .text
global _start

extern ExitProcess
	
_start:	
	mov		rax, 0x1D103DCDE0045312
	mov		rcx, 0x81
	
	;====================
	; Start snippet
	;====================
	mov		ch, cl
	inc		ch
	shr		ch, 1
	shr		cl, 1
	shr		rax, cl
	xchg	ch, cl
	shr		rax, cl
	;====================
	; End snippet
	;====================
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess