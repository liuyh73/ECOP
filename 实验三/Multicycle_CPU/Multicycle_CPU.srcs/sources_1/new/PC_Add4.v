`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 22:09:15
// Design Name: 
// Module Name: PC_Add4
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


module PC_Add4(
	input [31:0]pc,
	output reg[31:0]pc4
    );
	always @(pc) begin
		pc4<=pc+4;
	end
endmodule
