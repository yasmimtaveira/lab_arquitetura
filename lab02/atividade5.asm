addi x11, x10, 42 #guarda o valor ascii do *

loop:
lb x10, 1025(x0) #ler o teclado
beq x10, x11, fim #se leu *, fim
sb x10, 1024(x0) #imprime o que foi lido
jal x0, loop

fim:
halt
