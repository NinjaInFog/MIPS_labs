module pc(
	input		      i_clk,
	input 		      i_rst_n, 
	input      [31:0] i_pc, 
	output reg [31:0] o_pc
	);

always @(posedge clk or negedge i_rst_n) begin 
	if(~rst_n) begin
		o_pc <= 0;
	end else begin
		o_pc <= i_pc;
	end
end
   
endmodule