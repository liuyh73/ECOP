`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/23 19:06:49
// Design Name: 
// Module Name: WB
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


module WB(
    input WrRegDSrc,
    input [31:0]DBData,
    input [31:0]pc,
    output [31:0]WriteData
    );

    Multiplexer2 WriteDataSelect(
        .controlInfo(WrRegDSrc),
        .data1(pc+4),
        .data2(DBData),
        .data(WriteData)
    );
endmodule
