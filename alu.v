//alu_operaciones
`timescale 1ns / 1ps
`default_nettype none

module alu(
	input wire [31:0]scrA,	
	input wire [31:0]scrB,	
	input wire [3:0]operation,		
	output reg [31:0]ALUResult,
	output wire zero		
);

//SI ES CERO PONGO A UNO EL Zero




	always @(scrA,scrB,operation)begin
			case (operation)
				4'b0000: 	ALUResult <= scrA & scrB; //AND				
				4'b0001: 	ALUResult <= scrA | scrB; //OR						
				3'b0010:	ALUResult <= scrA + scrB; //SUMA	
			// 3'b0011:	ALUResult <= scrA + scrB; //SUMA	
			// 3'b0100:	ALUResult <= scrA + scrB; //SUMA
			// 3'b0101:	ALUResult <= scrA + scrB; //SUMA				
				4'b0110:	ALUResult <= scrA - scrB;	// RESTA
				4'b0111:	ALUResult <= (scrA < scrB) ? 1:0; //SLT
				4'b1000:	ALUResult <= {scrB[15:0], 16'b0}; //LUI				
				default: ALUResult <= 32'dx;
					
			endcase
	end



assign zero = (ALUResult == 0)? 1:0;


endmodule
