`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/23 11:49:01
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0]Data1,
    input [31:0]Data2,
    input [2:0]ALUOp,
    output sign,
    output zero,
    output reg[31:0]result
    );
    assign zero = (result == 0) ? 1 : 0;
    assign sign = result[31];
    always @(ALUOp or Data1 or Data2) 
    begin
        case(ALUOp)
            3'b000:result <= Data1 + Data2;
            3'b001:result <= Data1 - Data2;
            3'b010:result <= (Data1 < Data2) ? 1 : 0;
            3'b011:
                begin
                    if(Data1<Data2 && Data1[31]==Data2[31])
                        result<=1;
                    else if(Data1[31]==1 && Data2[31]==0)
                        result<=1;
                    else
                        result<=0;
                end
            3'b100:result <= Data2 << Data1;
            3'b101:result <= Data1 | Data2;
            3'b110:result <= Data1 & Data2;       
            3'b111:result <= Data1 ^ Data2;
            default:
                begin
                    result<=32'h00000000;
                    //$display("no match");
                end
        endcase
        //$display("%d,%d,%d",result, Data1, Data2);
    end
endmodule
