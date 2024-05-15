section .text
global _start

extern ExitProcess
	
_start:	
	
	;====================
	; Start snippet
	;====================
	xor      eax,eax
    mov      rcx,1
    shl      rcx,0x20
.loop:
    movzx    rbx,cx
    imul     rbx,rbx

    ror      rcx,0x10
    movzx    rdx,cx
    imul     rdx,rdx
    rol      rcx,0x10

    add      rbx,rdx
    shr      rbx,0x20
    cmp      rbx,1
    adc      rax,0
    loop     .loop
	;====================
	; End snippet
	;====================
	
	int 	3
	
	xor		ecx, ecx 
	call	ExitProcess