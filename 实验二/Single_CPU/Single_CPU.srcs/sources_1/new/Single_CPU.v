`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 22:13:17
// Design Name: 
// Module Name: Single_CPU
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


module Single_CPU(
    input clock,
    input reset,
    output [31:0]pcIn,
    output [31:0]pcNext,
    output [31:0]pc4,
    output [31:0]IDataOut,
    output [5:0]opcode,
    output [4:0]rs,
    output [4:0]rt,
    output [4:0]rd,
    output [4:0]sa,
    output [15:0]immediate,
    output [25:0]address,
    output [31:0]pc_Join_result,
    output [4:0]rd_rtSelected,
    output [31:0]rega,
    output [31:0]regb,
    output RegDst,
    output InsMemRW,
    output PCWre,
    output ExtSel,
    output DBDataSrc,
    output mWR,
    output mRD,
    output ALUSrcB,
    output ALUSrcA,
    output [1:0]PCSrc,
    output [2:0]ALUOp,
    output RegWre,
    output [31:0]immediateExtend,
    output zero,
    output [31:0]Data1,
    output [31:0]Data2,
    output [31:0]result,
    output [31:0]DB,
    output [31:0]pc4Offset,
    output [31:0]DataOut
    );
    wire [31:0]pcIn;
    wire [31:0]pcNext;
    wire [31:0]pc4;
    wire [31:0]IDataOut;
    wire [5:0]opcode;
    wire [4:0]rs;
    wire [4:0]rt;
    wire [4:0]rd;
    wire [4:0]sa;
    wire [15:0]immediate;
    wire [25:0]address;
    wire [31:0]pc_Join_result;
    wire [4:0]rd_rtSelected;
    wire [31:0]rega;
    wire [31:0]regb;
    wire RegDst;
    wire InsMemRW;
    wire PCWre;
    wire ExtSel;
    wire DBDataSrc;
    wire mWR;
    wire mRD;
    wire ALUSrcB;
    wire ALUSrcA;
    wire [1:0]PCSrc;
    wire [2:0]ALUOp;
    wire RegWre;
    wire [31:0]immediateExtend;
    wire zero;
    wire [31:0]Data1;
    wire [31:0]Data2;
    wire [31:0]result;
    wire [31:0]DB;
    wire [31:0]pc4Offset;
    wire [31:0]DataOut;
    
    assign opcode[5:0] = IDataOut[31:26];
    assign rs[4:0]=IDataOut[25:21];
    assign rt[4:0]=IDataOut[20:16];
    assign rd[4:0]=IDataOut[15:11];
    assign sa[4:0]=IDataOut[10:6];
    assign immediate[15:0]=IDataOut[15:0];
    assign address[25:0]=IDataOut[25:0];

    PC pc(
        .CLK(clock),
        .Reset(reset),
        .PCWre(PCWre),
        .pcIn(pcIn),
        .pcNext(pcNext)
    );
    
    PCAdd4 pcAdd4(
        .pc(pcNext),
        .pc4(pc4)
    );

    IR ir(
        .InsMemRW(InsMemRW),
        .IAddr(pcNext),
        .IDataOut(IDataOut)
    );

    rd_rt rd_rt_instance(
        .rd(rd),
        .rt(rt),
        .RegDst(RegDst),
        .result(rd_rtSelected)
    );

    RegFile regFile(
        .CLK(clock),
        .RegWre(RegWre),
        .ReadReg1(rs),
        .ReadReg2(rt),
        .WriteReg(rd_rtSelected),
        .WriteData(DB),
        .ReadData1(Data1),
        .ReadData2(Data2)
    );

    PC_Join pc_join(
        .pc4(pc4),
        .addr(address),
        .PCJoined(pc_Join_result)
    );

    DataExtend dataExtendInstance(
        .imData(immediate),
        .ExtSel(ExtSel),
        .dataExtend(immediateExtend)
    );

    ALU alu(
        .ALUopcode(ALUOp),
        .rega(rega),
        .regb(regb),
        .result(result),
        .zero(zero)
    );

    ALUSrcASelect aluSrcASelect(
        .Data1(Data1),
        .sa(sa),
        .ALUSrcA(ALUSrcA),
        .result(rega)
    );

    ALUSrcBSelect aluSrcBSelect(
        .Data2(Data2),
        .immediate(immediateExtend),
        .ALUSrcB(ALUSrcB),
        .result(regb)
    );

    RAM ram(
        .clk(clock),
        .address(result),
        .writeData(Data2),
        .mRD(mRD),
        .mWR(mWR),
        .DataOut(DataOut)
    );

    DBDataSrcSelect dbDataSrcSelect(
        .result(result),
        .DataOut(DataOut),
        .DBDataSrc(DBDataSrc),
        .DB(DB)
    );

    Multiplexer4 multiplexer4(
        .pc1(pc4),
        .pc2(pc4Offset),
        .pc3(pc_Join_result),
        .PCSrc(PCSrc),
        .pcIn(pcIn)
    );

    PCAddOffset pcAddOffset(
        .pc4(pc4),
        .offset(immediateExtend),
        .pc4Offset(pc4Offset)
    );

    ControlUnit controlUnit(
        .opcode(opcode),
        .zero(zero),
        .RegDst(RegDst),
        .InsMemRW(InsMemRW),
        .PCWre(PCWre),
        .ExtSel(ExtSel),
        .DBDataSrc(DBDataSrc),
        .mWR(mWR),
        .mRD(mRD),
        .ALUSrcB(ALUSrcB),
        .ALUSrcA(ALUSrcA),
        .PCSrc(PCSrc),
        .ALUOp(ALUOp),
        .RegWre(RegWre)
    );

endmodule
