`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 19:31:00
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
            else begin
                dataExtend <= {16'hffff,imData};
                $display("%h",dataExtend);
            end
        end
	end

endmodule
