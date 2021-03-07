`timescale 1ns / 1ps

module testbench;

integer j;

reg i_clk, i_we;		  //ok
reg [31:0]  i_op1, i_op2; //ok
reg [3:0]   i_control;	  //ok
reg [1:0]   i_aluop;	  //ok
reg [5:0]   i_func;		  //ok
reg [4:0]   i_addram;	  //
reg [7:0]   i_addrom;     //ok
reg [31:0]  i_data;		  //ok	
wire [31:0] o_result_adder;
wire [31:0] o_result;
wire [31:0] o_data_rom;
wire [31:0] o_data_ram;
wire [3:0]  o_aluControl; 
wire o_zf;

assign i_control = o_aluControl;
assign i_aluop   = o_data_rom[25:24];
assign i_func    = o_data_rom[5:0];
assign i_data    = o_result;


adder adder1(.i_op1   (i_op1),
			 .i_op2   (i_op2),
			 .o_result(o_result_adder)
			);

alu   alu1(.i_op1    (i_op1),
		   .i_op2    (i_op2),
		   .i_control(i_control),
		   .o_result (o_result),
		   .o_zf     (o_zf));

aluControl contr1(.i_aluOp     (i_aluop),
				  .i_func      (i_func),
				  .o_aluControl(o_aluControl)
				  );

ram ram1(.i_clk (i_clk),
		 .i_we  (i_we),
		 .i_addr(i_addram),
		 .i_data(i_data),
		 .o_data(o_data_ram)
		 );

rom rom1(.i_addr(i_addrom),
		 .o_data(o_data_rom)
		 );

initial begin
	i_clk = 0;
	forever #20 i_clk = ~i_clk;
end

initial begin
	i_op1 = 32'b0;
	i_op2 = 32'b0; 
	forever begin 
		#20
		i_op1 = $urandom % (2**32 - 1);
		i_op2 = $urandom % (2**32 - 1);
	end
end

initial begin 
	i_addrom = 0;
	#100 i_addrom = 1;
	#100 i_addrom = 2;
	#100 i_addrom = 3;
	#100 i_addrom = 4;
	#100 i_addrom = 5;
	#100 i_addrom = 6;
	#100 i_addrom = 7;
end

initial begin
i_addram = 0;
 for (j = 1; j < 3; j = j+1) begin
 	#100 i_addram = j;
 	 
 end
end

initial begin
	i_addram = #300 0;
	i_addram = #400 1;
	i_addram = #500 2;
end


//////////////

initial begin
	i_we = 1;
	#300 i_we = 0;
end


/////////////



initial #800 $finish;
endmodule 