`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:31:03 10/02/2017
// Design Name:   HF1
// Module Name:   C:/Users/bajcz/Documents/digithazi/hazi1/HF1_tf.v
// Project Name:  hazi1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: HF1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module HF1_tf;

	// Inputs
	reg rst;
	reg clk;

	// Outputs
	wire [2:0] ind_out;
	wire [2:0] man_out;
	wire [2:0] std_out;

	// Instantiate the Unit Under Test (UUT)
	HF1 uut (
		.rst(rst), 
		.clk(clk), 
		.ind_out(ind_out), 
		.man_out(man_out), 
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

