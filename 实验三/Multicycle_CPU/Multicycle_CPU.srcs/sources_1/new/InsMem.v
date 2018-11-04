`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/22 22:42:59
// Design Name: 
// Module Name: InsMem
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


module InsMem(
    input InsMemRW,
    input [31:0]IAddr,
    output reg[31:0]IDataOut
    );
    
    reg [7:0]IDataMem[0:80];
    initial begin
        $readmemh("D:/Vivado_projects/Multicycle_CPU/Instructions.txt",IDataMem);
    end
    always@(*)
    begin
        if(InsMemRW == 1)
        begin
            IDataOut[31:24] <= IDataMem[IAddr];
            IDataOut[23:16] <= IDataMem[IAddr+1];
            IDataOut[15:8] <= IDataMem[IAddr+2];
            IDataOut[7:0] <=IDataMem[IAddr+3];
        end
    end
endmodule
