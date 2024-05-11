section .data
	hello	db	'hello world!',13,10,0

section .text
global _start

extern ExitProcess
	
_start:	
	lea		rax, [rel hello]
	push	rax
	
	;====================
	; Start snippet
	;====================
	pop		rsp
	;====================
	; End snippet
	;====================
	
	add		rsp, 8*3
	
	xor		ecx, ecx 
	call	ExitProcess