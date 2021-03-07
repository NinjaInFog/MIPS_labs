module aluControl(i_aluOp, i_func, o_aluControl);
 
input       [1:0]   i_aluOp;
input       [5:0]   i_func;
output  reg [3:0]   o_aluControl;

localparam AND = 4'b0000, OR = 4'b0001, ADD = 4'b0010;
localparam SUB = 4'b0110, SOLT = 4'b0111, NOR = 4'b1100;

always @(*) begin 
case (i_aluOp)
	2'b00: case (i_func)
			6'b100100 : o_aluControl = AND;
			6'b100101 : o_aluControl = OR;
			6'b100000 : o_aluControl = ADD;
			6'b100010 : o_aluControl = SUB;
			6'b101010 : o_aluControl = SOLT;
			6'b100111 : o_aluControl = NOR;
		default : o_aluControl = 4'bxxxx;
	endcase
	2'b01: o_aluControl <= ADD;
	2'b10: o_aluControl <= SUB;
	default : o_aluControl = 4'bxxxx;
endcase

end

endmodule