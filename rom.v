// v0.0.1
`timescale 1ns/ 1ps
// `include "my_header.vh"
module  mem(input clk, input[MEM_ADDR-1:0] addr, output reg[WIDTH-1:0] led_out);
	reg[WIDTH-1:0] rom [(1<<MEM_ADDR)-1:0]
		always @(posedge clk ) 
		begin 
			rom ['b0000] <= 'b0000_0001 ;
			rom ['b0001] <= 'b0000_0010 ;
			rom ['b0010] <= 'b0000_0100 ;
			rom ['b0011] <= 'b0000_1000 ;
			rom ['b0100] <= 'b0001_0000 ;
			rom ['b0101] <= 'b0010_0000 ;
			rom ['b0110] <= 'b0100_0000 ;
			rom ['b0111] <= 'b1000_0000 ;
			rom ['b1000] <= 'b1111_1111 ;
			rom ['b1001] <= 'b1111_1110 ;
			rom ['b1010] <= 'b1111_1100 ;
			rom ['b1011] <= 'b1111_1000 ;
			rom ['b1100] <= 'b1111_0000 ;
			rom ['b1101] <= 'b1110_0000 ;
			rom ['b1110] <= 'b1100_0000 ;
			rom ['b1111] <= 'b1000_0000 ;	 
		end
		always @(posedge clk)
			led_out <= rom[addr];
endmodule 
