section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x05
	
	;====================
	; Start snippet
	;====================
	dec      rax

	mov      rdx,rax
	shr      rdx,0x1
	or       rax,rdx

	mov      rdx,rax
	shr      rdx,0x2
	or       rax,rdx

	mov      rdx,rax
	shr      rdx,0x4
	or       rax,rdx

	mov      rdx,rax
	shr      rdx,0x8
	or       rax,rdx

	mov      rdx,rax
	shr      rdx,0x10
	or       rax,rdx

	mov      rdx,rax
	shr      rdx,0x20
	or       rax,rdx

	inc      rax
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 