`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/24 00:50:54
// Design Name: 
// Module Name: Multicycle_CPU_sim
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


module Multicycle_CPU_sim();
    reg CLK;
    reg RST;
    initial begin
        CLK = 0;
        RST = 0;
        #30 RST = 1;
    end
    always #10 CLK = ~CLK;
    Multicycle_CPU Multicycle_CPI_Instance(
        .CLK(CLK),
        .RST(RST)
    );
endmodule
