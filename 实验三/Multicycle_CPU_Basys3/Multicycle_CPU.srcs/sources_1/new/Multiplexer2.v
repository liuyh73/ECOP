`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/23 10:37:53
// Design Name: 
// Module Name: Multiplexer2
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


module Multiplexer2(
    input controlInfo,
    input [31:0]data1,
    input [31:0]data2,
    output reg[31:0]data
    );

    always@(controlInfo or data1 or data2) begin
        case(controlInfo)
            1'b0: begin
                data<=data1;
                $display("WB-data1: %h", data1);
            end
            1'b1: begin 
                data<=data2;
                $display("WB-data2: %h", data2);
            end
        endcase
        
    end
endmodule
