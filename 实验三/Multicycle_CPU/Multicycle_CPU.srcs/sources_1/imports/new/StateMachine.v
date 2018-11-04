`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/23 21:06:03
// Design Name: 
// Module Name: StateMachine
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


module StateMachine(
    input CLK,
    input RST,
    input [5:0]opcode,
    output reg[2:0]state,
    output reg[2:0]nextState
    );
	always @(posedge CLK or negedge RST) begin
        if (RST == 1)
            state <= nextState;
        else
            state <= 3'b000;
    end
    always@(state) begin
        if(state == 3'b000)
            nextState <= 3'b001;
        else if(state == 3'b001) begin
            if(opcode == 6'b000000 || opcode == 6'b000001 || opcode == 6'b000010 || opcode == 6'b010000 || opcode == 6'b010001
            || opcode == 6'b010010 || opcode == 6'b011000 || opcode == 6'b100110 || opcode == 6'b100111 || opcode == 6'b110100
            || opcode == 6'b110110 || opcode == 6'b110000 || opcode == 6'b110001)
                nextState <= 3'b010;
            else
                nextState <= 3'b000;
        end
        else if(state == 3'b010) begin
            if(opcode == 6'b000000 || opcode == 6'b000001 || opcode == 6'b000010 || opcode == 6'b010000 || opcode == 6'b010001
            || opcode == 6'b010010 || opcode == 6'b011000 || opcode == 6'b100110 || opcode == 6'b100111)
                nextState <= 3'b011;
            else if(opcode == 6'b110000 || opcode == 6'b110001)
                nextState <= 3'b100;
            else
                nextState <= 3'b000;
        end
        else if(state == 3'b100) begin
            if(opcode == 6'b110001)
                nextState <= 3'b011;
            else
                nextState <= 3'b000;
        end
        else if(state == 3'b011)
            nextState <= 3'b000;
    end
endmodule
