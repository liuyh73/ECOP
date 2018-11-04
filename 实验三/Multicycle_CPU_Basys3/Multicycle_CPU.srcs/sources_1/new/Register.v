`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 23:15:35
// Design Name: 
// Module Name: Register
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


module Register(
    input CLK,
    input [31:0]DataIn,
    output [31:0]DataOut
    );
    reg [31:0]store;
    assign DataOut=store;
    always@(negedge CLK)
    begin
        store<=DataIn; 
        //$display("ALUResult: %h", store);
    end
endmodule
