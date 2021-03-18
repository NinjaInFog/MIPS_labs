module NextPc (
	input  [31:0] i_incPC,   
	input  [25:0] i_Imm26, 
	input  		  i_branch,
	input  		  i_jump,
	input 		  i_zero,
	output  	  o_PCSrc,
	output [31:0] o_JoB
);

wire [31:0] result;
wire [31:0] extended;
wire [31:0] muxed;

assign o_JoB = muxed;
assign o_PCSrc = i_jump || (i_branch && i_zero);


signExtend sign1(.i_data(i_Imm26[15:0]),
				 .en    (1'b1),
				 .o_data(extended)
				);

adder ad1(.i_op1   (i_incPC),
		  .i_op2   (extended),
		  .o_result(result)
		 );

mux2in1 target(.i_dat0   (result),
			   .i_dat1   ({i_incPC[31:28],i_Imm26,2'b0}),
			   .i_control(i_jump),
			   .o_dat    (muxed)
			  );


endmodule