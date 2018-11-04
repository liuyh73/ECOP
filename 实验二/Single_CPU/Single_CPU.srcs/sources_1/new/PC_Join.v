`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 21:36:00
// Design Name: 
// Module Name: PC_Join
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


module PC_Join(
	input [31:0]pc4,
	input [25:0]addr,
	output reg[31:0]PCJoined
	);
	
	always @(addr) begin
		PCJoined <= {pc4[31:28], addr, 2'b00};
	end
endmodule
