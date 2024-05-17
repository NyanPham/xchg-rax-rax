section .text
global _start

extern ExitProcess
	
_start:	
	sub		rsp, 8*4
	
	lea		rsi, [rsp + 8*4]
	
	mov		byte [rsi+0], 0x76
	mov		byte [rsi+1], 0x29
	mov		byte [rsi+2], 0xbf
	mov		byte [rsi+3], 0xec
	mov		byte [rsi+4], 0x79
	mov		byte [rsi+5], 0x32
	mov		byte [rsi+6], 0xaf
	mov		byte [rsi+7], 0x35
	
	mov		rcx, 0x08
	;====================
	; Start snippet
	;====================
	clc
.loop:
	rcr		byte [rsi], 1 
	inc		rsi
	loop	.loop	
	
	;====================
	; End snippet
	;====================
	
	add		rsp, 8*4 
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess