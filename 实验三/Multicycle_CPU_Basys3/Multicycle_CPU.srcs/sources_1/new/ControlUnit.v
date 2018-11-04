`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/23 19:28:50
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input CLK,
    input RST,
    input zero,
    input sign,
    input [5:0]opcode,
    output reg ExtSel,
    output PCWre,
    output reg IRWre,
    output reg InsMemRW,
    output reg WrRegDSrc,
    output reg [1:0]RegDst,
    output reg RegWre,
    output reg [2:0]ALUOp,
    output reg [1:0]PCSrc,
    output reg ALUSrcA,
    output reg ALUSrcB,
    output reg mRD,
    output reg mWR,
    output reg DBDataSrc,
    output [2:0]state
    );
    wire [2:0]state;
    wire [2:0]nextState;
//    initial begin
//        PCSrc=2'b00;
//    end
    assign PCWre= opcode != 6'b111111 && nextState == 3'b000;

    StateMachine StateMachine_Instance(
        .CLK(CLK),
        .RST(RST),
        .opcode(opcode),
        .state(state),
        .nextState(nextState)
    );

    always@(opcode or zero or sign or state) begin
        if(state == 3'b000)begin
            $display("##########state: 000##########");
            WrRegDSrc<=1'bz;
            InsMemRW<=1;
            IRWre<=1;
            RegWre<=0;
            mWR<=0;
            mRD<=0;
            DBDataSrc<=1'bz;
            ALUSrcA<=1'bz;
            ALUSrcB<=1'bz;
            ALUOp<=3'bzzz;
            ExtSel<=1'bz;
        end
        else if(state == 3'b001)begin
            $display("##########state: 001##########");
            //j
            if(opcode == 6'b111000)begin
                WrRegDSrc<=1'bz;
                RegDst<=2'bzz;
                RegWre<=0;
                PCSrc<=2'b11;
            end
            //jr
            else if(opcode == 6'b111001)begin
                RegDst<=2'bzz;
                RegWre<=0;
                PCSrc<=2'b10;
            end
            //jal
            else if(opcode == 6'b111010)begin
                WrRegDSrc<=1'b0;
                RegDst<=2'b00;
                RegWre<=1;
                PCSrc<=2'b11;
            end
            //halt
            else if(opcode == 6'b111111)begin
                RegDst<=2'bzz;
                RegWre<=0;
                PCSrc<=2'b00;
            end
        end
        else if(state == 3'b010)begin
            $display("##########state: 010##########");
            DBDataSrc = opcode == 6'b110001 ? 1 : 0;
            //add
            if(opcode == 6'b000000)begin
                ALUOp<=3'b000;
                ALUSrcA<=0;
                ALUSrcB<=0;
            end
            //sub
            else if(opcode == 6'b000001)begin
                ALUOp<=3'b001;
                ALUSrcA<=0;
                ALUSrcB<=0;
            end
            //addi
            else if(opcode == 6'b000010)begin
                ALUOp<=3'b000;
                ALUSrcA<=0;
                ALUSrcB<=1;
                ExtSel<=1;
            end
            //or
            else if(opcode == 6'b010000)begin
                ALUOp<=3'b101;
                ALUSrcA<=0;
                ALUSrcB<=0;
            end
            //and
            else if(opcode == 6'b010001)begin
                ALUOp<=3'b110;
                ALUSrcA<=0;
                ALUSrcB<=0;
            end
            //ori
            else if(opcode == 6'b010010)begin
                ALUOp<=3'b101;
                ALUSrcA<=0;
                ALUSrcB<=1;
                ExtSel<=0;
            end
            //sll
            else if(opcode == 6'b011000)begin
                ALUOp<=3'b100;
                ALUSrcA<=1;
                ALUSrcB<=0;
            end
            //slt
            else if(opcode == 6'b100110)begin
                ALUOp<=3'b011;
                ALUSrcA<=0;
                ALUSrcB<=0;
            end
            //sltiu
            else if(opcode == 6'b100111)begin
                ALUOp<=3'b010;
                ALUSrcA<=0;
                ALUSrcB<=1;
                ExtSel<=0;
            end
            //sw
            else if(opcode == 6'b110000)begin
                ALUOp<=3'b000;
                ALUSrcA<=0;
                ALUSrcB<=1;
                ExtSel<=1;
            end
            //lw
            else if(opcode == 6'b110001)begin
                ALUOp<=3'b000;
                ALUSrcA<=0;
                ALUSrcB<=1;
                ExtSel<=1;
            end
            //beq
            else if(opcode == 6'b110100)begin
                ALUOp<=3'b001;
                ALUSrcA<=0;
                ALUSrcB<=0;
                if(zero==1) begin
                    PCSrc<=2'b01;
                    ExtSel<=1;
                end
                else 
                    PCSrc<=2'b00;
            end
            //bltz
            else if(opcode == 6'b110110)begin
                ALUOp<=3'b001;
                ALUSrcA<=0;
                ALUSrcB<=0;
                if(sign==1)begin
                    PCSrc<=2'b01;
                    ExtSel<=1;
                end
                else
                    PCSrc<=2'b00;
            end
        end
        else if(state == 3'b100)begin
            $display("##########state: 100##########");
            //sw
            if(opcode == 6'b110000)begin
                mWR<=1;
                mRD<=0;
                DBDataSrc<=1'bz;
                PCSrc<=2'b00;
            end
            //lw
            else if(opcode == 6'b110001)begin
                mRD<=1;
                mWR<=0;
                DBDataSrc<=1;
            end
        end
        else if(state == 3'b011)begin
            $display("##########state: 011##########");
            WrRegDSrc<=1;
            RegWre<=1;
            PCSrc<=2'b00;
            //add
            if(opcode == 6'b000000)
                RegDst<=2'b10;
            //sub
            else if(opcode == 6'b000001)
                RegDst<=2'b10;
            //addi
            else if(opcode == 6'b000010)
                RegDst<=2'b01;
            //or
            else if(opcode == 6'b010000)
                RegDst<=2'b10;
            //and
            else if(opcode == 6'b010001)
                RegDst<=2'b10;
            //ori
            else if(opcode == 6'b010010)
                RegDst<=2'b01;
            //sll
            else if(opcode == 6'b011000)
                RegDst<=2'b10;
            //slt
            else if(opcode == 6'b100110)
                RegDst<=2'b10;
            //sltiu
            else if(opcode == 6'b100111)
                RegDst<=2'b01;
            //lw
            else if(opcode == 6'b110001)
                RegDst<=2'b01;
        end
    end
endmodule
