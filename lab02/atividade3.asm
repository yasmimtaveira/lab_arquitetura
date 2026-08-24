# pseudocodigo
# int f = 0;
# int g = 3;
# int h = 4;
# int i = 9;
# int j = 6;
# if(i == j) then
#   f = g+h;
# else 
#   f = g-h;
# end if

lw x19, f          
lw x20, g         
lw x21, h               
lw x22, i
lw x23, j

beq x22, x23, iguais # se i = j
beq x0, x0, dif # else  

iguais:
	add x19, x20, x21 
	beq x0, x0, fim # pula para o fim
dif:
	sub x19, x20, x21      

fim:
	sw x19, f # sempre executado
	halt

f: .word 0
g: .word 3
h: .word 4
i: .word 9
j: .word 6
