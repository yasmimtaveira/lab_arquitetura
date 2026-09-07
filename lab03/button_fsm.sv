module button_fsm (
    input  logic       clk,    // Clock de 50 MHz
    input  logic       rst_n,  // Reset assincrono, ativo baixo 
    input  logic [3:0] btn,    // Botao de avanco, ativo baixo  
	 output logic       led_unlock
);


typedef enum logic [5:0] {
    S0         = 6'b000001,   // Estado inicial 
    azul       = 6'b000010,   // Estado botao azul  
    amarelo    = 6'b000100,   // Estado amarelo 1     
    amarelo2   = 6'b001000,    // Estado amarelo 2     
    vermelho   = 6'b010000,   // estado vermelho
    unlock     = 6'b100000    // estado final, desbloqueado
} state_t;

state_t state, next_state;


logic [3:0] btn_active;  // Botao em logica positiva (1 = pressionado)
logic [3:0] btn_prev;    // Valor do botao no ciclo anterior
logic [3:0] btn_rise;    // Pulso de 1 ciclo na borda de subida

assign btn_active = ~btn;
assign btn_rise   = btn_active & ~btn_prev;  // Borda de descida do botao real (btn 1->0)

// Registra o estado anterior do botao (FF simples)
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) btn_prev <= 4'b0;
    else        btn_prev <= btn_active;
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) state <= S0;
    else        state <= next_state;
end


always_comb begin
    next_state = state;  // Default: mantem estado se nao houver borda

    unique case (state)
        S0: if (btn_rise[0]) next_state = azul;
		  
        azul: begin
            if (|btn_rise) begin // or dos bits do botao (se algum foi pressionado, entra no if)
                if (btn_rise[1]) next_state = amarelo;
                else             next_state = S0; // apertou o botao errado
            end
        end
		  
		  amarelo: begin
            if (|btn_rise) begin // or dos bits do botao (se algum foi pressionado, entra no if)
                if (btn_rise[1]) next_state = amarelo2;
                else             next_state = S0; // apertou o botao errado
            end
        end
        
		  amarelo2: begin
            if (|btn_rise) begin // or dos bits do botao (se algum foi pressionado, entra no if)
                if (btn_rise[3]) next_state = vermelho;
                else             next_state = S0; // apertou o botao errado
            end
        end
		  
		  vermelho: next_state = unlock; // terminou a sequencia corretamente
		  
        unlock: next_state = unlock; // preso aqui ate o reset
		  
		  default:          next_state = S0;
    endcase
end

// -----------------------------------------------------------------------------
// [5] SAIDA -- Logica de Moore

assign led_unlock = state[5]; // esse bit sera 1 quando entrar no estado unlock

endmodule
