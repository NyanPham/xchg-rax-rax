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
Toggle the 6th bit of the char (bit at index 5), converting uppercase letters to lowercase and vice versa.

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
rax = (rdx & rax) ^ (rcx & rax)
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

### Snippet [[0x13]](https://www.xorpd.net/pages/xchg_rax/snip_13.html)
```
    mov      rcx,0x40
.loop:
    mov      rdx,rax
    xor      rax,rbx
    and      rbx,rdx
    shl      rbx,0x1
    loop     .loop
```
Computes `rax = rax + rbx`, using a set of recursive logical operations.

This resembles the implementation of an adder in electronics. `xor` is to find the output of a bit, `and` is to detect a carry for more siginificant bit position.

### Snippet [[0x14]](https://www.xorpd.net/pages/xchg_rax/snip_14.html)
```
mov      rcx,rax
and      rcx,rdx

xor      rax,rdx
shr      rax,1

add      rax,rcx
```
Computes the average between `rax` and `rdx`, rounded to the lowest integer and stored in `rax`.

`(rax & rdx) + ((rax ^ rdx) / 2) = (rax + rdx) / 2`

### Snippet [[0x15]](https://www.xorpd.net/pages/xchg_rax/snip_15.html)
```
mov      rdx,0xffffffff80000000
add      rax,rdx
xor      rax,rdx
```
Extends 32-bit content in `eax` to 64-bit in `rax`, preserving the sign. The upper half of `rax` is assumed to be zero.

If `eax` is negative, `add` instruction overflows the 33th bit of `rax` (the lowest bit in upper half), causing all upper half to be zero. Then `xor` to restore the upper half of `rdx` to negative.

If `eax` is positive, the overflow never occurs after `add` instruction. Then `xor` to remove the upper half of `rdx`, leaving `rax` stay positive.

### Snippet [[0x16]](https://www.xorpd.net/pages/xchg_rax/snip_16.html)
```
xor      rax,rbx
xor      rbx,rcx
mov      rsi,rax
add      rsi,rbx
cmovc    rax,rbx
xor      rax,rbx
cmp      rax,rsi
```
Computes `rax` to be either 0 or `rax ^ rcx`
```
rsi = (rax ^ rbx) + (rbx ^ rcx)
if (CF == 1)
	rax = (rbx ^ rcx) // (cmovc)
	rax = (rbx ^ rcx) ^ (rbx ^ rcx) // (xor rax, rbx)
	rax = 0
else
	rax = ((rax ^ rbx) + (rbx ^ rcx)) ^ (rbx ^ rcx) // (xor rax, rbx)
	rax = ((rax ^ rbx) ^ (rbx ^ rcx)) + ((rbx ^ rcx) ^ (rbx ^ rcx)) (distributive)
	rax = ((rax ^ rbx) ^ (rbx ^ rcx)) + 0 
	rax = rax ^ rcx
```
Application: unknown.

### Snippet [[0x17]](https://www.xorpd.net/pages/xchg_rax/snip_17.html)
```
cqo
xor      rax,rdx
sub      rax,rdx
```
Computes the absolute value of `rax`.
`rax = |rax|`

`cqo` sets all bits in `rdx` to 1 if `rax` is negative, 0 otherwise.
If `rax` is negative, `rdx` is 0xffffffffffffffff, then `xor rax, rdx` results in `not rax`. And subtracting `rdx` (-1) converts `rax` to the 2's complement of the original value.
If `rax` is positive, `rdx` is set to 0, both following operations `xor rax, rdx`, `sub rax, rdx` do nothing.

### Snippet [[0x18]](https://www.xorpd.net/pages/xchg_rax/snip_18.html)
```
rdtsc
shl      rdx,0x20
or       rax,rdx
mov      rcx,rax

rdtsc
shl      rdx,0x20
or       rax,rdx

cmp      rcx,rax
```
Compares two timestamps.
`rdtsc` reads the 64-bit timestamp, and stores it in `edx:eax`.
Shift `rdx` 32 bits to the left and merge them to the upper half of `rax`. We end up the 64-bit of timestamp stored in `rax`.

The first timestamp is stored in `rcx`, which is then used to compared the later timestamp in `rax`. Of course, `rax` is always larger than `rcx`.

### Snippet [[0x19]](https://www.xorpd.net/pages/xchg_rax/snip_19.html)
```
    call     .skip
    db       'hello world!',0
.skip:
    call     print_str
    add      rsp,8
```
Call `print_str("hello world!");`

The instruction `call .skip` pushes the address of the string `hello world!` to the stack, an argument in the external subroutine `print_str`. `add rsp, 8` cleans the stack without returning after `.skip`.

