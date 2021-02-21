`timescale 1ns / 1ps

module regfile_testbench;

reg i_clk, i_we;
reg [4:0] i_raddr1, i_raddr2, i_waddr;
reg [31:0] i_wdata;
wire [31:0] o_rdata1, o_rdata2;
integer i, j;
regFile file1(.i_clk   (i_clk),
			  .i_raddr1(i_raddr1),
			  .i_raddr2(i_raddr2),
			  .i_waddr (i_waddr),
			  .i_wdata (i_wdata),
			  .i_we    (i_we),
			  .o_rdata1(o_rdata1),
			  .o_rdata2(o_rdata2)
			  );

initial begin 
	i_clk = 0;
	forever #20 i_clk = ~i_clk;
end

initial begin
	i_we        = 0;
	i_wdata     = 0;
	#200 i_we   = 1;
	#5 i_wdata  = 10010101;
	#30 i_wdata = 01010110;
	#30 i_wdata = 10110010;
	#30 i_wdata = 00111010;
end

initial begin
	i_waddr = 0;
	#200 i_waddr = 3;
	#10 i_waddr  = 11;
	#30 i_waddr  = 5;
	#30 i_waddr  = 7;
end

initial begin
	i_raddr1 = 0;
	for (i = 0; i < 32; i = i + 1) begin
		#10 i_raddr1 = i;
	end
end

initial begin
	i_raddr2 = 0;
	for (j = 0; j < 32; j = j + 1) begin
		#10 i_raddr2 = j;
	end
end

initial #800 $finish;

endmodule