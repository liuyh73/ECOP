`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 22:13:47
// Design Name: 
// Module Name: PC
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

module PC(
    input CLK,
    input RST,
    input PCWre,
    input [1:0]PCSrc,
    input [31:0]pcJr,
    input [25:0]addr,
    input [31:0]offset,
    output [31:0]pc,
    output [31:0]pcIn
    );

    wire [31:0]pcIn;
    wire [31:0]pc;
    wire [31:0]pc4;
    wire [31:0]pc4Jumped;
    wire [31:0]pc4Offset;

    PC_Generate PC_Generate_Instance(
        .CLK(CLK),
        .RST(RST),
        .PCWre(PCWre),
        .pcIn(pcIn),
        .pc(pc)
    );

    PC_Add4 PC_Add4_Instance(
        .pc(pc),
        .pc4(pc4)
    );

    PC4_Jump PC_Jump_Instance(
        .pc4(pc4),
        .addr(addr),
        .pc4Jumped(pc4Jumped)
    );

    PC4_AddOffset PC_AddOffset_Instance(
        .pc4(pc4),
        .offset(offset),
        .pc4Offset(pc4Offset)
    );

    Multiplexer4 Multiplexer4_Instance(
        .pc4(pc4),
        .pc4Offset(pc4Offset),
        .pcJr(pcJr),
        .pc4Jumped(pc4Jumped),
        .PCSrc(PCSrc),
        .pcIn(pcIn)
    );
    
endmodule
