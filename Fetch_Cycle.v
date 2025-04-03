`include "Mux.v"
`include "P_c.v"
`include "Instruction_Memory.v"
`include "PC_Adder.v"
module Fetch_Cycle(clk,rst,PCTargetE,PCSrcE,InstrD,PCD,PCPlus4D);
input clk,rst,PCSrcE;
input [31:0] PCTargetE;
output [31:0] InstrD,PCD,PCPlus4D;
wire [31:0] PC_F,PCF,PCPlus4F,InstrF;
reg [31:0]InstrF_reg,PCF_reg,PCPlus4F_reg;
 Mux Mux_1(
    .a(PCPlus4F),
    .b(PCTargetE),
    .s(PCSrcE),
    .c(PC_F)
);
P_c Program_Counter(
    .PC_NEXT(PC_F),
    .PC(PCF),
    .rst(rst),
    .clk(clk)
);
Instr_Mem Instr_Mem(
    .A(PCF),
    .rst(rst),
    .RD(InstrF)
);
PC_Adder PC_Adder(
    .a(PCF),
    .b(32'h00000004),
    .c(PCPlus4F)
);
//FETCH CYCLE REGISTER LOGIC
    always @(posedge clk or negedge rst) begin
        if(rst==1'b1) begin
            InstrF_reg <= 32'h00000000;
            PCF_reg <= 32'h00000000;
            PCPlus4F_reg <= 32'h00000000;
        end
        else begin
            InstrF_reg <=InstrF;
            PCF_reg <=PCF;
            PCPlus4F_reg <=PCPlus4F;
        end
    end
//assigning Registers value to the output port
assign InstrD = (rst==1'b1)?32'h00000000:InstrF_reg;
assign PCD=(rst==1'b1)?32'h00000000:PCF_reg;
assign PCPlus4D=(rst==1'b1)?32'h00000000:PCPlus4F_reg;
endmodule