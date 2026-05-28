bits 16
CPU 8086

shl   bx, 1
mov   bx, [bx + 1000]
jmp   ax