### Snippet [[0x1a]](https://www.xorpd.net/pages/xchg_rax/snip_1a.html)
```
    call     .next
.next:
    pop      rax
```
Gets the current instruction pointer `rip` and stores it into `rax`. `rax = .next`

### Snippet [[0x1b]](https://www.xorpd.net/pages/xchg_rax/snip_1b.html)
```
push     rax
ret
```
Jumps to the address stored in `rax`.
`rip = rax` or `jmp rax`.

### Snippet [[0x1c]](https://www.xorpd.net/pages/xchg_rax/snip_1c.html)
```
pop      rsp
```
Loads the value on top of the stack `rsp` to `rsp`.

### Snippet [[0x1d]](https://www.xorpd.net/pages/xchg_rax/snip_1d.html)
```
mov      rsp,buff2 + n*8 + 8
mov      rbp,buff1 + n*8
enter    0,n+1
```
Copies `buff1` to `buff2`.

`mov 	rsp, buff2 + n*8 + 8`: Load the address of `buff2 + n*8 + 8` to the stack pointer. +8 adjustment accounts for the effect of `enter` instruction, which subtracts 8 bytes from `rsp`.  

`mov	rbp, buff1 + n*8`: Load the address `buff1 + n*8` to the base frame pointer, setting up the current frame for copying.
  
`enter	0, n+1`: 
- First, subtracts 8 from `rsp`and stores the address `buff1 + n*8` into the stack at address `buff2 + n*8`. We still have a stack frames from address `buff2` to `buff2 + n*8` to copy the contents of `buff1`. 
- Next, loads the address `buff2 + n*8` into `rbp`, effectively setting up the current frame for copying. `rbp` now has access to the previous stack frames, `buff1 + n*8` which is the address content stored at `buff2 + n*8`.
- `n+1` is the nesting level, which is utilized to copy the value pointed by address stored in `rbp`.
This means it copies the frames of (`buff1->buff1 + n*8`) to its current frame (`buff2->buff2 + n*8`).

### Snippet [[0x1e]](https://www.xorpd.net/pages/xchg_rax/snip_1e.html)
```
cmp      al,0x0a
sbb      al,0x69
das
```
Converts `al` from 0x00 to 0x0f to their corresponding Hexadecimal ASCII code.

### Snippet [[0x1f]](https://www.xorpd.net/pages/xchg_rax/snip_1f.html)
```
.loop:
    bsf      rcx,rax
    shr      rax,cl
    cmp      rax,1
    je       .exit_loop
    lea      rax,[rax + 2*rax + 1]
    jmp      .loop
.exit_loop:
```
__Collatz conjecture__   
For each iteration in `.loop`, the snippet does the following operations:
- Searches for the index of the first set least significant bit of `rax`, starting at index 0. Stores the index in `rcx`.
- Shift `rax` to the right `cl` times. This effectively divides `rax` by 2^cl, making `rax` an odd number.
- Computes the new `rax`: `rax = (rax * 3) + 1`
- Repeats until `rax = 1`

### Snippet [[0x20]](https://www.xorpd.net/pages/xchg_rax/snip_20.html)
```
mov      rcx,rax
shl      rcx,2
add      rcx,rax
shl      rcx,3
add      rcx,rax
shl      rcx,1
add      rcx,rax
shl      rcx,1
add      rcx,rax
shl      rcx,3
add      rcx,rax
```
Computes `rcx = 1337 * rax`.

### Snippet [[0x21]](https://www.xorpd.net/pages/xchg_rax/snip_21.html)
```
mov      rsi,rax
add      rax,rbx
mov      rdi,rdx
sub      rdx,rcx
add      rdi,rcx

imul     rax,rcx
imul     rsi,rdx
imul     rdi,rbx

add      rsi,rax
mov      rbx,rsi
sub      rax,rdi
```
Resembles the multiplication of 2 complex numbers:
```
(a + bi)(c + di) = (ac - bd) + (ad + bc)i
```
```
rax = rax*rcx - rbx*rdx 
rbx = rax*rdx + rbx*rcx
```

TODO: Learn more about Complex Number, Karatsuba Algorithm.

### Snippet [[0x22]](https://www.xorpd.net/pages/xchg_rax/snip_22.html)
```
mov      rdx,0xaaaaaaaaaaaaaaab
mul      rdx
shr      rdx,1
mov      rax,rdx
```
Divides `rax` by 3, rounded down to the closest integer.

`rax = rax / 3`

### Snippet [[0x23]](https://www.xorpd.net/pages/xchg_rax/snip_23.html)
```
.loop:
    cmp      rax,5
    jbe      .exit_loop
    mov      rdx,rax
    shr      rdx,2
    and      rax,3
    add      rax,rdx
    jmp      .loop
.exit_loop:

    cmp      rax,3
    cmc
    sbb      rdx,rdx
    and      rdx,3
    sub      rax,rdx
```
Computes `rax` modulo 3.

`rax = rax % 3`

The snippet uses the base 4 to compute the modulo. The reason why we use base 4 is that `4 % 3 = 1`, and raising 4 to any power always results in a number that is % 3 = 1.

The loop adds each digit in base 4, reduces into `rax`:
- Set `rdx=rax` (preserve the current content in `rax`).
- Isolate the least siginificant 2 bits (1 digit in base 4) with `and rax, 3`.
- Shift the next digit into place for addition with `shr rdx, 2`.
- Add the isolated digit into the shifted content, then stored in `rax`. 
- Repeats untils `rax` is reduced into the range between 0 and 5.

Exit the loop:
- Compare the reduced value with 3.
- There are 2 cases: 
	- If the value is less than 3 (0, 1, 2), the remainder is the value subtracts 0 (is the value itself).
	- If the value is larger or equal to 3 (3, 4, 5), the remainder is the value subtracts 3.
- The minuend of either 0 or 3 is determined thanks to the `cmc` instruction to set the contents of `rdx`.

TODO: Review this

### Snippet [[0x24]](https://www.xorpd.net/pages/xchg_rax/snip_24.html)
```
    mov      rbx,rax
    mov      rsi,rax
.loop:
    mul      rbx
    mov      rcx,rax

    sub      rax,2
    neg      rax
    mul      rsi
    mov      rsi,rax

    cmp      rcx,1
    ja       .loop
.exit_loop:
```
Pseudo code: (assume `rax` is a)
```
b = a 
c = a
do {
	c = a * b
	b = b * (2 - c)
} while (c > 1);
```
The snippet computes the multiplicative inverse via Newtons' method.

In each iteration, the number of bits doubles. So when `cmp rcx, 1`, `ja` condition is met when `rcx` set its most siginificant bit (64). So this finds the multiplicative inverse of `rax` modulo 2^64.

TODO: Learn more about multiplicative inverse.

Reference: [ModInverse](https://marc-b-reynolds.github.io/math/2017/09/18/ModInverse.html)

### Snippet [[0x25]](https://www.xorpd.net/pages/xchg_rax/snip_25.html)
```
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
```
In the beginning, `rcx = 0x100000000` 

In each iteration:
	- `movzx rbx, cx`: Isolate the lower 2 bytes of `ecx` into `rbx`. Call it X.
	- `imul rbx, rbx`: X^2
	
	- `ror rcx, 0x10`: Align the upper 2 bytes of `ecx` into place, lower 2 bytes preserved.
	- `movzx rdx, cx`: Isolate the 2 bytes into `rdx`. Call it Y.
	- `imul rdx, rdx`: Y^2
	- `rol rcx, 0x10`: Restore the content in `rcx`.
	
	- `add rbx, rdx`: X^2 + Y^2. Each X or Y is [0, 0xffff], so result is between 0 and 0x1FFFC0002. 
	- `shr rbx, 0x20`: Shifting the bit 32th to the right. So `rbx` is either 0 or 1.
	- `cmp rbx, 1`: Set the carry flag accordingly. 
	- `adc rax, 0`: Increment `rax` by 1 if X^2 + Y^2 < 0x100000000 (0x10000^2).
	
Summary:
	We have a circle whose radius is 0x10000, centered at the origin (0, 0).  `ecx` holds a point coordinate (X, Y), where each X,Y is in range [0, 0xffff].  The `loop .loop` instruction decrement `ecx`, moving the check to the next point.  Computes the length^2 from the origin of the circle to the point (X,Y) using Pythagorean algorithm.  If length^2 < radius^2 (0x10000^2, or 0x100000000), increment the counter `rax`. In the end `rax` holds the number of the points that lie inside the circle.
	
### Snippet [[0x26]](https://www.xorpd.net/pages/xchg_rax/snip_26.html)
```
mov      rdx,rax
shr      rax,7
shl      rdx,0x39
or       rax,rdx
```
Computes `ror rax, 7`, or `rol rax, 0x39`
	
### Snippet [[0x27]](https://www.xorpd.net/pages/xchg_rax/snip_27.html)
```
mov      ch,cl
inc      ch
shr      ch,1
shr      cl,1
shr      rax,cl
xchg     ch,cl
shr      rax,cl
```
Computes `rax = rax >> ((cl / 2) + ((cl + 1) / 2))`

### Snippet [[0x28]](https://www.xorpd.net/pages/xchg_rax/snip_28.html)
```
    clc
.loop:
    rcr      byte [rsi],1
    inc      rsi
    loop     .loop
```
Divides by 2 an __arbitrarily long__ `rcx` bytes integer pointed by `rsi`, rounded down the nearest integer.

### Snippet [[0x29]](https://www.xorpd.net/pages/xchg_rax/snip_29.html)
```
lea 	rdi,[rsi + 3]
rep movsb
```
Replaces the buffer pointed by `rsi` with the pattern of the first 3 bytes of the buffer.

### Snippet [[0x2a]](https://www.xorpd.net/pages/xchg_rax/snip_2a.html)
```
    mov      rsi,rbx
    mov      rdi,rbx
.loop:
    lodsq
    xchg     rax,qword [rbx]
    stosq
    loop     .loop
```
Rotates right 8 bytes of a buffer pointed by `rsi`. The number of bytes of the buffer is stored in `rcx`.
In other words, it moves the last qword in `ecx`-length qword array to the front.

### Snippet [[0x2b]](https://www.xorpd.net/pages/xchg_rax/snip_2b.html)
```
    xor      eax,eax
    xor      edx,edx
.loop1:
    xlatb
    xchg     rax,rdx
    xlatb
    xlatb
    xchg     rax,rdx
    cmp      al,dl
    jnz      .loop1

    xor      eax,eax
.loop2:
    xlatb
    xchg     rax,rdx
    xlatb
    xchg     rax,rdx
    cmp      al,dl
    jnz      .loop2
```
Find duplicates in an array, utilizing Floyd's Tortoise and Hare algorithm.
- `eax` is Tortoise, `edx` is Hare.
- Loop 1: find the meeting point of Tortoise and Hare in the cycle.
- Loop 2: find the start of the cycle, which is the duplicate value.

TODO: Learn more about the algorithm.

References: 
[Wiki: Floyd's Tortoise and Hare](https://en.wikipedia.org/wiki/Cycle_detection#Floyd's_tortoise_and_hare)  
[YouTube: Floyd's cycle detection algorithm (Tortoise and hare) - Inside code](https://youtu.be/PvrxZaH_eZ4)

### Snippet [[0x2c]](https://www.xorpd.net/pages/xchg_rax/snip_2c.html)
```
mov      qword [rbx + 8*rcx],0
mov      qword [rbx + 8*rdx],1
mov      rax,qword [rbx + 8*rcx]

mov      qword [rbx],rsi
mov      qword [rbx + 8],rdi
mov      rax,qword [rbx + 8*rax]
```
Load into `rax` the content in `rsi` if `rcx` and `rdx` are different, `rdi` otherwise.

`rax = (rcx == rdx) ? rdi : rsi`

Note that the snippet uses only `mov` instructions to implement a conditional operation.

### Snippet [[0x2d]](https://www.xorpd.net/pages/xchg_rax/snip_2d.html)
```
mov      rdx,rax
dec      rax
and      rax,rdx
```
Checks if the content in `rax` is a power of 2. If yes, `rax` is 0, 1 otherwise.

### Snippet [[0x2e]](https://www.xorpd.net/pages/xchg_rax/snip_2e.html)
```
mov      rdx,rax
dec      rdx
xor      rax,rdx
shr      rax,1
cmp      rax,rdx
```
Checks if the content in `rax` is a power of 2 and not zero. If `rax == rdx` in the end, the original value in `rax` is a power of 2 and not zero.

### Snippet [[0x2f](https://www.xorpd.net/pages/xchg_rax/snip_2f.html)
```
    xor      eax,eax
.loop:
    jrcxz    .exit_loop
    inc      rax
    mov      rdx,rcx
    dec      rdx
    and      rcx,rdx
    jmp      .loop
.exit_loop:
```
Counts the number of set bits in `rcx`, stores the count in `rax`. The `dec` followed by `and` effectively clears least siginificant bit that is set in each iteration until `rcx` reaches 0. 

### Snippet [[0x30]](https://www.xorpd.net/pages/xchg_rax/snip_30.html)
```
and      rax,rdx

sub      rax,rdx
and      rax,rdx

dec      rax
and      rax,rdx
```
Computes `rax = ((((rax & rdx) - rdx) & rdx) - 1) & rdx`. The result is equal to `rax & rdx`

### Snippet [[0x31]](https://www.xorpd.net/pages/xchg_rax/snip_31.html)
```
mov      rcx,rax
shr      rcx,1
xor      rcx,rax

inc      rax

mov      rdx,rax
shr      rdx,1
xor      rdx,rax

xor      rdx,rcx
```
`rdx = (gray code of rax) ^ (graycode of rax + 1)`
The operation `shr` by 1 and `xor` the original number results in gray code of that number.


