`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:36:52 10/02/2017 
// Design Name: 
// Module Name:    STD_FSM 
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
module STD_FSM(
    input clk,
    input rst,
    output [2:0] std_out
    );
	 parameter START 	= 3'b000;
	 parameter A 		= 3'b010;
	 parameter B		= 3'b111;
	 parameter C 		= 3'b100;
	 parameter D		= 3'b101;
	 parameter E 		= 3'b001;
	 parameter F		= 3'b011;
	 parameter G 		= 3'b110;

	 reg [2:0] state;
	 reg [2:0] next_state;
	 assign std_out = state;
	 
	 always @ (posedge clk)
	 begin
			if(rst) state <= START;
			else state <= next_state;
	 end
	 
	 always @ (*)
	 begin
			case(state)
				START:	next_state <= A;
				A:			next_state <= B;
				B:			next_state <= C;
				C:			next_state <= D;
				D:			next_state <= E;
				E:			next_state <= F;
				F:			next_state <= G;
				G:			next_state <= START;
			endcase
	 end
endmodule
