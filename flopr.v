`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:31:09 08/28/2015 
// Design Name: 
// Module Name:    flopr 
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
module flopr #(parameter WIDTH = 8)
	(input wire clk, reset,
	input wire [WIDTH-1:0] d,
	output reg [WIDTH-1:0] q);
	
	always @(posedge clk, posedge reset)
		if (reset) q <= 32'd0;//32'd4194304;
		else q <= d;
endmodule
