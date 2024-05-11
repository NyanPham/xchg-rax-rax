section .text
global _start

extern ExitProcess
	
_start:
		
	;====================
	; Start snippet
	;====================
	call	.skip
	db	'hello world!',0
.skip:
	call	print_str 
	add		rsp, 8
	;====================
	; End snippet
	;====================	
	
	xor		ecx, ecx 
	call	ExitProcess