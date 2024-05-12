section .data
	buff1	db	'I adore you!',0
	buff2	db	'I love you',0
		
	%assign	n	3
	
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