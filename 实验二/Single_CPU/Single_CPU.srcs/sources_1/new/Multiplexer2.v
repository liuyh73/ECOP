`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 18:55:32
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
	input data1,
	input data2,
	input choice,
	output result
	);

	always @(data1 or data2) begin
		if (choice==0)
			result <= data1;
		else
			result <= data2;
	end
endmodule
