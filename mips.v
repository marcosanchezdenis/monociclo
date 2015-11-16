`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:47 08/28/2015 
// Design Name: 
// Module Name:    mips 
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
module mips(
		input wire clk, reset,	
		output wire [31:0] pc,		
		input wire [31:0] instruction,
		output wire	mem_write,
		//output wire [31:0]ALU, 
		output wire [31:0]writeData,		
		input wire [31:0]readData,
		output wire [31:0]Result
);



wire noExt, alu_src, reg_write, pc_src, zero,jal,mem_to_reg;
wire [3:0] alu_control;
wire [1:0]reg_dst,jump;


controller c(
    .operation(instruction[31:26]), //IN
    .functions_number(instruction[5:0]), //IN
    .zero(zero),
	 .noExt(noExt),	 //IN
	 .jal(jal),
    .memtoreg(mem_to_reg), 
    .memwrite(mem_write), 
    .pcsrc(pc_src), 
    .alusrc(alu_src), 
    .regdst(reg_dst), 
    .regwrite(reg_write), 
    .jump(jump),
    .alu_control(alu_control)
    );



datapath dp (
    .clk(clk), 
    .reset(reset), 
    .mem_to_reg(mem_to_reg), 
    .pc_src(pc_src), 
    .alu_src(alu_src), 
    .reg_dst(reg_dst), 
    .reg_write(reg_write), 
    .jump(jump),
    .noExt(noExt),
    .jal(jal),	 
    .alu_control(alu_control), 
    .zero(zero), //OUT
    .readData(readData), 
    .instruction(instruction), 
    .pc(pc),  //OUT    
    .writeData(writeData),//OUT
	.ALU(Result) //OUT 
    );
	 



endmodule


