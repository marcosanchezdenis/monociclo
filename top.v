`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:07:29 08/28/2015 
// Design Name: 
// Module Name:    top 
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
module top(
				input wire clk, reset,
				output wire [31:0] writeData, 
				//output wire [31:0] dataAddress,
				output wire mem_write,
				output wire [31:0] dataAddr
				
		
);


wire [31:0] pc, instruction, readData;


mips mips (
    .clk(clk), 
    .reset(reset), 
    .pc(pc), 
    .instruction(instruction), 
    .mem_write(mem_write), 
   //.ALU(dataAddress), 
    .writeData(writeData), 
    .readData(readData),
	 .Result(dataAddr) 
    );

imem imem (
    .address(pc[7:2]), 
    .readData(instruction)
    );

dmem dmen (
    .clk(clk), 
    .write_enabled(mem_write), 
    .address(dataAddr), 
    .writeData(writeData), 
    .readData(readData)
    );
endmodule
