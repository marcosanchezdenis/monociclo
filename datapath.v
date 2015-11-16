`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:58 08/28/2015 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
						input wire clk, reset,
						input wire mem_to_reg,
						input wire pc_src,
						input wire alu_src,
						input wire [1:0]jump,reg_dst,
						input wire reg_write,noExt,jal,
						input wire [3:0] alu_control,
						output wire zero,
						input wire [31:0] readData,
						input wire [31:0] instruction,						
						output wire [31:0] pc,
						output wire [31:0] writeData,
						output wire [31:0]ALU
						
		);
//longitud dos, para mem_to_reg, reg_dist		

wire [4:0] write_reg;
wire [31:0] pc_next, pc_nextbr, pc_plus4, pc_branch;
wire [31:0] signimm, signimmsh,resultofmux,salida2Registro,datosInmediatos;
wire [31:0] srca, srcb;
wire [31:0]srcb2;
wire [31:0] result;
assign writeData = salida2Registro;

// next PC logic
alu alu (
    .scrA(srca), 
    .scrB(srcb), 
    .operation(alu_control), 
    .ALUResult(ALU), //OUT
    .zero(zero) //OUT
    );
	 
// PC	 
flopr #(32) pcreg (
    .clk(clk), 
    .reset(reset), 
    .d(pc_next), 
    .q(pc)
    );
	 
	 
// SUMADOR DEL PC	 
adder pcadd1 (
    .a(pc), 
    .b(32'b100), 
    .y(pc_plus4) 
    );
	 
	 
//DESPLAZADOR DE 2 BITS 
sl2 immsh (
    .a(signimm), 
    .y(signimmsh) 
    );
	 
	 
//SUMADOR DEL BRANCH
adder pcadd2 (
    .a(pc_plus4), 
    .b(signimmsh), 
    .y(pc_branch) 
    );
	 
//MULTIPLEXOR QUE SELECCIONA ENTRE EL SUMADOR DEL PC Y SUMADOR DEL BRANCH	 
mux2 #(32) pcbrmux (
    .d0(pc_plus4), 
    .d1(pc_branch), 
    .s(pc_src), 
    .y(pc_nextbr) //OUT
    );
	 
//MULTIPLEXOR QUE SELECCIONA ENTRE EL PC_BRANCH,JUMP,JR,X	 
mux4 #(32) pcmux (
    .d0({pc_nextbr[31:2], 2'b00}), // 00
    .d2({pc_plus4[31:28],instruction[25:0], 2'b00}), // 10
	 .d1(srca+32'd4), // 01
	 .d3(32'dx),// 11
    .s(jump), 
    .y(pc_next) //OUT
    );




regfile rf (
    .clk(clk), 
    .we3(reg_write), 
    .ra1(instruction[25:21]), 
    .ra2(instruction[20:16]), 
    .wa3(write_reg), 
    .wd3(result), 
    .rd1(srca), 
    .rd2(salida2Registro)
    );
	 
	 
//MULTIPLEXOR QUE SELECCIONA ENTRE GUARDAR EL RESULTADO DE LA ALU Y LA DIRECCION DEL PC	 
mux2 #(32) jalmux(
	 .d0(resultofmux), 
    .d1(pc), 
    .s(jal), 
    .y(result) //OUT
);	 
//MULTIPLEXOR QUE HACE LAS DIFERENCIAS ENTRE LOS CAMPOS DE LA INSTRUCCION
// 1~ CAMPO2
// 2~ CAMPO3
// 3~ CONSTANTE 3	 
mux4 #(5) wrmux (
    .d0(instruction[20:16]), 
    .d1(instruction[15:11]), 
	 .d2(5'd31),
	 .d3(5'dx),
    .s(reg_dst), 
    .y(write_reg) 
    );
	 
//MULTIPLEXOR QUE SELECCIONA ENTRE ALU Y MEMORIA	 
mux2 #(32) resmux (
    .d0(ALU), 
    .d1(readData),
    .s(mem_to_reg), 
    .y(resultofmux) 
    );
	 
	 
//EXTIENDE EL SIGNO USANDO EL BIT MAS SIGNIFICATIVO	 
signext sei (
    .a(instruction[15:0]), 
    .y(signimm) //OUT
    );
	 
	 
//MULTIPLEXOR QUE SELECCIONA ENTRE LA EXTENSION DE 16BITS DEL MAS SIGNIFICATIVO Y NO HACERLA 
mux2 #(32) semux (
    .d0(signimm), 
    .d1({16'b0,instruction[15:0]}), 
    .s(noExt), 
    .y(datosInmediatos) //OUT
    );
	 
	 
//MULTIPLEXOR QUE SELECCIONA ENTRE LA SALIDA DEL REGISTRO Y DATOS INMEDIATOS	 
mux2 #(32) srcbmux (
    .d0(salida2Registro), 
    .d1(datosInmediatos), 
    .s(alu_src), 
    .y(srcb) 
    );

endmodule
