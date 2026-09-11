module multiplier_control (
    input  logic clk,
    input  logic rst_n,
    input  logic start,
    output logic done,    
    output logic load,        
    output logic compute_en   //(add condicional + shift)
);
    typedef enum logic [3:0] { //One-Hot
        IDLE    = 4'b0001,
        LOAD    = 4'b0010,
        COMPUTE = 4'b0100,
        DONE    = 4'b1000
    } state_t;

    state_t current_state, next_state;
    logic [5:0] count;

    // always para atualização de estado e do contador 
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= IDLE;
            count         <= 6'd0;
        end else begin
            current_state <= next_state;
            
            if (current_state == COMPUTE) begin
                count <= count + 1'b1;
            end else begin
                count <= 6'd0;
            end
        end
    end

    //(always_comb)
    always_comb begin
        next_state = current_state;
      
        case (current_state)
            IDLE: begin
                if (start) next_state = LOAD;
            end
            LOAD: begin
                next_state = COMPUTE;
            end
            COMPUTE: begin
                if (count == 6'd31) next_state = DONE;
            end
            DONE: begin
                if (!start) next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // saidas
    always_comb begin
        load       = (current_state == LOAD);
        compute_en = (current_state == COMPUTE);
        done       = (current_state == DONE);
    end

endmodule
