`include "Mux.v"
module writeback_cycle(clk, rst, ResultSrcL, ReadDataW, PCPlus4W, ALU_ResultW,ResultW);
input clk, rst, ResultSrcL;
input [31:0] ReadDataW, PCPlus4W, ALU_ResultW;
output [31:0] ResultW;
Mux result_mux(
    .a(ALU_ResultW),
    .b(ReadDataW),
    .s(ResultSrcL),
    .c(ResultW)
    );

endmodule