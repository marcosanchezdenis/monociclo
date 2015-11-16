`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:33:04 08/28/2015 
// Design Name: 
// Module Name:    mux2 
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
module mux4 #(parameter WIDTH = 8)
				(input wire [WIDTH-1:0] d0, d1,d2,d3,
				input wire [1:0] s,
				output reg [WIDTH-1:0] y);
				
				//assign y = s[0] ?    (s[1]? d3 : d2)   : ( s[1] ? d1 : d0 );
				
				always@(*)
				begin
					case(s)
						2'b00:y<=d0;
						2'b01:y<=d1;
						2'b10:y<=d2;
						2'b11:y<=d3;
						default: y<=2'dx;
					endcase
				end
				
 
endmodule
