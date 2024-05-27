section .text
global _start

extern ExitProcess
	
_start:
	mov		rax, 0x05
	mov		rdx, 0x03
	
	;====================
	; Start snippet
	;====================
	mov      rcx, 1
.loop:
    xor      rax, rcx
    not      rax
    and      rcx, rax
    not      rax

    xor      rdx, rcx
    not      rdx
    and      rcx, rdx
    not      rdx	
	
    shl      rcx, 1
    jnz      .loop
	;====================
	; End snippet
	;====================
		
	int 	3 

	xor 	ecx, ecx 
	call 	ExitProcess 