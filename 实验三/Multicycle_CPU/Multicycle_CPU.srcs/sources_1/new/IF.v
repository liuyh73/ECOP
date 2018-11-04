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
    output [31:0]instruction
    );
    wire [31:0]ins;
    wire [31:0]pc;
    PC PC_Instance(
        .CLK(CLK),
        .RST(RST),
        .PCWre(PCWre),
        .PCSrc(PCSrc),
        .pcJr(pcJr),
        .addr(addr),
        .offset(offset),
        .pc(pc)
    );

    InsMem InsMem_Instance(
        .InsMemRW(InsMemRW),
        .IAddr(pc),
        .IDataOut(ins)
    );

    Register_IR IR(
        .IRWre(IRWre),
        .CLK(CLK),
        .DataIn(ins),
        .DataOut(instruction)
    );
    
endmodule
