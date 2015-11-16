`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:07 08/28/2015 
// Design Name: 
// Module Name:    controller 
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
module controller(
							input wire [5:0] operation, functions_number,
							input wire zero,noExt,jal,
							output wire memwrite,
							output wire pcsrc, alusrc,
							output wire regwrite,memtoreg,
							output wire [1:0]regdst,jump,
							output wire [3:0] alu_control);

wire [1:0] alu_operation;
wire branch;


main_dec md (
    .operation(operation), 
    .memtoreg(memtoreg), 
    .mem_write(memwrite), 
    .branch(branch), 
    .alu_src(alusrc), 
    .reg_dst(regdst), 
    .reg_write(regwrite), 
    .jump(jump), 
	 .noExt(noExt),
	 .jal(jal),
    .alu_operation(alu_operation),
	 .function_number(functions_number)
	 
    );


alu_dec ad (
    .function_number(functions_number), 
    .alu_operation(alu_operation), 
	 .dec_operation(operation),
    .alu_control(alu_control)
    );
assign pcsrc = branch & zero;
endmodule
