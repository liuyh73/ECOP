`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 22:11:01
// Design Name: 
// Module Name: Multiplexer4
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


module Multiplexer3(
    input [4:0]ra,
    input [4:0]rt,
    input [4:0]rd,
    input [1:0]RegDst,
    output reg[4:0]WriteReg
    );
    
    always @(RegDst or ra or rt or rd) begin
        case(RegDst)
            2'b00: WriteReg <= ra;
            2'b01: WriteReg <= rt;
            2'b10: WriteReg <= rd;
            default:
                $display("RegDst Wrong!");
        endcase
        //$display("PCSrc---*****---%h", PCSrc);
    end
endmodule
