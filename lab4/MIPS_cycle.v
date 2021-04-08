module MIPS_cycle(
	input i_clk,    // Clock
	input [31:0] instr, 
	input i_rst_n,  // Asynchronous reset active low
	output reg [31:0] o_reg,
	output reg [31:0] o_dataMem
);

wire [31:0] toPC ;
wire [31:0] fromPC;
wire [31:0] fromRom;
wire [31:0] BusA, BusB;
wire [4:0] outregm;
wire [31:0] mToMux;
wire [31:0] AluToRam;
wire [31:0] ramOut;
wire [31:0] BusW;
wire [31:0] muxToPC;
wire [3:0]  ALUContr;
wire [31:0] test = 32'b01;


wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [25:0] imm26;
wire [15:0] imm16;


wire [1:0] r_aluOp;
wire r_zf;
wire r_regDst;
wire r_memToReg;
wire r_regWrite;
wire r_ALUSrc;
wire r_memWrite;
wire r_branch;
wire r_jump;


wire PCSrc;
wire [31:0] JoB;
//assign toPC = instr;

assign o_reg = BusW;
assign o_dataMem = BusB;

assign rd = fromRom[15:11];
assign rt = fromRom[20:16];
assign rs = fromRom[25:21];
assign imm26 = fromRom[25:0];
assign imm16 = fromRom[15:0];


pc pc1(.i_clk  (i_clk),
	   .i_rst_n(i_rst_n),
	   .i_pc   (muxToPC),
	   .o_pc   (fromPC)
	  );


adder addPC(.i_op1   (fromPC),
			.i_op2   (32'd4),
			.o_result(toPC)
		   );


rom #(.DATA_WIDTH(32), .ADDR_WIDTH(30)) rom1(.i_addr(fromPC[31:2]),
		 .o_data(fromRom)
		);


NextPc nxt(.i_incPC	(toPC),
		   .i_Imm26	(imm26),
		   .i_branch(r_branch),
		   .i_jump	(r_jump),
		   .i_zero	(r_zf),
		   .o_PCSrc	(PCSrc),
		   .o_JoB	(JoB)
		  );

mux2in1 muxNextPC(.i_dat0(toPC),
				  .i_dat1(JoB),
				  .i_control(PCSrc),
				  .o_dat(muxToPC)
				 );


control contr1(.i_instrCode(fromRom[31:26]),
			   .o_regDst   (r_regDst),
               .o_jump     (r_jump), 
               .o_branch   (r_branch),
               .o_memToReg (r_memToReg),
               .o_aluOp    (r_aluOp),
               .o_memWrite (r_memWrite),
               .o_aluSrc   (r_ALUSrc),
               .o_regWrite (r_regWrite)
			  );


aluControl AC1(.i_aluOp     (r_aluOp),
			   .i_func      (fromRom[5:0]),
			   .o_aluControl(ALUContr)
			  );



mux2in1 #(.WIDTH(5)) regmux(.i_dat0   (rt),
			   				.i_dat1   (rd),
			   				.i_control(r_regDst),
			   				.o_dat    (outregm)
			  				);


regFile regOut(.i_clk	(i_clk),
			   .i_raddr1(rs),
			   .i_raddr2(rt),
			   .i_waddr	(outregm),
			   .i_wdata	(BusW),
			   .i_we	(r_regWrite),
			   .o_rdata1(BusA),
			   .o_rdata2(BusB)
			  );

signExtend SignToAlu(.i_data(imm16),
					 .en    (1'b0),
					 .o_data(mToMux)
					);

wire [31:0] muxToAlu;
mux2in1 mToALU(.i_dat0	 (BusB),
			   .i_dat1	 (mToMux),
			   .i_control(r_ALUSrc),
			   .o_dat 	 (muxToAlu)
			  );


alu alu1(.i_op1    (BusA),
		 .i_op2    (muxToAlu),
		 .i_control(ALUContr),
		 .o_result (AluToRam),
		 .o_zf     (r_zf)
		);

ram ram1(.i_clk (i_clk),
		 .i_we  (r_memWrite),
		 .i_addr(AluToRam),
		 .i_data(BusB),
		 .o_data(ramOut)
		);

mux2in1 mAfterRam(.i_dat0	(AluToRam),
				  .i_dat1	(ramOut),
				  .i_control(r_memToReg),
				  .o_dat    (BusW)
				 );

endmodule
//				rd rs rt
//08000005 - jump
//00850820 - add r1, r5, r4
//10C70003 - beq r6 r7 0x0003
//10000001 - beq r0 r0 0x0001
//AC290001 - sw r9 0x0001 r1
//8C21000A - lw r9 0x000A r1


//101011_00001_01001_0000000000000001
//op      rs     rt       offset
//(1010_11)(00_001)(0_1001)_0000000000000001
//  A     C      2     9
//(0000_00)(00_100)(0_0101)_(0010_0)000_00(10_0000)
//			rs       rt          rd
//000000_00100_00101_00100_00000100000
//0x00852020

/*
n_find
ADD v0, v0, a0     -  0x00441020
SUB a0, a0, t0     -  0x00882022
BEQ a0, t1, 0x0002 -  0x10890001
J   0			   -  0x08000000
*/

//(0000_00)(00_100)(0_0101)_(0000_1)(000_00)(10_0000)