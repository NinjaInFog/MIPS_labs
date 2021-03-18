module control(i_instrCode, 
               o_regDst,
               o_jump, 
               o_branch,
               o_memToReg,
               o_aluOp,
               o_memWrite,
               o_aluSrc,
               o_regWrite
               );
               
// if {Op_code[31:26], func[5:0]} when input [11:0] i_instrCode; 
//if only Op_code[31:26] - when   input [5:0] i_instrCode; 
 
//input     [11:0]  i_instrCode;
input     [5:0]  i_instrCode; 
output            o_regDst;
output            o_regWrite;
output            o_aluSrc;
output            o_branch;
output            o_jump; 
output            o_memWrite;
output            o_memToReg;
output    [1:0]   o_aluOp;



localparam ADDI = 6'b001000, ANDI = 6'b001100;
localparam  ORI = 6'b001101,   LW = 6'b100011;
localparam   SW = 6'b101011,  BEQ = 6'b000100;
localparam    J = 6'b000010,    R = 6'b000000;

reg [8:0] r_temp;

assign {o_regDst, o_regWrite, o_aluSrc, o_branch, o_jump, o_memWrite, o_memToReg, o_aluOp} = r_temp;


always @(*) begin 
	case (i_instrCode)
		R   : r_temp <= 9'b1_1000_00_00;
		ADDI: r_temp <= 9'b0_1100_00_01;
		ANDI: r_temp <= 9'b0_1100_00_00;
		ORI : r_temp <= 9'b0_1100_00_00;
		LW  : r_temp <= 9'b0_1100_01_01;
		SW  : r_temp <= 9'bx_0100_1x_01;
		BEQ : r_temp <= 9'bx_0010_0x_10;
		J   : r_temp <= 9'bx_0xx1_0x_xx;
		default : r_temp <= 9'bx;
	endcase // i_instrCode
end
  
endmodule