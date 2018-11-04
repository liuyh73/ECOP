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
    //此模块处理ALU模块的输入A，判断控制信号ALUSrcA的值，
    //当其为0时，选择寄存器组的ReadData1；当其为1时，选择sa，即偏移量） 
    Multiplexer2 ALUSrcASelect(
        .controlInfo(ALUSrcA),
        .data1(ReadData1),
        .data2({16'h000000,2'b000,sa}),
        .data(ALUA)
    );
    //此模块处理ALU模块的输入B，判断控制信号ALUSrcB的值，
    //当其为0时，选择寄存器组的ReadData2；当其为1时，选择immediate，即立即数） 
    Multiplexer2 ALUSrcBSelect(
        .controlInfo(ALUSrcB),
        .data1(ReadData2),
        .data2(offset),
        .data(ALUB)
    );
    //从模块即为逻辑运算单元的核心部分，根据ALUopcode的输入，来执行
    //不同的逻辑运算。其中zero的输出由最终的运算结果决定，当result=0时，zero输出为1，
    //反之输出为0
    ALU ALU_Instance(
        .Data1(ALUA),
        .Data2(ALUB),
        .ALUOp(ALUOp),
        .sign(sign),
        .zero(zero),
        .result(result)
    );
    //每当时钟下降沿到来时，刷新寄存器中的数据，保持数据的活性
    Register ALUoutDR(
        .CLK(CLK),
        .DataIn(result),
        .DataOut(ALUResult)
    );
endmodule
