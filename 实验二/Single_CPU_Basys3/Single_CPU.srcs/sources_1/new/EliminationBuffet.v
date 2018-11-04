`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 00:34:16
// Design Name: 
// Module Name: EliminationBuffet
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


module EliminationBuffet(
    input in_key,
    input clk,
    output out_key
    );
    reg delay1,delay2,delay3;  
    assign out_key = delay1&delay2&delay3;
    always@(posedge clk)//CLK 100M
    begin
        delay1  <= in_key;
        delay2  <= delay1;
        delay3  <= delay2;
    end

endmodule
