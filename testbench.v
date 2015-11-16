`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:26:07 08/29/2015
// Design Name:   top
// Module Name:   /home/ucaguest/Monocicly/testbench.v
// Project Name:  Monocicly
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench();
reg clk;
reg reset;
reg [31:0] writedata;
reg memwrite;
wire [31:0]addr;


// instantiate device to be tested
top dut (clk, reset, writedata, memwrite,addr);

// initialize test RESET
initial
begin
reset <= 1; # 22; reset <= 0;
end


// generate clock to sequence tests CLOCK
always
begin
clk <= 1; # 5; clk <= 0; # 5;
end


// check results
always @(negedge clk)
begin
if (memwrite) begin
if (addr===84 & writedata===7) begin
$display("Simulation succeeded");
$stop;
end else if (addr !==80) begin
$display("Simulation failed");
$stop;
end
end
end
endmodule

