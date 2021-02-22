`timescale 1ns / 1ps

module shift_testbench;

parameter WIDTH = 32;
reg [WIDTH-1:0] i_data;
wire [WIDTH-1:0] o_data;

shiftLeftBy2 shift1(.i_data(i_data),
					.o_data(o_data)
					);

initial begin
	forever #20 i_data = $urandom % 1000;
end

initial #400 $finish;

endmodule