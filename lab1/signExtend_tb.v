`timescale 1ns / 1ps

module sign_testbench;

reg [15:0] i_data;
reg en;
wire [31:0] o_data;

signExtend sign1(.i_data(i_data),
				 .en    (en),
				 .o_data(o_data)
				 );

initial begin
	i_data = 0;
	forever #20 i_data = $urandom % 65500;
end

initial begin
	en = 0;
	#500 en = 1;
end

initial #1000 $finish;

endmodule