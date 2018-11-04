`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/23 11:04:29
// Design Name: 
// Module Name: Register_IR
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


module Register_IR(
    input IRWre,
    input CLK,
    input [31:0]DataIn,
    output [31:0]DataOut
    );
    reg [31:0]store;
    assign DataOut=store;
    always@(negedge CLK)
    begin
        if(IRWre) begin
            store<=DataIn; 
            //$display("IR-instruction: %h", store);
        end
    end
endmodule
