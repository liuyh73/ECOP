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


module Multiplexer4(
	input [31:0]pc4,
    input [31:0]pc4Offset,
    input [31:0]pcJr,
    input [31:0]pc4Jumped,
    input [1:0]PCSrc,
    output reg[31:0]pcIn
    );
    initial begin
        pcIn=0;
    end
    always @(PCSrc or pc4 or pc4Offset or pcJr or pc4Jumped) begin
        case(PCSrc)
            2'b00: pcIn <= pc4;
            2'b01: pcIn <= pc4Offset;
            2'b10: pcIn <= pcJr;
            2'b11: pcIn <= pc4Jumped;
            default:
                $display("PCSrc Wrong!");
        endcase
        //$display("PCSrc---*****---%h", PCSrc);
    end
endmodule
