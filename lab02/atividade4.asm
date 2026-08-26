addi x11, x0, 28 #guardar o endereço inicial da string

loop:
lb x10, 0(x11) 
beq x11, x0, fim #chegou caractere final
sb x10, 1024(x0)
addi x11, x11, 1
beq x0, x0, loop

fim:
halt

str1: .string "Hello World"
