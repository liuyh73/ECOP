`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 17:15:18
// Design Name: 
// Module Name: RAM
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


module RAM(
    input clk,
    input [31:0] address,
    input [31:0] writeData,
    input mRD,
    input mWR,
    output [31:0] DataOut
    );
    
    reg [7:0] ram[0:60];
    
    //Read
    assign DataOut[7:0] = (mRD==1) ? ram[address+3] : 8'bz;
    assign DataOut[15:8] = (mRD==1) ? ram[address+2] : 8'bz;
    assign DataOut[23:16] = (mRD==1) ? ram[address+1] : 8'bz;
    assign DataOut[31:24] = (mRD==1) ? ram[address] : 8'bz;
    //Write
    always@(negedge clk)
    begin
        if(mWR==1)
        begin
            ram[address] <= writeData[31:24];
            ram[address+1] <= writeData[23:16];
            ram[address+2] <= writeData[15:8];
            ram[address+3] <= writeData[7:0];
        end
    end
endmodule
