`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:15:51 10/02/2017 
// Design Name: 
// Module Name:    IND_FSM 
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
module IND_FSM(
    input clk,
    input rst,
    output [2:0] ind_out
    );
	 
	 reg [2:0] out, cnt;
	 assign ind_out = out;
	 
	 always @ (posedge clk)
	 begin
		if(rst) cnt <= 3'o0;
		else cnt <= cnt + 3'o1;
	 end
	 
	 always @ (*)
	 begin
		case(cnt)
			3'o0: out <= 3'b000;
			3'o1: out <= 3'b010;
			3'o2: out <= 3'b111;
			3'o3: out <= 3'b100;
			3'o4: out <= 3'b101;
			3'o5: out <= 3'b001;
			3'o6: out <= 3'b011;
			3'o7: out <= 3'b110;
		endcase
	 end
endmodule
