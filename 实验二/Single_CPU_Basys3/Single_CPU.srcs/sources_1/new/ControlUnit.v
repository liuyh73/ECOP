`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/20 19:36:33
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
	input [5:0]opcode,
	input zero,
	output reg RegDst,
	output InsMemRW,
	output PCWre,
	output reg ExtSel,
	output reg DBDataSrc,
	output mWR,
	output mRD,
	output reg ALUSrcB,
	output reg ALUSrcA,
	output reg[1:0]PCSrc=2'b00,
	output reg[2:0]ALUOp,
	output reg RegWre
	);
	
    assign PCWre = (opcode == 6'b111111) ? 0 : 1;
    assign mRD = (opcode == 6'b100111) ? 1 : 0;
    assign mWR = (opcode == 6'b100110) ? 1 : 0;
    assign InsMemRW = 1;
	always @(opcode or zero) begin
		//add rd,rs,rt
		if(opcode == 6'b000000) begin
			PCSrc[1:0]<=2'b00;
			RegDst <= 1;
			RegWre <= 1;
			ALUSrcA <= 0;
			ALUSrcB <= 0;
			ExtSel <= 1'bz;
			ALUOp[2:0] <= 3'b000;
			DBDataSrc <= 0;
		end

		//addi rt,rs,immediate
		else if (opcode == 6'b000001) begin
			PCSrc[1:0]<=2'b00;
			RegDst<=0;
			RegWre<=1;
			ALUSrcA<=0;
			ALUSrcB<=1;
			ExtSel<=1;
			ALUOp[2:0] <= 3'b000;
			DBDataSrc<=0;
		end

		//sub rd,rs,rt
		else if (opcode == 6'b000010) begin
			PCSrc[1:0]<=2'b00;
			RegDst <= 1;
			RegWre <= 1;
			ALUSrcA <= 0;
			ALUSrcB <= 0;
			ExtSel <= 1'bz;
			ALUOp[2:0] <= 3'b001;
			DBDataSrc <= 0;
		end

		//ori rt,rs,immediate
		else if(opcode == 6'b010000) begin
			PCSrc[1:0]<=2'b00;
			RegDst<=0;
			RegWre<=1;
			ALUSrcA<=0;
			ALUSrcB<=1;
			//ExtSel<=0;
			ALUOp[2:0] <= 3'b011;
			DBDataSrc<=0;
		end

		//and rd,rs,rt
		else if (opcode == 6'b010001) begin
			PCSrc[1:0]<=2'b00;
			RegDst <= 1;
			RegWre <= 1;
			ALUSrcA <= 0;
			ALUSrcB <= 0;
			ExtSel <= 1'bz;
			ALUOp[2:0] <= 3'b100;
			DBDataSrc <= 0;
		end

		//or rd,rs,rt
		else if (opcode == 6'b010010) begin
			PCSrc[1:0]<=2'b00;
			RegDst <= 1;
			RegWre <= 1;
			ALUSrcA <= 0;
			ALUSrcB <= 0;
			ExtSel <= 1'bz;
			ALUOp[2:0] <= 3'b011;
			DBDataSrc <= 0;
		end

		//sll rd,rt,sa
		else if(opcode == 6'b011000) begin
			PCSrc[1:0]<=2'b00;
			RegDst<=0;
			RegWre<=1;
			ALUSrcA<=1;
			ALUSrcB<=0;
			ExtSel <= 1'bz;
			ALUOp[2:0]<=3'b010;
			DBDataSrc<=0;
		end

		//slti rt,rs,immediate
		else if (opcode == 6'b011011) begin
			PCSrc[1:0]<=2'b00;
			RegDst<=0;
			RegWre<=1;
			ALUSrcA<=0;
			ALUSrcB<=1;
			ExtSel<=1;
			ALUOp[2:0] <= 3'b110;
			DBDataSrc<=0;
		end

		//sw rt, immediate(rs)
		else if (opcode == 6'b100110) begin
			PCSrc[1:0]<=2'b00;
			RegDst<=1'bz;
			RegWre<=0;
			ALUSrcA<=0;
			ALUSrcB<=1;
			ExtSel<=1;
			ALUOp<=3'b000;
			DBDataSrc<=0;
		end

		//lw rt, immediate(rs)
		else if (opcode == 6'b100111) begin
			PCSrc[1:0]<=2'b00;
			RegDst<=0;
			RegWre<=1;
			ALUSrcA<=0;
			ALUSrcB<=1;
			ExtSel<=1;
			ALUOp<=3'b000;
			DBDataSrc<=1;
		end

		//beq rs, rt, immediate
		else if (opcode == 6'b110000) begin
			RegDst<=1'bz;
			RegWre<=0;
			ALUSrcA<=0;
			ALUSrcB<=0;
			ALUOp<=3'b001;
			if(zero==1) begin
				ExtSel<=1;
				PCSrc[1:0] <= 2'b01;
			end
			else begin
				PCSrc[1:0]<=2'b00;
			end
		end

		//bne rs, rt, immediate
		else if (opcode == 6'b110001) begin
			RegDst<=1'bz;
			RegWre<=0;
			ALUSrcA<=0;
			ALUSrcB<=0;
			ALUOp<=3'b001;
            ExtSel<=1;
			if(zero==0) begin
				PCSrc[1:0] <= 2'b01;
			end
			else begin
				PCSrc[1:0] <= 2'b00;
			end
			$display("bne--***---%b",zero);
		end

		//j addr
		else if (opcode == 6'b111000) begin
			PCSrc[1:0]<=2'b10;
			RegDst<=1'bz;
			RegWre<=0;
			ALUSrcA<=1'bz;
			ALUSrcB<=1'bz;
			ExtSel<=1'bz;
			ALUOp<=3'bzzz;
			DBDataSrc<=1'bz;
		end

		//halt
		else if (opcode == 6'b111111) begin
            ALUSrcA <= 1'bz;
            ALUSrcB <= 1'bz;
            DBDataSrc <= 1'bz;
            RegWre <= 0;
            RegDst <= 1'bz;
            ExtSel <= 1'bz;
            ALUOp <= 3'bzzz;
		end
		//$display("opcode--***---%h",opcode);
	end
endmodule
