
`timescale 1ns/1ps

module button_fsm_tb;

    
    // Sinais de estimulo e observacao
    
    logic       clk;
    logic       rst_n;
    logic [3:0] btn;
    logic       led_unlock;

    
    // Codificacao dos estados (espelha o typedef state_t do DUT)
    
    localparam logic [5:0] ST_S0       = 6'b000001;
    localparam logic [5:0] ST_AZUL     = 6'b000010;
    localparam logic [5:0] ST_AMARELO  = 6'b000100;
    localparam logic [5:0] ST_AMARELO2 = 6'b001000;
    localparam logic [5:0] ST_VERMELHO = 6'b010000;
    localparam logic [5:0] ST_UNLOCK   = 6'b100000;

    
    // Instancia do DUT (Device Under Test)
    
    button_fsm dut (
        .clk        (clk),
        .rst_n      (rst_n),
        .btn        (btn),
        .led_unlock (led_unlock)
    );

    
    // Geracao de clock: periodo de 20ns -> 50 MHz
    
    initial clk = 0;
    always #10 clk = ~clk;

    
    // Task: pressiona um botao especifico (idx = 0..3) por alguns ciclos e solta
    //   - btn e ativo baixo: 0 = pressionado, 1 = solto
    //   - apenas o bit "idx" vai para 0, os demais permanecem em 1 (soltos)
    
    task press_button(input int idx, input int hold_cycles);
        @(negedge clk);
        btn      = 4'b1111;      // Garante que todos comecam soltos
        btn[idx] = 1'b0;         // Pressiona somente o botao "idx"
        repeat (hold_cycles) @(posedge clk);
        @(negedge clk);
        btn = 4'b1111;           // Solta todos
        repeat (3) @(posedge clk);  // Aguarda estabilizar
    endtask

    
    // Task: verifica o estado interno (dut.state) e imprime resultado
    
    task check_state(input logic [5:0] expected, input string msg);
        @(negedge clk);
        if (dut.state === expected)
            $display("[PASS] %s | state = 6'b%06b | led_unlock = %0b", msg, dut.state, led_unlock);
        else
            $display("[FAIL] %s | esperado = 6'b%06b, obtido = 6'b%06b", msg, expected, dut.state);
    endtask

    
    // Task: verifica o valor da saida led_unlock
    
    task check_led(input logic expected, input string msg);
        @(negedge clk);
        if (led_unlock === expected)
            $display("[PASS] %s | led_unlock = %0b", msg, led_unlock);
        else
            $display("[FAIL] %s | esperado = %0b, obtido = %0b", msg, expected, led_unlock);
    endtask

    
    // Sequencia de testes
    
    initial begin
        // Dump de formas de onda para visualizacao no GTKWave
        $dumpfile("button_fsm.vcd");
        $dumpvars(0, button_fsm_tb);

        // Condicao inicial
        rst_n = 1'b1;
        btn   = 4'b1111;  // Todos os botoes soltos (ativo baixo)

        
        // Teste 1: Reset
        
        $display("\n=== Teste 1: Reset ===");
        rst_n = 1'b0;
        repeat (3) @(posedge clk);
        rst_n = 1'b1;
        @(posedge clk);
        check_state(ST_S0, "Apos reset -> S0");
        check_led(1'b0, "Apos reset -> led_unlock = 0");

        
        // Teste 2: Sequencia correta completa ate o unlock
        //   botao 0 -> botao 1 -> botao 1 -> botao 3
        
        $display("\n=== Teste 2: Sequencia correta completa ===");
        press_button(0, 2);
        check_state(ST_AZUL, "Botao 0 em S0 -> azul");

        press_button(1, 2);
        check_state(ST_AMARELO, "Botao 1 em azul -> amarelo");

        press_button(1, 2);
        check_state(ST_AMARELO2, "Botao 1 em amarelo -> amarelo2");

        press_button(3, 2);
        check_state(ST_UNLOCK, "Botao 3 em amarelo2 -> vermelho -> unlock");

        @(posedge clk);
        check_led(1'b1, "Estado unlock -> led_unlock = 1");

        
        // Teste 3: Estado unlock e travado ate reset
        
        $display("\n=== Teste 3: Unlock preso ate reset ===");
        press_button(0, 2);   // Aperta qualquer botao dentro do unlock
        check_state(ST_UNLOCK, "Botao apertado em unlock -> continua unlock");
        check_led(1'b1, "led_unlock continua em 1");

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;
        @(posedge clk);
        check_state(ST_S0, "Reset em unlock -> volta para S0");
        check_led(1'b0, "led_unlock volta para 0");

        
        // Teste 4: Botao errado em cada estado intermediario -> volta a S0
        
        $display("\n=== Teste 4: Botao errado em cada estado (branch de erro) ===");

        // Erro em "azul": esperado botao 1, aperta o 2
        press_button(0, 2);
        check_state(ST_AZUL, "Botao 0 em S0 -> azul");
        press_button(2, 2);
        check_state(ST_S0, "Botao errado (2) em azul -> volta para S0");

        // Erro em "amarelo": esperado botao 1, aperta o 0
        press_button(0, 2);
        check_state(ST_AZUL, "Botao 0 em S0 -> azul");
        press_button(1, 2);
        check_state(ST_AMARELO, "Botao 1 em azul -> amarelo");
        press_button(0, 2);
        check_state(ST_S0, "Botao errado (0) em amarelo -> volta para S0");

        // Erro em "amarelo2": esperado botao 3, aperta o 2
        press_button(0, 2);
        press_button(1, 2);
        press_button(1, 2);
        check_state(ST_AMARELO2, "Sequencia parcial correta -> amarelo2");
        press_button(2, 2);
        check_state(ST_S0, "Botao errado (2) em amarelo2 -> volta para S0");

        

        // Teste 5: Segurar o botao pressionado nao deve avancar mais de 1 estado
        
        $display("\n=== Teste 5: Botao segurado (nao deve avancar mais de 1x) ===");
        press_button(0, 20);  // Segura o botao 0 por 20 ciclos
        check_state(ST_AZUL, "Botao 0 segurado 20 ciclos -> apenas azul");

        
        // Teste 6: Reset durante a operacao (no meio da sequencia)
        
        $display("\n=== Teste 6: Reset durante operacao ===");
        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;
        @(posedge clk);

        press_button(0, 2);
        press_button(1, 2);
        check_state(ST_AMARELO, "Sequencia parcial -> amarelo");

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;
        @(posedge clk);
        check_state(ST_S0, "Reset em amarelo -> volta para S0");
        check_led(1'b0, "led_unlock = 0 apos reset");

        $display("\n=== Simulacao concluida ===\n");
        $finish;
    end

endmodule