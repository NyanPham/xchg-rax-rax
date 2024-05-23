section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x02
	
	;====================
	; Start snippet
	;====================
	bsf 	rcx, rax 
	
	mov		rdx, rax 
	dec		rdx 
	or		rdx, rax 
	
	mov		rax, rdx 
	inc		rax 
	
	mov		rbx, rdx 
	not		rbx 
	inc		rdx 
	and		rdx, rbx 
	dec		rdx 
	
	shr		rdx, cl
	shr		rdx, 1
	
	or		rax, rdx 
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 