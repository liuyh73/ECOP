`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 22:06:04
// Design Name: 
// Module Name: ALUSrcBSelect
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


module ALUSrcBSelect(
    input [31:0]Data2,
    input [31:0]immediate,
    input ALUSrcB,
    output reg[31:0]result
    );
    always@(Data2 or immediate or ALUSrcB) begin
        if(ALUSrcB==0)
            result<=Data2;
        else
            result<=immediate;
    end
endmodule
