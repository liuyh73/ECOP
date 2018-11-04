`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 21:57:56
// Design Name: 
// Module Name: rd_rt
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


module rd_rt(
    input [4:0]rd,
    input [4:0]rt,
    input RegDst,
    output reg[4:0]result
    );
    always@(rd or rt or RegDst)begin
        if(RegDst==0)
            result<=rt;
        else
            result<=rd;
    end
endmodule
