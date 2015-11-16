`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:39:32 08/28/2015 
// Design Name: 
// Module Name:    imem 
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
module imem(
				input wire [5:0] address,
				output wire [31:0] readData);
////4194304				
//reg [31:0] RAM[4194304 + 256 - 1:4194304];
reg [31:0] RAM[63:0];
initial
//$readmemh("e.txt", RAM,4194303,(4194304 + 256 - 1));
$readmemh("cargar_memoria", RAM);
assign readData = RAM[address];
endmodule
