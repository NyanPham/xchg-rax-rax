section .data 
	array db		4, 3, 7, 8, 6, 9, 2, 1, 5, 2
	
section .text
global _start

extern ExitProcess
	
_start:
	mov		rbx, array
	
	;====================
	; Start snippet
	;====================
	xor		eax, eax 
	xor		edx, edx 
.loop1:
	xlatb 	
	xchg 	rax, rdx 
	xlatb	
	xlatb	
	xchg 	rax, rdx 
	cmp		al, dl 
	jnz		.loop1
	
	xor 	eax, eax
.loop2:
	xlatb 
	xchg	rax, rdx 
	xlatb
	xchg	rax, rdx 
	cmp		al, dl
	jnz 	.loop2
	;====================
	; End snippet
	;====================
		
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 