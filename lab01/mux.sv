module mux
  (
    output logic f,
    input  logic a, b, c, d, [1:0]sel
  ); 

  and g1(f1, a, n_sel_1, n_sel_0),
      g2(f2, b, n_sel_1, sel[0]),
      g3(f3, c, sel[1], n_sel_0),
      g4(f4, d, sel[1], sel[0]);
  or  g5(f, f1, f2, f3, f4);
  not g6(n_sel_0, sel[0]),
      g7(n_sel_1, sel[1]);

endmodule
