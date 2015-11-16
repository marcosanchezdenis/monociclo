`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:36:21 08/28/2015 
// Design Name: 
// Module Name:    dmen 
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
module dmem(
				input wire clk, write_enabled,
				input wire [31:0] address, writeData,
				output wire [31:0] readData);
				

	reg [31:0] RAM[268500992 + 480 - 1:268500992];			
	//reg [31:0] RAM[63:0];
	assign readData = RAM[address[31:2]]; // word aligned

	always@(posedge clk)
		if (write_enabled) RAM[address[31:2]] <= writeData;

endmodule