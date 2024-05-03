section .data
section .text
global _start

extern ExitProcess

_start:
	xor      eax,eax
	lea      rbx,[0]
	loop     $
	mov      rdx,0
	and      esi,0
	sub      edi,edi
	push     0
	pop      rbp
	
    xor ecx, ecx ; uExitCode
    call ExitProcess
