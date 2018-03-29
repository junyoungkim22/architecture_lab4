
`include "opcodes.v" 	   

module control_unit (state, signal);
	input [4:0] state;
	output wire [15:0] signal;
	//signal order : 1413PCSource 2, 12ALUOp, 1110ALUSrcB 2, 9ALUSrcA, 8RegWrite, 7RegDst,
	//               6PCWriteCond, 5PCWrite, 4IorD, 3MemRead, 2MemWrite, 1MemtoReg, 0IRWrite

	parameter state_reset = 5'd0;
	parameter state_IF = 5'd1;
	parameter state_ID1 = 5'd2;
	parameter state_ID2 = 5'd3;
	parameter state_ID3 = 5'd4;
	parameter state_ID4 = 5'd5;
	parameter state_ID5 = 5'd6;
	parameter state_ID6 = 5'd7;
	parameter state_EX1 = 5'd8;
	parameter state_EX2 = 5'd9;
	parameter state_EX3 = 5'd10;
	parameter state_EX4 = 5'd11;
	parameter state_EX5 = 5'd12;
	parameter state_EX6 = 5'd13;
	parameter state_MEM1 = 5'd14;
	parameter state_MEM2 = 5'd15;
	parameter state_MEM3 = 5'd16;
	parameter state_MEM4 = 5'd17;
	parameter state_WB = 5'd18;

	parameter state_ID7 = 5'd19;
	//reg PCALU;
	reg [1:0] PCSource;
	reg ALUOp;
	reg ALUSrcA;
	reg [1:0] ALUSrcB;
	reg RegWrite;
	reg [1:0] RegDst;
	reg PCWriteCond;
	reg PCWrite;
	reg IorD;
	reg MemRead;
	reg MemWrite;
	reg MemtoReg;
	reg IRWrite;
	
	//assign signal[15] = PCALU;
	assign signal[15:14] = PCSource[1:0];
	assign signal[13] = ALUOp;
	assign signal[12:11] = ALUSrcB[1:0];
	assign signal[10] = ALUSrcA;
	assign signal[9] = RegWrite;
	assign signal[8:7] = RegDst[1:0];
	assign signal[6] = PCWriteCond;
	assign signal[5] = PCWrite;
	assign signal[4] = IorD;
	assign signal[3] = MemRead;
	assign signal[2] = MemWrite;
	assign signal[1] = MemtoReg;
	assign signal[0] = IRWrite;

	initial
	begin
		//PCALU = 1'b0;
		PCSource = 2'b0;
		ALUOp = 1'b0;
		ALUSrcB= 2'b0;
		ALUSrcA = 1'b0;
		RegWrite = 1'b0;
		RegDst = 2'b00;
		
		PCWriteCond = 1'b0;
		PCWrite = 1'b0;
		IorD = 1'b0;
		MemRead = 1'b0;
		MemWrite = 1'b0;
		MemtoReg = 1'b0;
		IRWrite = 1'b0;
	end

	always @ (*) begin
		case (state)
			state_reset: begin
				PCSource = 2'b0;
				ALUOp = 1'b0;
				ALUSrcB= 2'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_IF: begin
				//$display("hello");
				//signal = 15'b001010000101001;
				PCSource = 2'b0;
				ALUOp = 1'b1;
				ALUSrcB= 2'b1;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b1;
				IorD = 1'b0;
				MemRead = 1'b1;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b1;
			end
			state_ID1: begin
				PCSource = 2'b0; //
				ALUOp = 1'b0; 	//
				ALUSrcB= 2'b0;	//
				ALUSrcA = 1'b0;	//
				RegWrite = 1'b0;	//
				RegDst = 2'b00;	//
				
				PCWriteCond = 1'b0;	//
				PCWrite = 1'b0;	//
				IorD = 1'b0;	//
				MemRead = 1'b0;	//
				MemWrite = 1'b0;	// 
				MemtoReg = 1'b0;	//
				IRWrite = 1'b0;	//
			end
			state_ID2: begin
				PCSource = 2'b0;
				ALUOp = 1'b0;
				ALUSrcB= 2'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_ID3: begin
				PCSource = 2'b0;
				ALUOp = 1'b0;
				ALUSrcB= 2'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_ID4: begin
				PCSource = 2'b0;
				ALUOp = 1'b1;
				ALUSrcB= 2'b10;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_ID5: begin
				PCSource = 2'b10;	// jump target
				ALUOp = 1'b0;
				ALUSrcB= 2'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b1;		// write enabled
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_ID6: begin
				PCSource = 2'b0;
				ALUOp = 1'b0;
				ALUSrcB= 2'b10;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_ID7: begin
				PCSource = 2'b10;	// jump target
				ALUOp = 1'b0;
				ALUSrcB= 2'b1;
				ALUSrcA = 1'b0;
				RegWrite = 1'b1;
				RegDst = 2'b10;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b1;		// write enabled
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_EX1: begin
				PCSource = 2'b0;
				ALUOp = 1'b1;
				ALUSrcB= 2'b0;
				ALUSrcA = 1'b1;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_EX2: begin       // LW
				PCSource = 2'b0;
				ALUOp = 1'b1;
				ALUSrcB= 2'b10;
				ALUSrcA = 1'b1;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_EX3: begin    // SWD
				PCSource = 2'b0;
				ALUOp = 1'b1;
				ALUSrcB= 2'b10;
				ALUSrcA = 1'b1;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_EX4: begin
				PCSource = 2'b1;
				ALUOp = 1'b0;
				ALUSrcB= 2'b0;
				ALUSrcA = 1'b1;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b1;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_EX5: begin
				PCSource = 2'b0;
				ALUOp = 1'b0;
				ALUSrcB= 2'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_EX6: begin
				PCSource = 2'b0;
				ALUOp = 1'b1;
				ALUSrcB= 2'b10;
				ALUSrcA = 1'b1;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_MEM1: begin
				PCSource = 2'b0;
				ALUOp = 1'b0;
				ALUSrcB= 2'b0;
				ALUSrcA = 1'b1;
				RegWrite = 1'b1;
				RegDst = 2'b01;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_MEM2: begin  // LW
				PCSource = 2'b0;
				ALUOp = 1'b0;
				ALUSrcB= 2'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b1;
				MemRead = 1'b1;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_MEM3: begin
				PCSource = 2'b0;
				ALUOp = 1'b0;
				ALUSrcB= 2'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b1;
				MemRead = 1'b0;
				MemWrite = 1'b1;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_MEM4: begin
				PCSource = 2'b1;	//
				ALUOp = 1'b0;
				ALUSrcB= 2'b10;
				ALUSrcA = 1'b1;
				RegWrite = 1'b1;
				RegDst = 2'b00; // $rt
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;		//
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IRWrite = 1'b0;
			end
			state_WB: begin
				PCSource = 2'b0;
				ALUOp = 1'b0;
				ALUSrcB= 2'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b1;
				RegDst = 2'b00;
				
				PCWriteCond = 1'b0;
				PCWrite = 1'b0;
				IorD = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b1;
				IRWrite = 1'b0;
			end
		endcase
	end

endmodule