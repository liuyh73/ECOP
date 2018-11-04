`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 23:39:57
// Design Name: 
// Module Name: IF
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


module IF(
    input CLK,
    input RST,
    input PCWre,
    input InsMemRW,
    input IRWre,
    input [1:0]PCSrc,
    input [31:0]pcJr,
    input [25:0]addr,
    input [31:0]offset,
    output [31:0]pc,
    output [31:0]pcIn,
    output [31:0]instruction
    );
    wire [31:0]ins;
    wire [31:0]pc;
    //此模块用于生成PC值
    PC PC_Instance(
        .CLK(CLK),
        .RST(RST),
        .PCWre(PCWre),
        .PCSrc(PCSrc),
        .pcJr(pcJr),
        .addr(addr),
        .offset(offset),
        .pc(pc),
        .pcIn(pcIn)
    );
    //InsMem存储指令，根据pc值读取指令
    InsMem InsMem_Instance(
        .InsMemRW(InsMemRW),
        .IAddr(pc),
        .IDataOut(ins)
    );
    //此寄存器在时钟下降沿到来时，判断IRWre是否为1，若为1，则更新寄存器的值，否则不更新
    Register_IR IR(
        .IRWre(IRWre),
        .CLK(CLK),
        .DataIn(ins),
        .DataOut(instruction)
    );
    
endmodule
