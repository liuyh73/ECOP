`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 19:21:31
// Design Name: 
// Module Name: PC
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


module PC(
	input CLK,
	input Reset,
	input PCWre,
	input [31:0]pcIn,
	output reg[31:0]pcNext
	);
	always @(posedge CLK or negedge Reset) begin
		if (Reset == 0)
	        pcNext <= 0;
		else if (PCWre == 1) begin
				pcNext <= pcIn;
			end
		$display("#################");
	end
endmodule
