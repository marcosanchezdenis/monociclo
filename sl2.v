`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:52 08/28/2015 
// Design Name: 
// Module Name:    sl2 
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
module sl2(input wire [31:0] a,
				output wire [31:0] y
);
// shift left by 2
assign y = {a[29:0], 2'b00};
endmodule