`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/21 23:08:41
// Design Name: 
// Module Name: Display
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


module Display(
    input clk,
    input switch1,
    input switch2,
    input [31:0]pcNext,
    input [31:0]pcIn,
    input [4:0]rs,
    input [31:0]rsData,
    input [4:0]rt,
    input [31:0]rtData,
    input [31:0]result,
    input [31:0]DB,
    output reg [3:0]Anode_Activate,
    output reg [6:0]LED_out
    );
    reg [25:0] div_counter = 0;
    reg [3:0] LED_BCD;
    reg [1:0] LED_activating_counter;
    always @(posedge clk) begin
        div_counter <= div_counter + 1; 
    end 
    
    always@(posedge clk)
    begin
        case(div_counter[20:19])
        2'b00:
            begin
                Anode_Activate=4'b0111;
                if(switch1==0 && switch2==0)
                    LED_BCD=pcNext[7:4];
                else if(switch1==0 && switch2==1)
                    LED_BCD={3'b000,rs[4:4]};
                else if(switch1==1 && switch2==0)
                    LED_BCD={3'b000,rt[4:4]};
                else 
                    LED_BCD=result[7:4];
            end
        2'b01:
            begin
                Anode_Activate=4'b1011;
                if(switch1==0 && switch2==0)
                    LED_BCD=pcNext[3:0];
                else if(switch1==0 && switch2==1)
                    LED_BCD=rs[3:0];
                else if(switch1==1 && switch2==0)
                    LED_BCD=rt[3:0];
                else
                    LED_BCD=result[3:0];
            end
        2'b10:
            begin
                Anode_Activate=4'b1101;
                if(switch1==0 && switch2==0)
                    LED_BCD=pcIn[7:4];
                else if(switch1==0 && switch2==1)
                    LED_BCD=rsData[7:4];
                else if(switch1==1 && switch2==0)
                    LED_BCD=rtData[7:4];
                else
                    LED_BCD=DB[7:4];
            end
        2'b11:
            begin
                Anode_Activate=4'b1110;
                if(switch1==0 && switch2==0)
                    LED_BCD=pcIn[3:0];
                else if(switch1==0 && switch2==1)
                    LED_BCD=rsData[3:0];
                else if(switch1==1 && switch2==0)
                    LED_BCD=rtData[3:0];
                else
                    LED_BCD=DB[3:0];
            end
        endcase
    end
    always@(posedge clk)
    begin
        case(LED_BCD)
            4'b0000: LED_out=7'b0000001;
            4'b0001: LED_out=7'b1001111;
            4'b0010: LED_out=7'b0010010;
            4'b0011: LED_out=7'b0000110;
            4'b0100: LED_out=7'b1001100;
            4'b0101: LED_out=7'b0100100;
            4'b0110: LED_out=7'b0100000;
            4'b0111: LED_out=7'b0001111;
            4'b1000: LED_out=7'b0000000;
            4'b1001: LED_out=7'b0000100;
            4'b1010: LED_out=7'b0001000;
            4'b1011: LED_out=7'b1100000;
            4'b1100: LED_out=7'b0110001;
            4'b1101: LED_out=7'b1000010;
            4'b1110: LED_out=7'b0110000;
            4'b1111: LED_out=7'b0111000;
            default: LED_out=7'b1111111;
        endcase
    end
endmodule
