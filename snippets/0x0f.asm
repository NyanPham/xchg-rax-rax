section .data
	hello_str 		db	'Hello, World!',13,10,0
	
section .text 
global _start

extern ExitProcess

_start:	
	mov		rcx, 0fh
	lea		rsi, [rel hello_str]
	
	; al is the Initialization Vector (IV)
	mov		al, 54h
	
	;====================
	; Start snippet
	;====================
.loop:
	xor		byte [rsi], al
	lodsb	
	loop	.loop
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor		ecx, ecx 
	call	ExitProcess 