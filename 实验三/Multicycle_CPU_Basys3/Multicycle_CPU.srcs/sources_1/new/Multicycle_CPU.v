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
    input RST,
    input button_clk,
    input switch1,
    input switch2,
    output [2:0] state,
    output [3:0] Anode_Activate,
    output [6:0] LED_out
    );

    wire PCWre,InsMemRW,IRWre,RegWre,WrRegDSrc,ExtSel, ALUSrcA, ALUSrcB,sign,zero,mRD,mWR,DBDataSrc;
    wire [1:0]PCSrc,RegDst;
    wire [31:0]pc,pcIn, instruction, offset,DBData, ReadData1,ReadData2, result, ALUResult, WriteData, register31;
    wire [25:0]addr;
    wire [15:0]imData;
    wire [5:0]opcode;
    wire [2:0]ALUOp, state;
    wire [4:0]sa, rs, rt;
    wire work_clk;
    
    EliminationBuffet eliminationBuffet(
        .in_key(button_clk),
        .clk(CLK),
        .out_key(work_clk)
    );
    
    Display display(
        .clk(CLK),
        .switch1(switch1),
        .switch2(switch2),
        .pcNext(pc),
        .pcIn(pcIn),
        .rs(rs),
        .rsData(ReadData1),
        .rt(rt),
        .rtData(ReadData2),
        .result(ALUResult),
        .DB(DBData),
        .Anode_Activate(Anode_Activate),
        .LED_out(LED_out)
    );

    ControlUnit ControlUnit_Instance(
        .CLK(work_clk),
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
        .DBDataSrc(DBDataSrc),
        .state(state)
    );
    
    IF IF_Instance(
        .CLK(work_clk),
        .RST(RST),
        .PCWre(PCWre),
        .InsMemRW(InsMemRW),
        .IRWre(IRWre),
        .PCSrc(PCSrc),
        .pcJr(register31),
        .addr(addr),
        .offset(offset),
        .pc(pc),
        .pcIn(pcIn),
        .instruction(instruction)
    );

    ID ID_Instance(
        .CLK(work_clk),
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
        .addr(addr),
        .rs(rs),
        .rt(rt)
    );
    
    DataExtend DataExtend_Instance(
        .imData(imData),
        .ExtSel(ExtSel),
        .dataExtend(offset)
    );

    Exe Exe_Instance(
        .CLK(work_clk),
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
        .CLK(work_clk),
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
