`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/23 11:48:50
// Design Name: 
// Module Name: Exe
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Exe(
    input CLK,
    input [2:0]ALUOp,
    input ALUSrcA,
    input ALUSrcB,
    input [31:0]ReadData1,
    input [31:0]ReadData2,
    input [4:0]sa,
    input [31:0]offset,
    output sign,
    output zero,
    output [31:0]result,
    output [31:0]ALUResult
    );
    wire [31:0]ALUA, ALUB, result;
    wire sign, zero;
    Multiplexer2 ALUSrcASelect(
        .controlInfo(ALUSrcA),
        .data1(ReadData1),
        .data2({16'h000000,2'b000,sa}),
        .data(ALUA)
    );
    
    Multiplexer2 ALUSrcBSelect(
        .controlInfo(ALUSrcB),
        .data1(ReadData2),
        .data2(offset),
        .data(ALUB)
    );

    ALU ALU_Instance(
        .Data1(ALUA),
        .Data2(ALUB),
        .ALUOp(ALUOp),
        .sign(sign),
        .zero(zero),
        .result(result)
    );

    Register ALUoutDR(
        .CLK(CLK),
        .DataIn(result),
        .DataOut(ALUResult)
    );
endmodule
