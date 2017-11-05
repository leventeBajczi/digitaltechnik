`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:34:58 10/15/2017
// Design Name:   MAN_FSM
// Module Name:   C:/Users/bajcz/Documents/digithazi/hazi1/man-tf.v
// Project Name:  hazi1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MAN_FSM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mantf;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [2:0] std_out;

	// Instantiate the Unit Under Test (UUT)
	STD_FSM uut (
		.clk(clk), 
		.rst(rst), 
		.std_out(std_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		forever
			begin
				#50 clk = ~clk;
			end
		
		// Add stimulus here

	end
	
	initial begin
		clk = 0;
		rst = 0;
		#110 rst = 1;
      #100 rst = 0;
	end
      
endmodule

