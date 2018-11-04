`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 22:01:04
// Design Name: 
// Module Name: ALUSrcASelect
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


module ALUSrcASelect(
    input [31:0]Data1,
    input [4:0]sa,
    input ALUSrcA,
    output reg[31:0]result
    );
    always@(Data1 or sa or ALUSrcA) begin
        if(ALUSrcA==0)
            result<=Data1;
        else
            result<={16'h000000,2'b000,sa};
    end
endmodule
