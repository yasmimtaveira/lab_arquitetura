module muxcmp (
    output logic [31:0] f,
    input logic [31:0] a, b, c, d,
    input logic [1:0] sel
);

    mux m0 (.f(f[0]),.a(a[0]),.b(b[0]),.c(c[0]),.d(d[0]),.sel(sel));

    mux m1 (.f(f[1]),.a(a[1]),.b(b[1]),.c(c[1]),.d(d[1]),.sel(sel));

    mux m2 (.f(f[2]),.a(a[2]),.b(b[2]),.c(c[2]),.d(d[2]),.sel(sel));

    mux m3 (.f(f[3]),.a(a[3]),.b(b[3]),.c(c[3]),.d(d[3]),.sel(sel));

    mux m4 (.f(f[4]),.a(a[4]),.b(b[4]),.c(c[4]),.d(d[4]),.sel(sel))

    mux m5 (.f(f[5]),.a(a[5]),.b(b[5]),.c(c[5]),.d(d[5]),.sel(sel));

    mux m6 (.f(f[6]),.a(a[6]),.b(b[6]),.c(c[6]),.d(d[6]),.sel(sel));

    mux m7 (.f(f[7]),.a(a[7]),.b(b[7]),.c(c[7]),.d(d[7]),.sel(sel));

    mux m8 (.f(f[8]),.a(a[8]),.b(b[8]),.c(c[8]),.d(d[8]),.sel(sel));

    mux m9 (.f(f[9]),.a(a[9]),.b(b[9]),.c(c[9]),.d(d[9]),.sel(sel));

    mux m10 (.f(f[10]),.a(a[10]),.b(b[10]),.c(c[10]),.d(d[10]),.sel(sel));

    mux m11 (.f(f[11]),.a(a[11]),.b(b[11]),.c(c[11]),.d(d[11]),.sel(sel));

    mux m12 (.f(f[12]),.a(a[12]),.b(b[12]),.c(c[12]),.d(d[12]),.sel(sel));

    mux m13 (.f(f[13]),.a(a[13]),.b(b[13]),.c(c[13]),.d(d[13]),.sel(sel));

    mux m14 (.f(f[14]),.a(a[14]),.b(b[14]),.c(c[14]),.d(d[14]),.sel(sel));

    mux m15 (.f(f[15]),.a(a[15]),.b(b[15]),.c(c[15]),.d(d[15]),.sel(sel));

    mux m16 (.f(f[16]),.a(a[16]),.b(b[16]),.c(c[16]),.d(d[16]),.sel(sel));

    mux m17 (.f(f[17]),.a(a[17]),.b(b[17]),.c(c[17]),.d(d[17]),.sel(sel));

    mux m18 (.f(f[18]),.a(a[18]),.b(b[18]),.c(c[18]),.d(d[18]),.sel(sel));

    mux m19 (.f(f[19]),.a(a[19]),.b(b[19]),.c(c[19]),.d(d[19]),.sel(sel));

    mux m20 (.f(f[20]),.a(a[20]),.b(b[20]),.c(c[20]),.d(d[20]),.sel(sel));

    mux m21 (.f(f[21]),.a(a[21]),.b(b[21]),.c(c[21]),.d(d[21]),.sel(sel));

    mux m22 (.f(f[22]),.a(a[22]),.b(b[22]),.c(c[22]),.d(d[22]),.sel(sel));
    
    mux m23 (.f(f[23]),.a(a[23]),.b(b[23]),.c(c[23]),.d(d[23]),.sel(sel));

    mux m24 (.f(f[24]),.a(a[24]),.b(b[24]),.c(c[24]),.d(d[24]),.sel(sel));

    mux m25 (.f(f[25]),.a(a[25]),.b(b[25]),.c(c[25]),.d(d[25]),.sel(sel));

    mux m26 (.f(f[26]),.a(a[26]),.b(b[26]),.c(c[26]),.d(d[26]),.sel(sel));

    mux m27 (.f(f[27]),.a(a[27]),.b(b[27]),.c(c[27]),.d(d[27]),.sel(sel));  

    mux m28 (.f(f[28]),.a(a[28]),.b(b[28]),.c(c[28]),.d(d[28]),.sel(sel));

    mux m29 (.f(f[29]),.a(a[29]),.b(b[29]),.c(c[29]),.d(d[29]),.sel(sel));

    mux m30 (.f(f[30]),.a(a[30]),.b(b[30]),.c(c[30]),.d(d[30]),.sel(sel));

    mux m31 (.f(f[31]),.a(a[31]),.b(b[31]),.c(c[31]),.d(d[31]),.sel(sel));

endmodule
