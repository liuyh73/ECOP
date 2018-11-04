`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 21:44:13
// Design Name: 
// Module Name: PCAdd4
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


module PCAdd4(
	input [31:0]pc,
	output reg[31:0]pc4
    );
	always @(pc) begin
		pc4<=pc+4;
	end
endmodule
