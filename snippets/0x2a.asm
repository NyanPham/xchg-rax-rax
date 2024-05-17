section .text
global _start

extern ExitProcess
	
_start:	
	sub		rsp, 8*8
	
	lea		rsi, [rsp + 8*8]
	
	mov		qword [rsi + 8*0], 0x1
	mov		qword [rsi + 8*1], 0x2
	mov		qword [rsi + 8*2], 0x3
	mov		qword [rsi + 8*3], 0x4
	mov		qword [rsi + 8*4], 0x5
	mov		qword [rsi + 8*5], 0x6
	mov		qword [rsi + 8*6], 0x7
	mov		qword [rsi + 8*7], 0x8
	
	lea		rbx, [rsi + 8*0]
	mov		rcx, 0x08
	
	;====================
	; Start snippet
	;====================
	mov		rsi, rbx
	mov		rdi, rbx
.loop:
	lodsq
	xchg	rax, qword [rbx]
	stosq 
	loop	.loop
	;====================
	; End snippet
	;====================
		
	add		rsp, 8*8
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess