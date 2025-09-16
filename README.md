# xchg rax, rax
CoreKiller: x64 Assembly for the advanced.

## Introduction
My journal of the x64 Assembly exploration upon the completion of Assembly Language Adventures. xchg rax, rax is a collection of riddles that Xorpd (the author) found throughout his years of reversing and writing assembly code. There are a total of 0x40 snippets, which contain concepts about assembly, math, and life.

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
This snippet shows different ways to zero out general-purpose registers.

### Snippet [[0x01]](https://www.xorpd.net/pages/xchg_rax/snip_01.html)
```
.loop:
    xadd     rax,rdx
    loop     .loop
```
This computes the Fibonacci sequence up to the n<sup>th</sup> element, where n is stored in the `ecx` register.
The `xadd` instruction exchanges the values of `rax` and `rdx`, then adds them and stores the sum in `rax`. In each iteration, the latest sum becomes the previous number for the next addition (by exchanging the values).
The loop continues until `ecx` reaches 0. The result is in `rax`.
Before starting the loop, `rax` must be set to 0 and `rdx` to 1.

### Snippet [[0x02]](https://www.xorpd.net/pages/xchg_rax/snip_02.html)
```
neg      rax
sbb      rax,rax
neg      rax
```
This checks if the value in the `rax` register is non-zero. If it's non-zero, it stores 1 in `rax`; otherwise, it stores 0.
```
rax = (rax != 0 ? 1 : 0)
```

### Snippet [[0x03]](https://www.xorpd.net/pages/xchg_rax/snip_03.html)
```
sub      rdx,rax
sbb      rcx,rcx
and      rcx,rdx
add      rax,rcx
```
This gets the minimum value between the `rdx` and `rax` registers. The result is stored in `rax`.
```
rax = min(rdx, rax)
```

### Snippet [[0x04]](https://www.xorpd.net/pages/xchg_rax/snip_04.html)
```
xor      al,0x20
```
This toggles the 6<sup>th</sup> bit of the character (bit at index 5), converting uppercase letters to lowercase and vice versa.

### Snippet [[0x05]](https://www.xorpd.net/pages/xchg_rax/snip_05.html)
```
sub      rax,5
cmp      rax,4
```
This checks if a number in the `rax` register is between __5__ and __9__. If it is in range, the `jbe` or `jna` instructions will execute. This snippet is a vague one.

If `rax` < 5, `sub rax, 5` will result in a negative number. However, the `jbe` instruction treats the result as an unsigned value. So, `cmp rax, 4` is a comparison between a large unsigned number and 4. The `jbe` condition is not met, and the jump won't occur.

If `rax` > 9, `sub rax, 5` will result in a number larger than 4. The `jbe` condition is not met, and the jump won't occur.

Finally, if `rax` is 5, 6, 7, 8, or 9, `sub rax, 5` will be 0, 1, 2, 3, or 4, respectively. Any of these differences satisfies the condition of <= 4 when `cmp rax, 4`, so the `jbe` condition is met, and the jump will occur.

### Snippet [[0x06]](https://www.xorpd.net/pages/xchg_rax/snip_06.html)
```
not      rax
inc      rax
neg      rax
```
The `not` instruction computes the 1's complement of a number. Then, `inc` adds 1 to it, converting the previous result to the 2's complement. So, the combination of the `not` and `inc` instructions is equivalent to a `neg` instruction. The result above only wastes cycles as two negations cancel each other out. The only thing that changes is the flags. Indeed, the `neg` instruction sets the CF flag to 0 if the operand is 0, and to 1 otherwise.

### Snippet [[0x07]](https://www.xorpd.net/pages/xchg_rax/snip_07.html)
```
inc      rax
neg      rax
inc      rax
neg      rax
```
This does nothing but waste cycles, as the two combinations of `inc` and `neg` cancel each other out.

### Snippet [[0x08]](https://www.xorpd.net/pages/xchg_rax/snip_08.html)
```
add      rax,rdx
rcr      rax,1
```
This computes the average of two positive or two negative numbers. It supports negative numbers because the `rcr` instruction prevents overflow: it shifts CF into the most-significant bit and shifts the least-significant bit into CF. The CF is temporarily used as the 65th bit of the result (doing a 65-bit rotation with CF).

### Snippet [[0x09]](https://www.xorpd.net/pages/xchg_rax/snip_09.html)
```
shr      rax,3
adc      rax,0
```
This computes `rax / 8`, rounded up to the nearest integer with `adc rax, 0`.

### Snippet [[0x0a]](https://www.xorpd.net/pages/xchg_rax/snip_0a.html)
```
    add      byte [rdi],1
.loop:
    inc      rdi
    adc      byte [rdi],0
    loop     .loop
```
This increments the number pointed to by the `rdi` register by one, which is an `rcx`-byte long integer.

### Snippet [[0x0b]](https://www.xorpd.net/pages/xchg_rax/snip_0b.html)
```
not      rdx
neg      rax
sbb      rdx,-1
```
If `rax` is 0, the `neg` operation is performed on `rdx`; otherwise, the `not` operation is performed.
Application: Negate a 16-byte integer in the `rdx:rax` registers.

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
`rax` and `rcx` have the same value at the end due to the associative property of the `xor` operation.
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
`rax` and `rbx` have the same value at the end, regardless of their initial values, thanks to the distributive property of the `and` and `xor` operations.
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
This demonstrates Boolean Algebra with De Morgan's laws.
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
This resembles an 8-bit CBC mode block cipher. The IV is initialized in the `al` register, which plays an important role as a key for the ciphertext.
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
This shows different ways to exchange the values of `rax` and `rcx`.

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
This compares two strings of `rcx` bytes in length, pointed to by `rsi` and `rdi`. `al` remains 0 if the two buffers have no differences (`al` must be zero-initialized before the loop).

### Snippet [[0x12]](https://www.xorpd.net/pages/xchg_rax/snip_12.html)
```
mov      rcx,rdx
and      rdx,rax
or       rax,rcx
add      rax,rdx
```
This computes `rax + rdx` using logical operators.
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
This computes `rax = rax + rbx` using a set of recursive logical operations.

This is similar to the implementation of an adder in electronics. The `xor` operation is used to find the output of a bit, and the `and` operation is used to detect a carry for a more significant bit position.

### Snippet [[0x14]](https://www.xorpd.net/pages/xchg_rax/snip_14.html)
```
mov      rcx,rax
and      rcx,rdx

xor      rax,rdx
shr      rax,1

add      rax,rcx
```
This computes the average of `rax` and `rdx`, rounded down to the nearest integer, and stores the result in `rax`.
```
(rax & rdx) + ((rax ^ rdx) / 2) = (rax + rdx) / 2
```

The math behind this is as follows:
Let's use `a` for `rax` and `b` for `rdx`.
`(a ^ b)` computes the sum of `a` and `b`, ignoring all the carries.
`(a & b)` isolates only the *carry* bits.

If we shift `(a & b)` to the left by one position, the carry bits are in place to be added to `(a ^ b)`, resulting in `a + b`.

Rewriting that, we have: `a + b = (a & b) * 2 + (a ^ b)`
To find the average of `a` and `b`, we simply divide the whole expression by 2:
`(a + b) / 2 = ((a & b) * 2 + (a ^ b)) / 2 = (a & b) + (a ^ b) / 2`.

### Snippet [[0x15]](https://www.xorpd.net/pages/xchg_rax/snip_15.html)
```
mov      rdx,0xffffffff80000000
add      rax,rdx
xor      rax,rdx
```
This extends the 32-bit content of `eax` to 64-bits in `rax`, preserving the sign. The upper half of `rax` is assumed to be zeroed out.

If `eax` is negative, the `add` operation overflows the 33rd bit of `rax` (the lowest bit in the upper half), causing all bits in the upper half to be cleared. Then, the `xor` operation makes the upper half of `rdx` negative.

If `eax` is positive, the overflow never occurs after the `add` operation. Then, `xor` removes the upper half of `rdx`, leaving `rax` positive.

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
This computes `rax` to be either 0 or `rax ^ rcx`.
```
rsi = (rax ^ rbx) + (rbx ^ rcx)
if (CF == 1)
	rax = (rbx ^ rcx) // (cmovc)
	rax = (rbx ^ rcx) ^ (rbx ^ rcx) // (xor rax, rbx)
	rax = 0
else
	rax = (rax ^ rbx) ^ (rbx ^ rcx) // (xor rax, rbx)
	rax = rax ^ rbx ^ rbx ^ rcx
	rax = rax ^ 0 ^ rcx
	rax = rax ^ rcx
```
Application: unknown.

### Snippet [[0x17]](https://www.xorpd.net/pages/xchg_rax/snip_17.html)
```
cqo
xor      rax,rdx
sub      rax,rdx
```
This computes the absolute value of `rax`.
`rax = |rax|`

`cqo` sets all bits in `rdx` to 1 if `rax` is negative, and to 0 otherwise.
If `rax` is negative, `rdx` becomes 0xffffffffffffffff, and `xor rax, rdx` results in `not rax`. Subtracting `rdx` (-1) converts `rax` to the two's complement of the original value.
If `rax` is positive, `rdx` is set to 0, and the following `xor rax, rdx` and `sub rax, rdx` operations do nothing.

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
This snippet compares two timestamps.
`rdtsc` reads the 64-bit timestamp and stores it in `edx:eax`.
It shifts `rdx` 32 bits to the left and merges it with the upper half of `rax`. We end up with the 64-bit timestamp stored in `rax`.

The first timestamp is stored in `rcx`, which is then used to compare the later timestamp in `rax`. Of course, `rax` will always be larger than `rcx`.

### Snippet [[0x19]](https://www.xorpd.net/pages/xchg_rax/snip_19.html)
```
    call     .skip
    db       'hello world!',0
.skip:
    call     print_str
    add      rsp,8
```
This calls `print_str("hello world!");`

The `call .skip` instruction pushes the address of the 'hello world!' string to the stack, which serves as an argument to the external `print_str` subroutine. `add rsp, 8` cleans up the stack without returning from the `.skip` label.

### Snippet [[0x1a]](https://www.xorpd.net/pages/xchg_rax/snip_1a.html)
```
    call     .next
.next:
    pop      rax
```
This gets the current instruction pointer (`rip`) and stores it in `rax`. `rax = .next`

### Snippet [[0x1b]](https://www.xorpd.net/pages/xchg_rax/snip_1b.html)
```
push     rax
ret
```
This jumps to the address stored in `rax`.
`rip = rax` or `jmp rax`.

### Snippet [[0x1c]](https://www.xorpd.net/pages/xchg_rax/snip_1c.html)
```
pop      rsp
```
This loads the value from the top of the stack into `rsp`.

### Snippet [[0x1d]](https://www.xorpd.net/pages/xchg_rax/snip_1d.html)
```
mov      rsp,buff2 + n*8 + 8
mov      rbp,buff1 + n*8
enter    0,n+1
```
This snippet copies the contents of `buff1` to `buff2`.

`mov rsp, buff2 + n*8 + 8`: Loads the address of `buff2 + n*8 + 8` into the stack pointer. The +8 adjustment accounts for the effect of the `enter` instruction, which subtracts 8 bytes from `rsp`.

`mov rbp, buff1 + n*8`: Loads the address `buff1 + n*8` into the base frame pointer, setting up the current frame for copying.

`enter 0, n+1`:
- First, it subtracts 8 from `rsp` and stores the address `buff1 + n*8` on the stack at the address `buff2 + n*8`. We still have stack frames from the address `buff2` to `buff2 + n*8` to copy the contents of `buff1`.
- Next, it loads the address `buff2 + n*8` into `rbp`, effectively setting up the current frame for copying. `rbp` now has access to the previous stack frames, and `buff1 + n*8` is the address content stored at `buff2 + n*8`.
- The nesting level `n+1` is used to copy the value pointed to by the address stored in `rbp`.
This means it copies the frames from `buff1` to `buff1 + n*8` to its current frame, from `buff2` to `buff2 + n*8`.

### Snippet [[0x1e]](https://www.xorpd.net/pages/xchg_rax/snip_1e.html)
```
cmp      al,0x0a
sbb      al,0x69
das
```
This converts `al` from a value between 0x00 and 0x0f to its corresponding hexadecimal ASCII code.

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
[__Collatz conjecture__](https://en.wikipedia.org/wiki/Collatz_conjecture)

In each iteration of the `.loop`, the snippet performs the following operations:
- It searches for the index of the least significant bit of `rax` that is set, starting from index 0. It stores the index in `rcx`.
- It shifts `rax` to the right `cl` times. This effectively divides `rax` by 2^cl, making `rax` an odd number.
- It computes the new `rax`: `rax = (rax * 3) + 1`
- This repeats until `rax` is equal to 1.

References:
[The Simplest Math Problem No One Can Solve - Collatz Conjecture](https://youtu.be/094y1Z2wpJg?si=wAonNF4hXf3u_0nk)

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
This computes `rcx = 1337 * rax`.

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
This resembles the multiplication of two complex numbers:
```
(a + bi)(c + di) = (ac - bd) + (ad + bc)i
```
```
rax = rax*rcx - rbx*rdx
rbx = rax*rdx + rbx*rcx
```

Further exploration could involve learning more about Complex Numbers and the Karatsuba Algorithm.

### Snippet [[0x22]](https://www.xorpd.net/pages/xchg_rax/snip_22.html)
```
mov      rdx,0xaaaaaaaaaaaaaaab
mul      rdx
shr      rdx,1
mov      rax,rdx
```
This divides `rax` by 3 and rounds down to the nearest integer.

0xaaaaaaaaaaaaaaab is approximately (2^64) / 3.

So, multiplying `rax` by 0xaaaaaaaaaaaaaaab and then using only the `rdx` value is the same as multiplying the number by 1/3.
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
This computes `rax` modulo 3.
`rax = rax % 3`

The snippet uses base 4 to compute the modulo. The reason for using base 4 is that `4 % 3 = 1`, and raising 4 to any power always results in a number that, when divided by 3, has a remainder of 1.

The loop adds each digit in base 4 and reduces it into `rax`:
- Sets `rdx=rax` (to preserve the current content in `rax`).
- Isolates the two least significant bits (one digit in base 4) with `and rax, 3`.
- Shifts the next digit into place for addition with `shr rdx, 2`.
- Adds the isolated digit to the shifted content, which is then stored in `rax`.
- This repeats until `rax` is reduced to a value between 0 and 5.

Exiting the loop:
- It compares the reduced value with 3.
- There are two cases:
	- If the value is less than 3 (i.e., 0, 1, or 2), the remainder is the value itself (i.e., the value minus 0).
	- If the value is greater than or equal to 3 (i.e., 3, 4, or 5), the remainder is the value minus 3.
- The minuend of either 0 or 3 is determined by the `cmc` instruction, which sets the contents of `rdx`.

Further exploration could involve reviewing this modulo 3 computation using the advantage of base 4.

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
Pseudo-code: (assume `rax` is `a`)
```
b = a
c = a
do {
	c = a * b
	b = b * (2 - c)
} while (c > 1);
```
The snippet computes the multiplicative inverse via Newton's method.

In each iteration, the number of bits doubles. So, when `cmp rcx, 1`, the `ja` condition is met when `rcx` sets its most significant bit (the 64th bit). This finds the multiplicative inverse of `rax` modulo 2^64.

Further exploration could involve learning more about multiplicative inverse.

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
At the beginning, `rcx = 0x100000000`.

In each iteration:
- `movzx rbx, cx`: Isolates the lower two bytes of `ecx` into `rbx`. Let's call it X.
- `imul rbx, rbx`: X^2

- `ror rcx, 0x10`: Aligns the upper two bytes of `ecx` into place, with the lower two bytes preserved.
- `movzx rdx, cx`: Isolates the two bytes into `rdx`. Let's call it Y.
- `imul rdx, rdx`: Y^2
- `rol rcx, 0x10`: Restores the content of `rcx`.

- `add rbx, rdx`: X^2 + Y^2. Each X or Y is in the range [0, 0xffff], so the result is between 0 and 0x1FFFC0002.
- `shr rbx, 0x20`: Shifts the 32nd bit to the right. So, `rbx` is either 0 or 1.
- `cmp rbx, 1`: This sets the carry flag accordingly.
- `adc rax, 0`: Increments `rax` by 1 if X^2 + Y^2 < 0x100000000 (0x10000^2).

Summary:
	We have a circle with a radius of 0x10000, centered at the origin (0, 0). `ecx` holds the coordinates of a point (X, Y), where X and Y are both in the range [0, 0xffff]. The `loop .loop` instruction decrements `ecx`, moving the check to the next point. It computes the square of the length from the origin of the circle to the point (X, Y) using the Pythagorean theorem. If the square of the length is less than the square of the radius (0x10000^2, or 0x100000000), the counter `rax` is incremented. In the end, `rax` holds the number of points that lie inside the circle.

### Snippet [[0x26]](https://www.xorpd.net/pages/xchg_rax/snip_26.html)
```
mov      rdx,rax
shr      rax,7
shl      rdx,0x39
or       rax,rdx
```
This computes `ror rax, 7`, which is equivalent to `rol rax, 0x39`.

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
This computes `rax = rax >> ((cl / 2) + ((cl + 1) / 2))`.

### Snippet [[0x28]](https://www.xorpd.net/pages/xchg_rax/snip_28.html)
```
    clc
.loop:
    rcr      byte [rsi],1
    inc      rsi
    loop     .loop
```
This divides an arbitrarily long integer of `rcx` bytes, pointed to by `rsi`, by 2, and rounds down to the nearest integer.

### Snippet [[0x29]](https://www.xorpd.net/pages/xchg_rax/snip_29.html)
```
lea 	rdi,[rsi + 3]
rep movsb
```
This replaces the buffer pointed to by `rsi` with a pattern consisting of the first three bytes of the buffer.

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
This rotates a buffer pointed to by `rsi` to the right by 8 bytes. The size of the buffer in bytes is stored in `rcx`.
In other words, it moves the last qword of an `ecx`-length qword array to the front.

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
This snippet finds duplicates in an array using [Floyd's Tortoise and Hare](https://en.wikipedia.org/wiki/Cycle_detection#Floyd's_tortoise_and_hare) algorithm.

- `eax` is the Tortoise, `edx` is the Hare.
- Loop 1: Finds the meeting point of the Tortoise and Hare within the cycle.
- Loop 2: Finds the start of the cycle, which corresponds to the duplicate value.

References:
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
This loads the content of `rsi` into `rax` if `rcx` and `rdx` are different; otherwise, it loads the content of `rdi`.
`rax = (rcx == rdx) ? rdi : rsi`

Note that this snippet uses only `mov` instructions to implement a conditional operation.

### Snippet [[0x2d]](https://www.xorpd.net/pages/xchg_rax/snip_2d.html)
```
mov      rdx,rax
dec      rax
and      rax,rdx
```
This checks if the value in `rax` is a power of 2. If it is, `rax` becomes 0; otherwise, it becomes 1.
```
rax = rax & (rax - 1)
```

### Snippet [[0x2e]](https://www.xorpd.net/pages/xchg_rax/snip_2e.html)
```
mov      rdx,rax
dec      rdx
xor      rax,rdx
shr      rax,1
cmp      rax,rdx
```
This checks if the value in `rax` is a power of 2 and not equal to zero. If `rax` is equal to `rdx` at the end, the original value in `rax` is a power of 2 and not zero.
```
(rax ^ (rax - 1)) >> 1 == rax - 1
```

### Snippet [[0x2f]](https://www.xorpd.net/pages/xchg_rax/snip_2f.html)
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
This counts the number of set bits in `rcx` and stores the result in `rax`. The `dec` followed by `and` effectively clears the least significant bit that is set in each iteration, continuing until `rcx` reaches 0.

The snippet uses the __Brian Kernighan's algorithm__ to count the number of set bits in a number.

References:
[Medium - Brian Kernighan’s Algorithm: Count set bits in a number](https://yuminlee2.medium.com/brian-kernighans-algorithm-count-set-bits-in-a-number-18ab05edca93)
[YouTube - Brian Kernighan's Algorithm | Count set bits in binary representation of a number](https://youtu.be/XrKp45qCkKE)

### Snippet [[0x30]](https://www.xorpd.net/pages/xchg_rax/snip_30.html)
```
and      rax,rdx

sub      rax,rdx
and      rax,rdx

dec      rax
and      rax,rdx
```
This computes `rax = ((((rax & rdx) - rdx) & rdx) - 1) & rdx`. The result is equal to `rax & rdx`.

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
This performs an `xor` operation on two consecutive Gray codes.
The `shr rdx, 1` instruction, followed by an `xor` with the original number, results in the Gray code of that number.
```
Graycode of x = x ^ (x >> 1)
```

### Snippet [[0x32]](https://www.xorpd.net/pages/xchg_rax/snip_32.html)
```
mov      rcx,rax

mov      rdx,rax
shr      rdx,1
xor      rax,rdx

popcnt   rax,rax
xor      rax,rcx
and      rax,1
```
This snippet always returns 0.
`rax = (popcnt(rax ^ (rax >> 1)) ^ rax) & 1 = 0`

This means that the least significant bit of `popcnt(rax ^ (rax >> 1))` must always be the same as the least significant bit of `rax`.
In simpler terms, if `rax` is odd, the number of set bits in its Gray code is also odd; if `rax` is even, the number of set bits will also be even.

### Snippet [[0x33]](https://www.xorpd.net/pages/xchg_rax/snip_33.html)
```
mov      rdx,rax
shr      rdx,0x1
xor      rax,rdx

mov      rdx,rax
shr      rdx,0x2
xor      rax,rdx

mov      rdx,rax
shr      rdx,0x4
xor      rax,rdx

mov      rdx,rax
shr      rdx,0x8
xor      rax,rdx

mov      rdx,rax
shr      rdx,0x10
xor      rax,rdx

mov      rdx,rax
shr      rdx,0x20
xor      rax,rdx
```
This converts a Gray code into its normal binary representation, which is the inverse of `rax ^ (rax >> 1)`.

### Snippet [[0x34]](https://www.xorpd.net/pages/xchg_rax/snip_34.html)
```
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
```
This swaps a certain number of bits. This illustrates the [Bit-reversal permutation](https://en.wikipedia.org/wiki/Bit-reversal_permutation).

### Snippet [[0x35]](https://www.xorpd.net/pages/xchg_rax/snip_35.html)
```
mov      edx,eax
and      eax,0x55555555
shr      edx,0x1
and      edx,0x55555555
add      eax,edx

mov      edx,eax
and      eax,0x33333333
shr      edx,0x2
and      edx,0x33333333
add      eax,edx

mov      edx,eax
and      eax,0x0f0f0f0f
shr      edx,0x4
and      edx,0x0f0f0f0f
add      eax,edx

mov      edx,eax
and      eax,0x00ff00ff
shr      edx,0x8
and      edx,0x00ff00ff
add      eax,edx

mov      edx,eax
and      eax,0x0000ffff
shr      edx,0x10
and      edx,0x0000ffff
add      eax,edx
```
[__Hamming Weight__](https://en.wikipedia.org/wiki/Hamming_weight#Efficient_implementation)

This counts the number of set bits in the `eax` register. This is equivalent to the `popcnt` instruction.

### Snippet [[0x36]](https://www.xorpd.net/pages/xchg_rax/snip_36.html)
```
dec      rax

mov      rdx,rax
shr      rdx,0x1
or       rax,rdx

mov      rdx,rax
shr      rdx,0x2
or       rax,rdx

mov      rdx,rax
shr      rdx,0x4
or       rax,rdx

mov      rdx,rax
shr      rdx,0x8
or       rax,rdx

mov      rdx,rax
shr      rdx,0x10
or       rax,rdx

mov      rdx,rax
shr      rdx,0x20
or       rax,rdx

inc      rax
```
This finds the smallest power of 2 that is greater than or equal to the value of `rax`.
The snippet decreases the value by 1, copies the most significant set bit to the least significant bits (all bits are set to one), and finally increments the number to get the power of two.

### Snippet [[0x37]](https://www.xorpd.net/pages/xchg_rax/snip_37.html)
```
mov      rdx,rax
not      rdx
mov      rcx,0x8080808080808080
and      rdx,rcx
mov      rcx,0x0101010101010101
sub      rax,rcx
and      rax,rdx
```
This locates the position of 0x00 bytes in a dword. If a byte is zero, it is replaced with 0x80; otherwise, it is replaced with 0x00.

### Snippet [[0x38]](https://www.xorpd.net/pages/xchg_rax/snip_38.html)
```
bsf      rcx,rax

mov      rdx,rax
dec      rdx
or       rdx,rax

mov      rax,rdx
inc      rax

mov      rbx,rdx
not      rbx
inc      rdx
and      rdx,rbx
dec      rdx

shr      rdx,cl
shr      rdx,1

or       rax,rdx
```
This computes the next largest integer with the same Hamming weight (the number of set bits) as `rax`.

It does the following steps:
- It finds the index of the least significant set bit in `rax` using `bsf rcx, rax`.
- It sets all bits to the right of that index to 1. This prepares for the next value propagation.
- It increments to propagate the value to the next power of 2.
- It captures the remaining set bits by propagating the carry via `not` and `inc`.
- It shifts the carry into the index that was found in the first step.
- It combines this with the power of 2 from step 3 to get the final result.

### Snippet [[0x39]](https://www.xorpd.net/pages/xchg_rax/snip_39.html)
```
mov      rdx,0xaaaaaaaaaaaaaaaa
add      rax,rdx
xor      rax,rdx
```
This snippet converts a normal binary number to its negabinary representation.
Negabinary is base -2. To convert a bit position from base 2 to base -2, we use the formula 2^n = (-2)^(n+1) + (-2)^n.

`n` is the index of the bit position from the least significant bit. If `n` is even, the bit position corresponds to a positive power of 2; if `n` is odd, it corresponds to a negative power. Therefore, by adding 1 to the odd-indexed bits (0xaaaaaaaaaaaaaaaa), we propagate any carry to the higher bits ((-2)^(n+1)), and then `xor` the result with the original value to set the nth bit again ((-2)^n), thus obtaining the negabinary representation.

References: [oeis.org - Negabinary](https://oeis.org/wiki/Negabinary)

### Snippet [[0x3a]](https://www.xorpd.net/pages/xchg_rax/snip_3a.html)
```
mov      rdx,rax
neg      rdx
and      rax,rdx

mov      rdx,0x218a392cd3d5dbf
mul      rdx
shr      rax,0x3a

xlatb
```
The first block finds the least significant set bit, which determines the highest power of two that divides `rax`. `rax = rax & (-rax)`

The second block computes `rax = (rax * 0x218a392cd3d5dbf) >> 58`. `rax` then becomes an index for the lookup table.

The last instruction computes `rax = rbx[al]`.

This is a rather vague snippet, as it is not fully functional on its own.
To understand the whole picture, this snippet uses the de Bruijn strategy to index the 1 in the number computed in the first block.
How does it work? Why 0x218a392cd3d5dbf? Why 58?
The snippet is a hash function that is computed by

y = (x * deBrujin) >> (n - log<sub>2</sub>n)

`n` is the number of bits (64), so log2(64) = 6. That's how 58 (64 - 6) comes into play.

The value 0x218a392cd3d5dbf is the de Bruijn sequence because if we pick any sequence with a length of log2(64) (which is 6), we get a distinct value (a 6-bit window that slides to the right one bit at a time to indicate the index).

Finally, we use `y` as an index in the table pointed to by `rbx` to get the index of the 1.

### Snippet [[0x3b]](https://www.xorpd.net/pages/xchg_rax/snip_3b.html)
```
cdq
shl      eax,1
and      edx,0xc0000401
xor      eax,edx
```
This computes the next state in an [LFSR](https://en.wikipedia.org/wiki/Linear-feedback_shift_register).
The number `c0000401` is a polynomial, so it will cycle through all 32-bit integers except for 0. The `cdq` instruction is used to check if the most significant bit is 1, in order to `xor` it with the polynomial constant.
```
if (eax & (1 << 31))
	eax = (eax << 1) ^ 0xc0000401
else
	eax = eax << 1
```

References:
[Random Numbers with LFSR (Linear Feedback Shift Register) - Computerphile](https://youtu.be/Ks1pw1X22y4)

### Snippet [[0x3c]](https://www.xorpd.net/pages/xchg_rax/snip_3c.html)
```
mov      rbx,rax
mov      rdx,rbx
mov      rcx,0xaaaaaaaaaaaaaaaa
and      rbx,rcx
shr      rbx,1
and      rbx,rdx
popcnt   rbx,rbx
and      rbx,1

neg      rax
mov      rdx,rax
mov      rcx,0xaaaaaaaaaaaaaaaa
and      rax,rcx
shr      rax,1
and      rax,rdx
popcnt   rax,rax
and      rax,1

mov      rdx,rax
add      rax,rbx
dec      rax
neg      rax
sub      rdx,rbx
```

The first block determines whether the number of set bit-pairs in `rbx` is odd or even. `rbx` will be either 0 or 1.

The second block determines whether the number of set bit-pairs in the negated `rax` is odd or even. `rax` will be either 0 or 1.

The last block returns the values of `rax` and `rdx`, which can each be -1, 0, or 1:
```
rdx = rax - rbx
rax = 0 - (rax + rbx - 1);
```

`rax` and `rbx` represent directions in two dimensions, which are used to draw a [Hilbert Curve](https://en.wikipedia.org/wiki/Hilbert_curve).

References:
[Hilbert's Curve: Is infinite math useful?](https://youtu.be/3s7h2MHQtxc?si=3KC2CqTtkHXMaTt5)

### Snippet [[0x3d]](https://www.xorpd.net/pages/xchg_rax/snip_3d.html)
```
    mov      rcx,1
.loop:
    xor      rax,rcx
    not      rax
    and      rcx,rax
    not      rax

    xor      rdx,rcx
    not      rdx
    and      rcx,rdx
    not      rdx

    shl      rcx,1
    jnz      .loop
```
`rax` and `rdx` are interleaved to create the position of a dot in two dimensions.
`rax` holds the even-indexed bits, while `rdx` holds the odd-indexed ones.
`rcx` is the bit that is incremented to the number interleaved by `rax` and `rdx`.

First, it flips the bit at the position indicated by `rcx`.
If the bit is flipped from 0 to 1, the `not` operation will clear that bit in `rcx`, causing `rcx` to become zero and the snippet to stop.
If the bit is flipped from 1 to 0, the `not` operation will retain the set bit in `rcx`, and the next check will proceed to the next position in the interleaved number (from `rax` to `rdx`, or from `rdx` to `rax`, with `rcx` indicating the next bit position).

This is the same as incrementing a number and propagating the carry bit to the next bit position.

The interleaved number is used to determine the position of a point in two dimensions when drawing a [Z-order curve](https://en.wikipedia.org/wiki/Z-order_curve).

### Snippet [[0x3e]](https://www.xorpd.net/pages/xchg_rax/snip_3e.html)
```
mov      rdx,rax
shr      rdx,1
xor      rax,rdx

popcnt   rax,rax
and      rax,0x3
```
The snippet computes `rax = popcnt(rax ^ (rax >> 1)) & 3`.

Some of the first outputs are `0, 1, 2, 1, 2, 3, 2, 1, 2, 3, 0, 3`.

This is the beginning of a sequence of [Directions of the lines in the (Heighway) Dragon Curve](https://oeis.org/A246960).

### Snippet [[0x3f]](https://www.xorpd.net/pages/xchg_rax/snip_3f.html)
```
mov      rbx,3
mov      r8,rax
mov      rcx,rax
dec      rcx

and      rax,rcx
xor      edx,edx
div      rbx
mov      rsi,rdx

mov      rax,r8
or       rax,rcx
xor      edx,edx
div      rbx
inc      rdx
cmp      rdx,rbx
sbb      rdi,rdi
and      rdi,rdx

bsf      rax,r8
```
The first block saves the original content of `rax` in `r8` and sets up a value `rcx = rax - 1`.
The second block computes `rsi = (rax ^ (rax - 1)) % 3`.
The third block computes `rdi = (((rax | (rax - 1)) % 3) + 1) % 3`.

The snippet takes `rax` as the nth move and returns `rsi` and `rdi`, which can each be 0, 1, or 2. `rsi` indicates the source index, and `rdi` indicates the destination index. All together, the snippet computes the source and destination pegs for the nth move in the solution to the [__Towers of Hanoi__](https://en.wikipedia.org/wiki/Tower_of_Hanoi#Binary_solution).

Further exploration could involve looking more closely at how the binary solution is related to the two formulas above for the source and destination indices.

References:
[Binary, Hanoi and Sierpinski, part 1](https://www.youtube.com/watch?v=2SUvWfNJSsM&pp=ygUeQmluYXJ5IHNvbHV0aW9uIHRvd2VyIG9mIGhhbm9p)
