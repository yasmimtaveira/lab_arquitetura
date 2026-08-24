lw x10, a
lw x11, b
lw x12, m
add  x12, x10, x0 # m = a + 0

bge x11, x12, L1 # b >= m, pula a soma
add x12, x10, x11 # b < m -> m = a + b
L1: sw x12, m # sempre é executado
halt

a: .word 0x6
b: .word 0xf
m: .word 0x0000
