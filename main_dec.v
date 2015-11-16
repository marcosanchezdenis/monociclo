`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:44 08/28/2015 
// Design Name: 
// Module Name:    main_dec 
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
module main_dec(input wire [5:0] operation,					
					output wire  mem_write,noExt,jal,
					output wire branch, alu_src,memtoreg,reg_write,
					output wire [1:0] reg_dst,jump,
					output wire [1:0] alu_operation,
					input wire [5:0] function_number
					);
//falta jal					
	reg [12:0] controls; 
	assign {reg_write, reg_dst, alu_src, branch, memwrite,memtoreg, jump, alu_operation,noExt,jal} = controls;

	always@(*) begin
//regwrite_regdst_alusrc_branch_memwrite_memtoreg_jump_aluoperation_noExt_jal
//1_2_1_1_1_1_2_2
		case(operation)
			6'b000000:
			case(function_number)
				6'b001000: controls <= 13'b_0_00_0_0_0_0_01_00_0_0; // JR
				default: controls <= 13'b_1_01_0_0_0_0_00_10_0_0; // RTYPE
			endcase
			6'b100011: controls <= 13'b_1_00_1_0_0_1_00_00_0_0; // LW
			6'b101011: controls <= 13'b_0_00_1_0_1_0_00_00_0_0; // SW
			6'b000100: controls <= 13'b_0_00_0_1_0_0_00_01_0_0; // BEQ		
			6'b001000: controls <= 13'b_1_00_1_0_0_0_00_00_0_0; // ADDI			
			6'b001101: controls <= 13'b_1_00_1_0_0_0_00_11_1_0; // ORI
			6'b001111: controls <= 13'b_1_00_1_0_0_0_00_11_0_0; // LUI		
			6'b000010: controls <= 13'b_0_00_0_0_0_0_10_00_0_0; // J
			6'b000011: controls <= 13'b_1_10_0_0_0_0_10_00_0_1; // JAL
			
					
			default: controls <= 13'bx; // illegal op
		endcase
	end
endmodule
