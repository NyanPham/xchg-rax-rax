section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x3E06EDA3
	
	;====================
	; Start snippet
	;====================
	mov      ecx,eax
	and      ecx,0xffff0000
	shr      ecx,0x10
	and      eax,0x0000ffff
	shl      eax,0x10
	or       eax,ecx

	mov      ecx,eax
	and      ecx,0xff00ff00
	shr      ecx,0x8
	and      eax,0x00ff00ff
	shl      eax,0x8
	or       eax,ecx

	mov      ecx,eax
	and      ecx,0xcccccccc
	shr      ecx,0x2
	and      eax,0x33333333
	shl      eax,0x2
	or       eax,ecx

	mov      ecx,eax
	and      ecx,0xf0f0f0f0
	shr      ecx,0x4
	and      eax,0x0f0f0f0f
	shl      eax,0x4
	or       eax,ecx

	mov      ecx,eax
	and      ecx,0xaaaaaaaa
	shr      ecx,0x1
	and      eax,0x55555555
	shl      eax,0x1
	or       eax,ecx
	;====================
	; End snippet
	;====================
	
	int 	3 
	
	xor 	ecx, ecx 
	call 	ExitProcess 