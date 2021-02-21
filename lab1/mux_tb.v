`timescale 1ns / 1ps

module mux_testbench;

parameter WIDTH = 32;

reg [WIDTH-1:0] i_data0, i_data1;
reg i_control;
wire [WIDTH-1:0] o_dat;

mux2in1 mux_2(.i_dat0   (i_data0),
			  .i_dat1   (i_data1),
			  .i_control(i_control),
			  .o_dat    (o_dat)
			  );


initial begin
	i_control = 0;
	i_data1 = 0;
	forever #20 i_data1 = $urandom % 1000;
end

initial begin 
	i_data0 = 0;
	forever #20 i_data0 = $urandom % 700;
end
initial #200 i_control = 1;


initial #400 $finish;



endmodule