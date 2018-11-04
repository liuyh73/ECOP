`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/23 11:12:24
// Design Name: 
// Module Name: Multicycle_CPU
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


module Multicycle_CPU(
    input CLK,
    input RST
    );

    wire PCWre,InsMemRW,IRWre,RegWre,WrRegDSrc,ExtSel, ALUSrcA, ALUSrcB,sign,zero,mRD,mWR,DBDataSrc;
    wire [1:0]PCSrc,RegDst;
    wire [31:0]pc,instruction, offset,DBData, ReadData1,ReadData2, result, ALUResult, WriteData, register31;
    wire [25:0]addr;
    wire [15:0]imData;
    wire [5:0]opcode;
    wire [2:0]ALUOp;
    wire [4:0]sa;

    ControlUnit ControlUnit_Instance(
        .CLK(CLK),
        .RST(RST),
        .zero(zero),
        .sign(sign),
        .opcode(opcode),
        .ExtSel(ExtSel),
        .PCWre(PCWre),
        .IRWre(IRWre),
        .InsMemRW(InsMemRW),
        .WrRegDSrc(WrRegDSrc),
        .RegDst(RegDst),
        .RegWre(RegWre),
        .ALUOp(ALUOp),
        .PCSrc(PCSrc),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .mRD(mRD),
        .mWR(mWR),
        .DBDataSrc(DBDataSrc)
    );
    
    IF IF_Instance(
        .CLK(CLK),
        .RST(RST),
        .PCWre(PCWre),
        .InsMemRW(InsMemRW),
        .IRWre(IRWre),
        .PCSrc(PCSrc),
        .pcJr(register31),
        .addr(addr),
        .offset(offset),
        .pc(pc),
        .instruction(instruction)
    );

    ID ID_Instance(
        .CLK(CLK),
        .RegWre(RegWre),
        .RegDst(RegDst),
        .instruction(instruction),
        .ra(5'b11111),
        .WriteData(WriteData),
        .sa(sa),
        .ReadData1_t(register31),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .opcode(opcode),
        .imData(imData),
        .addr(addr)
    );
    
    DataExtend DataExtend_Instance(
        .imData(imData),
        .ExtSel(ExtSel),
        .dataExtend(offset)
    );

    Exe Exe_Instance(
        .CLK(CLK),
        .ALUOp(ALUOp),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .sa(sa),
        .offset(offset),
        .sign(sign),
        .zero(zero),
        .result(result),
        .ALUResult(ALUResult)
    );
    
    Mem Mem_Instance(
        .CLK(CLK),
        .result(result),
        .ALUResult(ALUResult),
        .DataIn(ReadData2),
        .mRD(mRD),
        .mWR(mWR),
        .DBDataSrc(DBDataSrc),
        .DBData(DBData)
    );

    WB WB_Instance(
        .WrRegDSrc(WrRegDSrc),
        .DBData(DBData),
        .pc(pc),
        .WriteData(WriteData)
    );
    
endmodule
