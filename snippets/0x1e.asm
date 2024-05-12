format PE console
entry _start

include 'include/win32a.inc' 

section '.text' code readable executable

_start:
	xor		eax, eax 
	mov		al, 0x03
		
	;====================
	; Start snippet
	;====================
	cmp		al, 0x0a 
	sbb		al, 0x69
	das
	
	;====================
	; End snippet
	;====================
		
	int 	3
	
	push	0
	call	[ExitProcess]
	
section '.idata' import data readable

library	kernel32,'kernel32.dll'
		
import 	kernel32,\
		ExitProcess,'ExitProcess'
