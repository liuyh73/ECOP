`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/23 00:32:28
// Design Name: 
// Module Name: ID
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


module ID(
    input CLK,
    input RegWre,
    input [1:0]RegDst,
    input [31:0]instruction,
    input [4:0]ra,
    input [31:0]WriteData,
    output [4:0]sa,
    output [31:0]ReadData1_t,
    output [31:0]ReadData1,
    output [31:0]ReadData2,
    output [5:0]opcode,
    output [15:0]imData,
    output [25:0]addr
    );
    wire [5:0]opcode;
    wire [4:0]rs;
    wire [4:0]rt;
    wire [4:0]rd;
    wire [4:0]sa;
    wire [15:0]imData;
    wire [25:0]addr;
    wire [4:0]WriteReg;
    wire [31:0]ReadData1_t;
    wire [31:0]ReadData2_t;
    assign opcode[5:0] = instruction[31:26];
    assign rs[4:0]=instruction[25:21];
    assign rt[4:0]=instruction[20:16];
    assign rd[4:0]=instruction[15:11];
    assign sa[4:0]=instruction[10:6];
    assign imData[15:0]=instruction[15:0];
    assign addr[25:0]=instruction[25:0];
    //三选一选择器计算WriteReg
    Multiplexer3 Multiplexer3_Instance(
        .ra(ra),
        .rt(rt),
        .rd(rd),
        .RegDst(RegDst),
        .WriteReg(WriteReg)
    );
    //此模块中是寄存器组，存储运算过程中各个寄存器的数据
    RegFile RegFile_Instance(
        .CLK(CLK),
        .RegWre(RegWre),
        .ReadReg1(rs),
        .ReadReg2(rt),
        .WriteReg(WriteReg),
        .WriteData(WriteData),
        .ReadData1(ReadData1_t),
        .ReadData2(ReadData2_t)
    );
    //ADR作为ReadData1的寄存器
    Register ADR(
        .CLK(CLK),
        .DataIn(ReadData1_t),
        .DataOut(ReadData1)
    );
    //BDR作为ReadData2的寄存器
    Register BDR(
        .CLK(CLK),
        .DataIn(ReadData2_t),
        .DataOut(ReadData2)
    );
endmodule
