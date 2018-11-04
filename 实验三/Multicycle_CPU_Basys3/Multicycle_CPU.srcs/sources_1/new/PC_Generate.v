`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 22:12:55
// Design Name: 
// Module Name: PC_Generate
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


module PC_Generate(
	input CLK,
    input RST,
    input PCWre,
    input [31:0]pcIn,
    output reg[31:0]pc
    );

    always @(posedge CLK or negedge RST) begin
        if (RST == 0) 
            pc <= 0;
        else if (PCWre == 1) begin
                pc <= pcIn;
            end
    end
endmodule
