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
	mov		byte [rsi+8], 0x55
	mov		byte [rsi+9], 0x74
	mov		byte [rsi+10], 0x47
	mov		byte [rsi+11], 0x16
	mov		byte [rsi+12], 0x47
	mov		byte [rsi+13], 0x54
	mov		byte [rsi+14], 0x74
	mov		byte [rsi+15], 0x62
			
	mov		rcx, 0x0a
	;====================
	; Start snippet
	;====================
	lea		rdi, [rsi + 3]
	rep	movsb
	;====================
	; End snippet
	;====================
	
	add		rsp, 8*4 
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess