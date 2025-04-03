module Reg_file(A1,A2,A3,WD3,WE3,clk,rst,RD1,RD2);
input [4:0]A1,A2,A3;
input[31:0] WD3;
input clk,rst,WE3;
output [31:0]RD1,RD2;
//creating temporary memory
reg[31:0] Registers[31:0];

always @(posedge clk)
    begin
        if(WE3&(A3!=5'h00))
            begin
                Registers[A3]<=WD3;
            end
    end
    assign RD1=(rst==1'b1)?32'h00000000:Registers[A1];
    assign RD2=(rst==1'b1)?32'h00000000:Registers[A2];
initial begin 
    Registers[0]=32'h00000000;
    
end
endmodule