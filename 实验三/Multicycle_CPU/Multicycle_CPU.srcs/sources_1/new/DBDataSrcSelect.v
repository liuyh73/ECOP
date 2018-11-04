`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 22:58:37
// Design Name: 
// Module Name: DBDataSrcSelect
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


module DBDataSrcSelect(
    input [31:0]ALUResult,
    input [31:0]DataOut,
    input DBDataSrc,
    output reg[31:0]DBData
    );
    always@(DBDataSrc or ALUResult or DataOut) begin
        if(DBDataSrc==0)
            DBData<=ALUResult;
        else
            DBData<=DataOut;
    end
endmodule
