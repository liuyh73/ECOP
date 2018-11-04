`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 23:00:21
// Design Name: 
// Module Name: Mem
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


module Mem(
    input CLK, 
    input [31:0]result,
    input [31:0]ALUResult,
    input [31:0]DataIn,
    input mRD,
    input mWR,
    input DBDataSrc,
    output [31:0]DBData
    );
    wire [31:0]DataOut;
    wire [31:0]DBData_t;
    DataMem DataMem_Instance(
        .CLK(CLK),
        .DAddr(ALUResult),
        .DataIn(DataIn),
        .mRD(mRD),
        .mWR(mWR),
        .DataOut(DataOut)
    );

    Multiplexer2 DBDataSrcSelect(
        .controlInfo(DBDataSrc),
        .data1(result),
        .data2(DataOut),
        .data(DBData_t)
    );
    
    Register DBDR(
        .CLK(CLK),
        .DataIn(DBData_t),
        .DataOut(DBData)
    );
endmodule
