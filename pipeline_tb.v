module tb();
 reg clk=1'b0,rst;
     Pipeline_top dut (
        .clk(clk),
         .rst(rst)
         );
always begin 
    clk=~clk;#50;
end
initial begin
    rst <=1'b1;#200;
    rst<=1'b0;#1500;
    $finish;
end
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
end
endmodule