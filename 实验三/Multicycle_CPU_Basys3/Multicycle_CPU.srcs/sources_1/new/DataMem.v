`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 22:42:44
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input CLK,
    input [31:0] DAddr,
    input [31:0] DataIn,
    input mRD,
    input mWR,
    output [31:0] DataOut
    );
    reg [7:0] ram[0:60];
    //Read
    assign DataOut[7:0] = (mRD==1) ? ram[DAddr+3] : 8'bz;
    assign DataOut[15:8] = (mRD==1) ? ram[DAddr+2] : 8'bz;
    assign DataOut[23:16] = (mRD==1) ? ram[DAddr+1] : 8'bz;
    assign DataOut[31:24] = (mRD==1) ? ram[DAddr] : 8'bz;
    //Write
    always@(negedge CLK)
    begin
        if(mWR==1)
        begin
            ram[DAddr] <= DataIn[31:24];
            ram[DAddr+1] <= DataIn[23:16];
            ram[DAddr+2] <= DataIn[15:8];
            ram[DAddr+3] <= DataIn[7:0];
        end
    end
endmodule
