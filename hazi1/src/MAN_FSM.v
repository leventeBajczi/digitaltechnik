`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:33:01 10/01/2017 
// Design Name: 
// Module Name:    MAN_FSM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MAN_FSM(
    input clk,
    input rst,
    output [2:0] man_out
    );
	
	 reg [2:0] state;
	 reg [2:0] next_state;
	 wire a, b, c;
	 assign {a,b,c} = state;
	 
	 always @ (posedge clk)
	 begin
		 if(rst)	state <= 3'b0;
		 else	
			begin
				next_state[0] =  a & ~b & ~c | ~b &  c | ~a &  b & ~c;
				next_state[1] = ~a;
				next_state[2] =  a & ~b & ~c |  b &  c | ~a &  b & ~c;
				state <= next_state;
			end
	 end
	 	 
	 assign man_out = state;

endmodule
