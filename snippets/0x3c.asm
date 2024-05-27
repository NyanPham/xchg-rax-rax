section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x05
	
	;====================
	; Start snippet
	;====================
	mov		rbx, rax 
	mov		rdx, rbx 
	mov		rcx, 0xaaaaaaaaaaaaaaaa
	and		rbx, rcx 
	shr		rbx, 1
	and		rbx, rdx 
	popcnt	rbx, rbx 
	and		rbx, 1
	
	neg 	rax
	mov		rdx, rax 
	mov		rcx, 0xaaaaaaaaaaaaaaaa
	and		rax, rcx 
	shr		rax, 1
	and		rax, rdx 
	popcnt	rax, rax 
	and		rax, 1
	
	mov		rdx, rax 
	add		rax, rbx
	dec		rax
	neg		rax
	sub		rdx, rbx
	;====================
	; End snippet
	;====================
	
	int 	3 

	xor 	ecx, ecx 
	call 	ExitProcess 