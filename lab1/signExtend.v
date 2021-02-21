module signExtend(
	input  [15:0] i_data,
	input 		  en, 
	output [31:0] o_data
	);

assign o_data = en ? {{16{i_data[15]}}, i_data} : i_data;

endmodule