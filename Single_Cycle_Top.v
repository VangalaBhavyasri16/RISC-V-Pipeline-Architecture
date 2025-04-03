`include "P_c.v"
`include "Instruction_Memory.v"
`include "Register_file.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_Unit_Top.v"
`include "Data_Mem.v"
`include "PC_Adder.v"
`include "Mux.v"
module Single_Cycle_Top(clk,rst);
input clk,rst;
wire [31:0] PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult,ReadData,PCPlus4,RD2_Top,SrcB,Result;
wire RegWrite,MemWrite,ALUSrc,ResultSrc;
wire [1:0]ImmSrc;
wire [2:0]ALUControl_Top;
P_c PC(
    .clk(clk),
    .rst(rst),
    .PC(PC_Top),
    .PC_NEXT(PCPlus4)
);
PC_Adder PC_Adder(
    .a(PC_Top),
    .b(32'd4),
    .c(PCPlus4)
);
Instr_Mem Instr_Mem(
    .rst(rst),
    .A(PC_Top),
    .RD(RD_Instr)
);
Reg_file Reg_file(
    .clk(clk),
    .rst(rst),
    .A1(RD_Instr[19:15]),
    .A2(RD_Instr[24:20]),
    .A3(RD_Instr[11:7]),
    .WD3(Result),
    .WE3(RegWrite),
    .RD1(RD1_Top),
    .RD2(RD2_Top)
);
Sign_Extend Sign_Extend(
        .In(RD_Instr),
        .Imm_Ext(Imm_Ext_Top),
        .ImmSrc(ImmSrc[0])
);
Mux Mux_Register_to_Alu(
    .a(RD2_Top),
    .b(Imm_Ext_Top),
    .s(ALUSrc),
    .c(SrcB)
);
alu alu(
    .A(RD1_Top),
    .B(SrcB),
    .ALUControl(ALUControl_Top),
    .Result(ALUResult),
    .Z(),
    .N(),
    .V(),
    .C()
);
Control_Unit_Top Control_Unit_Top(
    .Op(RD_Instr[6:0]),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(),
    .funct3(RD_Instr[14:12]),
    .funct7(),
    .ALUControl(ALUControl_Top)
);
Data_Mem Data_Mem(
    .A(ALUResult),
    .WD(RD2_Top),
    .WE(MemWrite),
    .RD(ReadData),
    .clk(clk),
    .rst(rst)
);
Mux Mux_DataMem_to_Register(
    .a(ALUResult),
    .b(ReadData),
    .s(ResultSrc),
    .c(Result)
);                                 
endmodule