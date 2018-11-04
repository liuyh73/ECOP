`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/21 00:00:22
// Design Name: 
// Module Name: Single_CPU_sim
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


module Single_CPU_sim();
    reg CLK;
    reg reset;
    initial begin
        CLK = 0;
        reset = 0;
        #20 reset = 1;
    end
    always #10 CLK = ~CLK;
    wire [31:0]pcIn;
    wire [31:0]pcNext;
    wire [31:0]pc4;
    wire [31:0]IDataOut;
    wire [5:0]opcode;
    wire [4:0]rs;
    wire [4:0]rt;
    wire [4:0]rd;
    wire [4:0]sa;
    wire [15:0]immediate;
    wire [25:0]address;
    wire [31:0]pc_Join_result;
    wire [4:0]rd_rtSelected;
    wire [31:0]rega;
    wire [31:0]regb;
    wire RegDst;
    wire InsMemRW;
    wire PCWre;
    wire ExtSel;
    wire DBDataSrc;
    wire mWR;
    wire mRD;
    wire ALUSrcB;
    wire ALUSrcA;
    wire [1:0]PCSrc;
    wire [2:0]ALUOp;
    wire RegWre;
    wire [31:0]immediateExtend;
    wire zero;
    wire [31:0]Data1;
    wire [31:0]Data2;
    wire [31:0]result;
    wire [31:0]DB;
    wire [31:0]pc4Offset;
    wire [31:0]DataOut;
    Single_CPU single_cpu(CLK,reset,pcIn,pcNext,pc4,IDataOut,opcode,rs, rt,rd,
        sa,immediate,address,pc_Join_result,rd_rtSelected,rega,regb,RegDst,
        InsMemRW, PCWre,ExtSel,DBDataSrc,mWR,mRD,ALUSrcB,ALUSrcA, PCSrc,ALUOp,
        RegWre, immediateExtend,zero,Data1, Data2,result,DB,pc4Offset,DataOut);
endmodule
