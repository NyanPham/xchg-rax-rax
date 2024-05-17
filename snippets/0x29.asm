section .text
global _start

extern ExitProcess
	
_start:	
	sub		rsp, 8*4
	
	lea		rsi, [rsp + 8*4]
	
	mov		dword [rsi], 0xecbf2976 
	mov		dword [rsi + 4], 0x35af3279
	
	mov		dword [rsi + 8], 0x47547462
	mov		dword [rsi + 12], 0x55744716
			
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