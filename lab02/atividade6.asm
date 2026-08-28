addi x10, x0, 1 #salva o 1 para acender o led
sb x10, 1029(x0) #acende o led 1

loop:
    lb x11, 1026(x0) #ler botao
    andi x11, x11, 0x1 #filtro para o bit expecifico do botao
    beq x11, x0, loop # nao foi pressionado, continua o loop

#botao pressionado
espera_soltar:
    lb x11, 1026(x0) #ler botao novamente
    andi x11, x11, 0x1
    bne x11, x0, espera_soltar #se nao voltou a 0, espera soltar 

    slli x10, x10, 1 #descolamento para o x10 ter o prox led
    addi x12, x0, 64 # limite (após 6 slli)
    bne x10, x12, atualiza_led # acende o prox ate chegar no limite
    jal x0, fim # parar o sistema depois do led 7

atualiza_led:
    sb x10, 1029(x0) #acende o led atual
    jal x0, loop

fim: halt
