`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Topmodul der Hausaufgabe mit der Instantiationen der Module
//////////////////////////////////////////////////////////////////////////////////
module HF1(
    input rst,
    input clk,
    output [2:0] ind_out,
    output [2:0] man_out,
    output [2:0] std_out
    );
	 
	 IND_FSM ind(.rst(rst), .clk(clk), .ind_out(ind_out));
	 MAN_FSM man(.rst(rst), .clk(clk), .man_out(man_out));
	 STD_FSM std(.rst(rst), .clk(clk), .std_out(std_out));	


endmodule
