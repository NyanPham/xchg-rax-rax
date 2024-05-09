section .data
	string_1 		db	'Hello, World!',13,10,0
	string_2 		db	'Hello; World!',13,10,0
	
section .text 
global _start

extern ExitProcess

_start:	
	mov		rcx, 0fh
	mov		rsi, string_1
	mov		rdi, string_2
	xor		rax, rax
	xor		rdx, rdx 
	
	;====================
	; Start snippet
	;====================
.loop:
	mov		dl, byte [rsi]
	xor		dl, byte [rdi]
	inc		rsi
	inc		rdi
	or		al, dl
	loop	.loop
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor		ecx, ecx 
	call	ExitProcess 