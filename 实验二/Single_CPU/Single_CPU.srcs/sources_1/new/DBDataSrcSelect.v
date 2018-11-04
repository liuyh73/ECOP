`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 22:08:31
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
    input [31:0]result,
    input [31:0]DataOut,
    input DBDataSrc,
    output reg[31:0]DB
    );
    always@(DBDataSrc or result or DataOut) begin
        if(DBDataSrc==0)
            DB<=result;
        else
            DB<=DataOut;
    end
endmodule
