`ifndef MUX_V
`define MUX_V
module Mux(a,b,s,c);
    input [31:0]a,b;
    input s;
    output [31:0]c;
    assign c=(s==1'b0)?a:b;
endmodule
`endif

`ifndef MUX_3_by_1_V
`define MUX_3_by_1_V
module Mux_3_by_1 (a,b,c,s,d);
    input [31:0] a,b,c;
    input [1:0] s;
    output [31:0] d;
    assign d = (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : 32'h00000000;
endmodule
`endif