section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x05
	
	;====================
	; Start snippet
	;====================
	mov      edx,eax
	and      eax,0x55555555
	shr      edx,0x1
	and      edx,0x55555555
	add      eax,edx

	mov      edx,eax
	and      eax,0x33333333
	shr      edx,0x2
	and      edx,0x33333333
	add      eax,edx

	mov      edx,eax
	and      eax,0x0f0f0f0f
	shr      edx,0x4
	and      edx,0x0f0f0f0f
	add      eax,edx

	mov      edx,eax
	and      eax,0x00ff00ff
	shr      edx,0x8
	and      edx,0x00ff00ff
	add      eax,edx

	mov      edx,eax
	and      eax,0x0000ffff
	shr      edx,0x10
	and      edx,0x0000ffff
	add      eax,edx
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 