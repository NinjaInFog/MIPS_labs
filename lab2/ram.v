module ram(i_clk, i_addr, i_data, i_we, o_data);
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 5; 

input                     i_clk, i_we;// if i_we then write else if !i_we then read
input   [ADDR_WIDTH-1:0]  i_addr;
input   [DATA_WIDTH-1:0]  i_data;
output reg [DATA_WIDTH-1:0]  o_data;


reg [DATA_WIDTH-1:0] mem [0:31];

assign o_data = mem[i_addr];

always @(posedge i_clk) begin 
	if(i_we) begin
		mem[i_addr] <= i_data;
	end
end

endmodule