module Data_Mem(A,WD,WE,RD,clk,rst);
input [31:0]A,WD;
input clk,rst,WE;
output [31:0]RD;
reg [31:0]Data_MEM[1023:0];
always @(posedge clk ) 
begin
    if(WE)
        begin
        Data_MEM[A]<=WD;
        end
end
assign RD = (rst==1'b1) ? 32'd0 : Data_MEM[A];
initial begin
    // Data_MEM[28]=32'h00000020;
    //  Data_MEM[40]=32'h00000002;
    //    Data_MEM[6]=32'h00000016;
       Data_MEM[0]=32'h00000000;
end
endmodule
