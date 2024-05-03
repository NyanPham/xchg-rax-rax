section .data
section .text
global _start

extern ExitProcess

_start:
	xor 	rax, rax 
	mov		rdx, 1
	
	mov		ecx, 12d
.loop:
    xadd     rax,rdx
    loop     .loop
	
    xor ecx, ecx ; uExitCode
    call ExitProcess
