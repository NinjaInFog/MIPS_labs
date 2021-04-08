module signExtend(
	input  [15:0] i_data,
	input 		  en, 
	output [31:0] o_data
	);

assign o_data = en ? {{14{i_data[15]}}, i_data, 2'b0} : {16'b0,i_data};

endmodule