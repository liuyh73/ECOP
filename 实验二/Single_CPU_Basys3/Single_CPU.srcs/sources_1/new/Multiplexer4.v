`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 19:09:49
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
	input [31:0]pc1,
	input [31:0]pc2,
	input [31:0]pc3,
	input [1:0]PCSrc,
	output reg[31:0]pcIn
	);

	always @(PCSrc or pc3 or pc2 or pc1) begin
		case(PCSrc)
			2'b00: pcIn <= pc1;
			2'b01: pcIn <= pc2;
			2'b10: pcIn <= pc3;
			default:
				$display("PCSrc Wrong!");
		endcase
		//$display("PCSrc---*****---%h", PCSrc);
	end
endmodule
