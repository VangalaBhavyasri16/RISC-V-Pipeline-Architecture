`include "Fetch_Cycle.v"
`include "Decode_Cycle.v"
`include "Execute_Cycle.v"
`include "Memory_Cycle.v"
`include "WriteBack_Cycle.v"
`include "Hazard_unit.v"
module Pipeline_top(clk,rst);
input clk,rst;
wire PCSrcE,RegWriteW,RegWriteE,ALUSrcE,MemWriteE,ResultSrcE,BranchE,RegWriteM,MemWriteM,ResultSrcM,ResultSrcW;
wire [2:0] ALUControlE;
wire [4:0] RDW,RD_E,RD_M;
wire [31:0]PCTargetE,InstrD,PCD,PCPlus4D,ResultW,RD1_E,RD2_E,Imm_Ext_E,PCE,PCPlus4E,PCPlus4M,WriteDataM,ALU_ResultM;
wire [31:0] PCPlus4W,ALU_ResultW,ReadDataW;
wire [1:0] ForwardAE,ForwardBE;
wire [4:0] RS1_E,RS2_E;
Fetch_Cycle Fetch(
    .clk(clk),
    .rst(rst),
    .PCTargetE(PCTargetE),
    .PCSrcE(PCSrcE),
    .InstrD(InstrD),
    .PCD(PCD),
    .PCPlus4D(PCPlus4D)
    );

Decode_Cycle Decode(
    .clk(clk),
    .rst(rst),
    .InstrD(InstrD),
    .PCD(PCD),
    .PCPlus4D(PCPlus4D),
    .RegWriteW(RegWriteW),
    .RDW(RDW),
    .ResultW(ResultW),
    .RegWriteE(RegWriteE),
    .ALUSrcE(ALUSrcE),
    .MemWriteE(MemWriteE),
    .ResultSrcE(ResultSrcE),
    .BranchE(BranchE),
    .ALUControlE(ALUControlE),
    .RD1_E(RD1_E),
    .RD2_E(RD2_E),
    .Imm_Ext_E(Imm_Ext_E),
    .RD_E(RD_E),
    .PCE(PCE),
    .PCPlus4E(PCPlus4E),
    .RS1_E(RS1_E),
    .RS2_E(RS2_E)
    );

execute_cycle Execute(
    .clk(clk),
    .rst(rst),
    .RegWriteE(RegWriteE), 
    .ALUSrcE(ALUSrcE), 
    .MemWriteE(MemWriteE), 
    .ResultW(ResultW),
    .ResultSrcE(ResultSrcE),
    .BranchE(BranchE),
    .ALUControlE(ALUControlE),
    .RD1_E(RD1_E), 
    .RD2_E(RD2_E),
    .Imm_Ext_E(Imm_Ext_E), 
    .RD_E(RD_E),
    .PCE(PCE),
    .PCPlus4E(PCPlus4E),
    .PCSrcE(PCSrcE),
    .PCTargetE(PCTargetE),
    .RegWriteM(RegWriteM),
    .MemWriteM(MemWriteM),
    .ResultSrcM(ResultSrcM),
    .RD_M(RD_M),
    .PCPlus4M(PCPlus4M),
    .WriteDataM(WriteDataM),
    .ALU_ResultM(ALU_ResultM),
    .ForwardA_E(ForwardAE),
    .ForwardB_E(ForwardBE)
    );

memory_cycle Memory(
    .clk(clk),
    .rst(rst),
    .RegWriteM(RegWriteM),
    .MemWriteM(MemWriteM),
    .ResultSrcM(ResultSrcM),
    .RD_M(RD_M),
    .PCPlus4M(PCPlus4M),
    .WriteDataM(WriteDataM),
    .ALU_ResultM(ALU_ResultM),
    .RegWriteW(RegWriteW),
    .ResultSrcW(ResultSrcW),
    .RD_W(RDW),
    .PCPlus4W(PCPlus4W),
    .ALU_ResultW(ALU_ResultW),
    .ReadDataW(ReadDataW)
    );

writeback_cycle WriteBack(
    .clk(clk), 
    .rst(rst),
    .ResultSrcL(ResultSrcW), 
    .ReadDataW(ReadDataW),
    .PCPlus4W(PCPlus4W), 
    .ALU_ResultW(ALU_ResultW),
    .ResultW(ResultW)
    );
hazard_unit Forwarding_block(
    .rst(rst),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .RD_M(RD_M),
    .RD_W(RDW),
    .Rs1_E(RS1_E),
    .Rs2_E(RS2_E),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE)
);

endmodule