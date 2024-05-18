section .data 
	array dq		4, 3, 7, 8, 6, 9, 2, 1, 5, 2
	
section .text
global _start

extern ExitProcess
	
_start:
	mov		rbx, array
	mov		rsi, 0x03
	mov		rdi, 0x05
	mov		rcx, 0x01
	mov		rdx, 0x02
		
	;====================
	; Start snippet
	;====================
	mov		qword [rbx + 8*rcx], 0
	mov		qword [rbx + 8*rdx], 1
	mov		rax, qword [rbx, 8*rcx]
	
	mov		qword [rbx], rsi
	mov		qword [rbx + 8], rdi
	mov		rax, qword [rbx + 8*rax]
	;====================
	; End snippet
	;====================
		
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 