section .text
global _start

extern ExitProcess
	
_start:
	sub		rsp, 8*3
	
	mov		rax, 0x0c
	lea		rbx, [rsp + 8*3]
	
	mov		rcx, 0x0a
	mov		rdx, 1
.setloop:
	mov		byte [rbx], dl
	inc		dl
	inc		rbx
	loop	.setloop
	
	mov		rbx, [rsp + 8*3]
	
	; mov		byte [rbx], 0x01
	; mov		byte [rbx + 1], 0x02
	; mov		byte [rbx + 2], 0x03
	; mov		byte [rbx + 3], 0x04
	; mov		byte [rbx + 4], 0x05
	
	;====================
	; Start snippet
	;====================
	mov		rdx, rax 
	neg		rdx 
	and		rax, rdx 
	
	mov		rdx, 0x218a392cd3d5dbf
	mul		rdx 
	shr		rax, 0x3a
	
	xlatb
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	add		rsp, 8*3
	
	xor 	ecx, ecx 
	call 	ExitProcess 