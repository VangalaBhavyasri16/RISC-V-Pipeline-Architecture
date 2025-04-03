module alu(A,B,ALUControl,Result,Z,N,V,C);
input [31:0]A,B;
input [2:0]ALUControl;
output [31:0] Result;
output Z,N,V,C;

wire cout;
wire [31:0] sum;
 assign sum = (ALUControl[0] == 1'b0) ? A + B :(A + ((~B)+1));
    assign {cout,Result} = (ALUControl == 3'b000) ? sum :
                           (ALUControl == 3'b001) ? sum :
                           (ALUControl == 3'b010) ? A & B :
                           (ALUControl == 3'b011) ? A | B :
                           (ALUControl == 3'b101) ? {{32{1'b0}},(sum[31])} :
                           {33{1'b0}};
assign Z=&(~Result);
assign N=Result[31];
assign C=cout&(~ALUControl[1]);
assign V=((sum[31] ^ A[31]) & (~(ALUControl[0] ^ B[31] ^ A[31])) &(~ALUControl[1]));
endmodule