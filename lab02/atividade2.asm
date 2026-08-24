lw x1, a          
lw x2, b         
lw x3, m               

blt x2, x3, op1 # se b < m   
beq x0, x0, op2 # else  

op1:
	add x3, x1, x2 
	beq x0, x0, fim # pula para o fim
op2:
	sub x3, x1, x2      

fim:
	sw x3, m
	halt

a: .word 6
b: .word 15
m: .word 0x0000
