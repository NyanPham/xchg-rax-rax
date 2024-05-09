# xchg rax, rax
CoreKiller: x64 Assembly for the advanced.
 
## Introduction
My journal of the x64 Assembly exploration upon the completion of Assembly Language Adventures. xchg rax, rax is a collection of riddles that Xorpd (the author) found throughout his years of reversing and writing assembly code. There are totally 0x40 snippets, which contain concepts about assembly, math and life. 

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
Computes the average of two positive numbers or two negative numbers. The reason it supports negative is due to the `rcr` instruction as it prevents overflow: it shifts CF into the most-significant bit and shifts the least-significant bit into CF (doing the 33-bit rotation with CF).

### Snippet [[0x09]](https://www.xorpd.net/pages/xchg_rax/snip_09.html)
```
shr      rax,3
adc      rax,0
```	
Computes the `rax / 8`. Rounded up to the nearest integer with `adc rax, 0`.

### Snippet [[0x0a]](https://www.xorpd.net/pages/xchg_rax/snip_0a.html)
```
  add      byte [rdi],1
.loop:	
    inc      rdi	
    adc      byte [rdi],0
    loop     .loop
```
Increments by one the number pointed at by the `rdi` register, which is an `rcx` byte long integer.

### Snippet [[0x0b]](https://www.xorpd.net/pages/xchg_rax/snip_0b.html)
```
not      rdx
neg      rax
sbb      rdx,-1
```
If `rax` is 0, the `neg` operation is performed on the `rdx`. Otherwise, the `not` operation is performed.
Application: Negate a 16-byte integer in `rdx:rax` registers.

### Snippet [[0x0c]](https://www.xorpd.net/pages/xchg_rax/snip_0c.html)
```
mov      rcx,rax
xor      rcx,rbx
ror      rcx,0xd

ror      rax,0xd
ror      rbx,0xd
xor      rax,rbx

cmp      rax,rcx
```
`rax` and `rcx` have the same value from the beginning, and also in the end due to the associative property of the `xor` operation.

```
rcx = rax 
rcx = (rcx ^ rbx) >> 13
rax = (rax >> 13) ^ (rbx >> 13)
```

### Snippet [[0x0d]](https://www.xorpd.net/pages/xchg_rax/snip_0d.html)
```
mov      rdx,rbx

xor      rbx,rcx
and      rbx,rax

and      rdx,rax
and      rax,rcx
xor      rax,rdx

cmp      rax,rbx
```
`rax` and `rbx` have the same value in the end regardless of their initial values thanks to the distributive property of the `and` and `xor` operations.

```
rdx = rbx
rbx = (rbx ^ rcx) & rax
rax = (rdx & rax) ^ (rcx & rcx)
```

### Snippet [[0x0e]](https://www.xorpd.net/pages/xchg_rax/snip_0e.html)
```
mov      rcx,rax
and      rcx,rbx
not      rcx

not      rax
not      rbx
or       rax,rbx

cmp      rax,rcx
```
Boolean Algebra with DeMorgan's law.
```
rcx = rax 
rcx = ~(rcx & rbx)
rax = ~rax | ~rbx
```

### Snippet [[0x0f]](https://www.xorpd.net/pages/xchg_rax/snip_0f.html)
```
.loop:
    xor      byte [rsi],al
    lodsb
    loop     .loop
```
Resembles an 8-bit CBC mode block cipher. the IV is initialized in the `al` register, that plays an important role as a key to cipher text.

```
string[0] = string[0] ^ al
string[1] = string[1] ^ string[0]
string[2] = string[2] ^ string[1]
string[3] = string[3] ^ string[2]
...
```

### Snippet [[0x10]](https://www.xorpd.net/pages/xchg_rax/snip_10.html)
```
push     rax
push     rcx
pop      rax
pop      rcx

xor      rax,rcx
xor      rcx,rax
xor      rax,rcx

add      rax,rcx
sub      rcx,rax
add      rax,rcx
neg      rcx

xchg     rax,rcx
```
Different ways to exchange values of `rax` and `rcx`.

### Snippet [[0x11]](https://www.xorpd.net/pages/xchg_rax/snip_11.html)
```
.loop:
    mov      dl,byte [rsi]
    xor      dl,byte [rdi]
    inc      rsi
    inc      rdi
    or       al,dl
    loop     .loop
```
Compare two strings pointed at by `rsi` and `rdi` of `rcx` bytes in length. `al` is remained 0 if both buffers have no differences (`al` must be zero initialized before the loop).

### Snippet [[0x12]](https://www.xorpd.net/pages/xchg_rax/snip_12.html)
```
mov      rcx,rdx
and      rdx,rax
or       rax,rcx
add      rax,rdx
```
Computes `rax + rdx` through logical operators.
```
(rax | rdx) + (rax & rdx) = rax + rdx
```


