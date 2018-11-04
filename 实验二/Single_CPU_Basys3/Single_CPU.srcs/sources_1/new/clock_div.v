`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/21 22:43:41
// Design Name: 
// Module Name: clock_div
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


module clock_div( 
	input clk, //100MHz��ϵͳĬ����Ƶ�� 
	output reg clk_sys = 0 //1Hz����Ƶ���Ƶ�ʡ������ʼ��Ϊ 0 
    );
	reg [25:0] div_counter = 0; 
	always @(posedge clk)
    begin
        if(div_counter>=2000000) begin
            clk_sys <= ~clk_sys; // ��ƽ����
            div_counter <= 0;
        end else
            div_counter <= div_counter + 1;
    end
endmodule