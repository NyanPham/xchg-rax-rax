# xchg rax, rax
CoreKiller: x64 Assembly for the advanced.
 
## Introduction
My journal of the x64 Assembly exploration upon the completion of Assembly Language Adventures. xchg rax, rax is a collection of riddles that Xorpd (the author) found throughout his years of reversing and writing assembly code. There are totally 40 snippets, which contain concepts about assembly, math and life. 

## Solutions

### Snippet [[0x00]](https://www.xorpd.net/pages/xchg_rax/snip_00.html)
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

### Snippet [[0x01]](https://www.xorpd.net/pages/xchg_rax/snip_01.html)
```
.loop:
    xadd     rax,rdx
    loop     .loop
```
Compute the Fibonacci sequence up to the nth element, where n is stored in the `ecx` register.   
The xadd instruction exchanges the values of `rax` and `rdx`, then adds the values and stores the sum in `rax`. In each iteration, the latest sum becomes the previous number for the next addition (by exchanging the values).   
The loop continues until `ecx` reaches 0. The result is in `rax`.  
Before starting the loop, `rax` must be set to 0 and `rdx` to 1. 

### Snippet [[0x02]](https://www.xorpd.net/pages/xchg_rax/snip_02.html)
```
neg      rax
sbb      rax,rax
neg      rax
```
Check the value in the `rax` register to be non-zero or not. If it's non-zero, store 1 back in `rax`, 0 otherwise. 
`rax = (rax != 0 ? 1 : 0)`

### Snippet [[0x03]](https://www.xorpd.net/pages/xchg_rax/snip_03.html)
```
sub      rdx,rax
sbb      rcx,rcx
and      rcx,rdx
add      rax,rcx
```
Get the min value between `rdx` and `rax` registers. The result is stored in `rax`.  
`rax = min(rdx, rax)`

### Snippet [[0x04]](https://www.xorpd.net/pages/xchg_rax/snip_04.html)
```
xor      al,0x20
```
Toggle the 6th bit of the char, converting uppercase letters to lowercase and vice versa.

### Snippet [[0x05]](https://www.xorpd.net/pages/xchg_rax/snip_05.html)
```
sub      rax,5
cmp      rax,4
```
Check if a number in the `rax` register is between __5__ and __9__.  If in range, the instructions `jbe` or `jna` will execute. This snippet is a vague one.

If `rax` < 5, the `sub rax, 5` will result in negative number. However, the `jbe` instruction treats the result as an unsigned value. So the `cmp rax, 4` is between a large unsigned number with 4. The `jbe` condition is not met, and the jump won't occur.

If `rax` > 9, the `sub rax, 5` will result in larger number than 4. The `jbe` condition is not met, and the jump won't occur.

Finally, if `rax` is either 5, 6, 7, 8, 9, the `sub rax, 5` will be 0, 1, 2, 3, 4 respectively. Any of these differences satifies the condition of <= 4 when `cmp rax, 4`, thus the `jbe` condition is met, and the jump will occur.

### Snippet [[0x06]](https://www.xorpd.net/pages/xchg_rax/snip_06.html)
```
not      rax
inc      rax
neg      rax
```
The `not` instruction results in the 1's complement of a number. Then the `inc` adds 1 to it, convert the previous result to the 2's complement. So the combination of `not` and `inc` instructions is equivalent to a `neg` instruction. So the result above is NOTHING as two negations cancel out each other. The only thing changed is the flag. Indeed, the `neg` instruction set the CF flag to 0 if the operand is 0, 1 otherwise.

### Snippet [[0x07]](https://www.xorpd.net/pages/xchg_rax/snip_07.html)
```
inc      rax
neg      rax
inc      rax
neg      rax
```
Does nothing but wastes cycles as the 2 combinations of `inc` and `neg` cancel each other.

### Snippet [[0x08]](https://www.xorpd.net/pages/xchg_rax/snip_08.html)
```
add      rax,rdx
rcr      rax,1
``` 
Computes the average of two positive numbers or two negative numbers. The reason it supports negative is due to the `rcr` instruction as it prevent overflows: it shifts CF into the most-significant bit and shifts the least-significant bit into CF.

### Snippet [[0x09]](https://www.xorpd.net/pages/xchg_rax/snip_09.html)
```
shr      rax,3
adc      rax,0
```
Computes the `rax` / 8. Rounded up to the nearest integer with `adc rax, 0`.
