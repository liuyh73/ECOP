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
    //��ģ�鴦��ALUģ�������A���жϿ����ź�ALUSrcA��ֵ��
    //����Ϊ0ʱ��ѡ��Ĵ������ReadData1������Ϊ1ʱ��ѡ��sa����ƫ������ 
    Multiplexer2 ALUSrcASelect(
        .controlInfo(ALUSrcA),
        .data1(ReadData1),
        .data2({16'h000000,2'b000,sa}),
        .data(ALUA)
    );
    //��ģ�鴦��ALUģ�������B���жϿ����ź�ALUSrcB��ֵ��
    //����Ϊ0ʱ��ѡ��Ĵ������ReadData2������Ϊ1ʱ��ѡ��immediate������������ 
    Multiplexer2 ALUSrcBSelect(
        .controlInfo(ALUSrcB),
        .data1(ReadData2),
        .data2(offset),
        .data(ALUB)
    );
    //��ģ�鼴Ϊ�߼����㵥Ԫ�ĺ��Ĳ��֣�����ALUopcode�����룬��ִ��
    //��ͬ���߼����㡣����zero����������յ���������������result=0ʱ��zero���Ϊ1��
    //��֮���Ϊ0
    ALU ALU_Instance(
        .Data1(ALUA),
        .Data2(ALUB),
        .ALUOp(ALUOp),
        .sign(sign),
        .zero(zero),
        .result(result)
    );
    //ÿ��ʱ���½��ص���ʱ��ˢ�¼Ĵ����е����ݣ��������ݵĻ���
    Register ALUoutDR(
        .CLK(CLK),
        .DataIn(result),
        .DataOut(ALUResult)
    );
endmodule
