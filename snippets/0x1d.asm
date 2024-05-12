section .data
	buff1	db	'aaaaaaaaaaaaaaa',0
	buff2	db	'bbbbbbbbbbbbbbb',0
			
	%assign	n	2
	
section .text
global _start

extern ExitProcess
	
_start:	
	;====================
	; Start snippet
	;====================
	mov		rsp, buff2 + n*8 + 8
	mov		rbp, buff1 + n*8
	
	enter 	0, n+1
	;====================
	; End snippet
	;====================
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess