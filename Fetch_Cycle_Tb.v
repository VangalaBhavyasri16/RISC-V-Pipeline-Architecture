module tb();
    reg clk=1'b0,rst,PCSrcE;
    reg [0:31] PCTargetE;
    wire [0:31] InstrD,PCD,PCPlus4D;
    Fetch_Cycle dut(
        .clk(clk),
        .rst(rst),
        .PCTargetE(PCTargetE),
        .PCSrcE(PCSrcE),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );
     always begin
        clk=~clk;#50;
    end
    initial begin
        rst<=1'b1;#200;
        rst<=1'b0;
        PCSrcE<=1'b0;
        PCTargetE<=32'h00000000;
        #500;
        $finish;
    end
     initial begin
        $dumpfile("dump.vcd");
         $dumpvars(0);
    end
endmodule