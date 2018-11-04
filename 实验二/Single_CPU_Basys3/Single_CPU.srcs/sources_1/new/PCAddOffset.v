`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 21:49:32
// Design Name: 
// Module Name: PCAddOffset
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


module PCAddOffset(
	input [31:0]pc4,
	input [31:0]offset,
	output reg[31:0]pc4Offset
    );
	always @(pc4 or offset) begin
		pc4Offset <= pc4+(offset << 2);
	end
endmodule
