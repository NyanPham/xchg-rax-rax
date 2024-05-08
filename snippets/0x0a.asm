section .text 
global _start

extern ExitProcess

_start:
	sub		rsp, 8*4 			; allocate 32 bytes for a number
	
	; Setting up the 32-byte number with all bytes to be 0xff
	mov		rdi, rsp 			
	mov		ecx, 8*4			
	
	mov		byte [rdi], 0xff	
.setup:							
	inc		rdi					
	mov		byte [rdi], 0xff
	loop	.setup	
	
	mov		rdi, rsp 			
	mov		ecx, 8*4			
	
	;====================
	; Start snippet
	;====================
	add		byte [rdi], 1	
.loop:
	inc		rdi
	adc		byte [rdi], 0
	loop	.loop
	;====================
	; End snippet
	;====================
	
	int 	3
	
	add		rsp, 8*4
	
	xor		ecx, ecx 
	call	ExitProcess 