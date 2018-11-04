`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/23 11:38:46
// Design Name: 
// Module Name: DataExtend
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


module DataExtend(
	input [15:0]imData,
    input ExtSel,
    output reg[31:0]dataExtend
    );
    
    always @(ExtSel or imData) begin
        if(ExtSel == 0)
            dataExtend <= {16'h0000,imData};
        else begin
            if(imData[15] == 0)
                dataExtend <= {16'h0000,imData};
            else
                dataExtend <= {16'hffff,imData};
        end
        $display("dataExtend: %h",dataExtend);
    end
endmodule
