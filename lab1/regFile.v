module regFile(
	input 		  i_clk, 
    input  [4:0]  i_raddr1, 
    input  [4:0]  i_raddr2, 
    input  [4:0]  i_waddr, 
    input  [31:0] i_wdata, 
    input 		  i_we,
    output [31:0] o_rdata1,
    output [31:0] o_rdata2 
    );

parameter WIDTH = 32;

reg [WIDTH:0] r_file [WIDTH:0];

initial $readmemh("file.txt", r_file);

assign o_rdata1 = r_file[i_raddr1];
assign o_rdata2 = r_file[i_raddr2];


@always @(posedge i_clk) begin 
	if(i_we) begin
		r_file[i_waddr] <= i_wdata;
	end
end

  
endmodule