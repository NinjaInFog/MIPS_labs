module rom
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
	input [(ADDR_WIDTH-1):0] i_addr,
	output [(DATA_WIDTH-1):0] o_data
);

reg [(DATA_WIDTH-1):0] f_rom [(2**ADDR_WIDTH)-1:0];  

initial $readmemh("rom_init.dat", f_rom);

assign o_data = f_rom[i_addr];
endmodule