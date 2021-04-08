`timescale 1ns / 1ps

module testbench;

reg i_clk;
reg [31:0] instr;
reg i_rst_n;

wire [31:0] o_reg;
wire [31:0] o_datamem;


MIPS_cycle mips1(.i_clk	   (i_clk),
				 .instr	   (instr),
				 .i_rst_n  (i_rst_n),
				 .o_reg	   (o_reg),
				 .o_dataMem(o_datamem)
				);

initial begin
	i_clk = 0;
	instr = 32'b0;
	forever #20 i_clk = ~i_clk;
end

initial begin
	i_rst_n = 1'b0;
	#20 i_rst_n = 1'b1;

end

initial #3000 $finish;

endmodule