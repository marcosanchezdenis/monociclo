`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:34:23 08/28/2015 
// Design Name: 
// Module Name:    alu_dec 
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
module alu_dec(input wire [5:0] function_number,
					input wire [1:0] alu_operation,
					input wire [5:0] dec_operation,
					output reg [3:0] alu_control  );
always@(*) begin
	case(alu_operation)
	2'b00: alu_control <= 4'b0010; // add (for lw/sw/addi)
	2'b01: alu_control <= 4'b0110; // sub (for beq)
	2'b11: 
		case (dec_operation) 
			6'b001111: alu_control <= 4'b1000; //	LUI
			6'b001101: alu_control <= 4'b0001; // ORI
			// utilizar la misma operacion de or, pero con insercion inmediata
			default: alu_control <= 4'bxxx;
		endcase	
		default: case(function_number) // R-type instructions
		6'b100100: alu_control <= 4'b0000; // and
		6'b100101: alu_control <= 4'b0001; // or
		6'b100000: alu_control <= 4'b0010; // add
		//no usado
		//and negado
		//or negado	
		6'b100010: alu_control <= 4'b0110; // sub	
		6'b101010: alu_control <= 4'b0111; // slt
		
		default:   alu_control <= 4'bxxx; // ???
		endcase
	endcase
end

endmodule


