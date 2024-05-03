# xchg rax, rax
CoreKiller: x64 Assembly for the advanced.
 
## Introduction
My journal of the x64 Assembly exploration upon the completion of Assembly Language Adventures. xchg rax, rax is a collection of riddles that Xorpd (the author) found throughout his years of reversing and writing assembly code. There are totally 40 snippets, which contain concepts about assembly, math and life. 

## Solutions

### Snippet [0x00](https://www.xorpd.net/pages/xchg_rax/snip_00.html)
```
xor      eax,eax
lea      rbx,[0]
loop     $
mov      rdx,0
and      esi,0
sub      edi,edi
push     0
pop      rbp
```	
Different ways to zero out general purpose registers.

### Snippet [0x01](https://www.xorpd.net/pages/xchg_rax/snip_01.html)
```
.loop:
    xadd     rax,rdx
    loop     .loop
```
Compute the Fibonacci sequence up to the nth element, where n is stored in the ecx register. 
The xadd instruction exchanges the values of rax and rdx, then adds the values and stores the sum in rax. In each iteration, the latest sum becomes the previous number for the next addition (by exchanging the values). 
The loop continues until ecx reaches 0. The result is in rax.
Before starting the loop, either rax or rdx is set to 1, and the other to 0.

