`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 22:12:26
// Design Name: 
// Module Name: PC4_Jump
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


module PC4_Jump(
	input [31:0]pc4,
    input [25:0]addr,
    output reg[31:0]pc4Jumped
    );
    
    always @(addr) begin
        pc4Jumped <= {pc4[31:28], addr, 2'b00};
    end
endmodule
