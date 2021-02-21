`timescale 1ns / 1ps

module pc_testbench;

reg i_clk, i_rst_n;
reg [31:0] i_pc;
wire [31:0] o_pc;

pc pc_mod(.i_clk  (i_clk),
		  .i_rst_n(i_rst_n),
		  .i_pc   (i_pc),
		  .o_pc   (o_pc)
		  );

initial begin
	i_clk = 0;
	forever #20 i_clk = ~i_clk;
end


initial begin 
	i_rst_n = 1'b0;
	#10 i_rst_n = 1'b1;
	forever #15 i_pc = $urandom % 1000;
end

initial #400 $finish ;

endmodule