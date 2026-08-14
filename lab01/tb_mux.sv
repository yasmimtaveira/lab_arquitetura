`timescale 1ns/1ps

module tb_mux;
   logic [2:0]count; // precisa de 2 bits pra simular seletor
   logic [31:0]muxOut; // saida de 32 bits
   logic [31:0]a, b, c, d;

    // mux 4:1 de 32 bits
   muxcmp dut(.f(muxOut), .a(a), .b(b), .c(c), .d(d), .sel(count));

   initial begin

    // valores de entrada para teste
    a = 32'b1;
    b = 32'b11;
    c = 32'b111;
    d = 32'b1111;

     $monitor($time," - a = %h | b = %h | c = %h | d = %h | sel = %b | muxOut = %h", a, b, c, d, count[1:0], muxOut);
     for(count = 0; count != 2'b11; count++) begin
     #10;
     a = a + 1;
     b = b + 4;
     c = c + 1;
     d = d + 2;
     end     
     #10 $stop;
   end

endmodule: tb_mux