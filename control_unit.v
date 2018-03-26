`include "opcodes.v" 	   

module control_unit (state, signal);
	input [3:0] state;
	output reg [14:0] signal;
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

	initial
	begin
		signal = 5'd0;
	end

	always @ (*) begin
		case (state)
			state_reset: begin
				signal = 5'd0;
			end
			state_IF: begin
				$display("hello");
				signal = 15'b001010000101001;
				/*
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;*/
			end
			state_ID1: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_ID2: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_ID3: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_ID4: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_ID5: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_ID6: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_EX1: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_EX2: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_EX3: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_EX4: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_EX5: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_EX6: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_MEM1: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_MEM2: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_MEM3: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_MEM4: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
			state_WB: begin
				signal[14:13] = 2'b0;
				signal[12] = 1'b1;
				signal[11:10] = 2'b1;
				signal[9] = 1'b0;
				signal[8] = 1'b0;
				signal[7] = 1'b0;
				
				signal[6] = 1'b0;
				signal[5] = 1'b1;
				signal[4] = 1'b0;
				signal[3] = 1'b1;
				signal[2] = 1'b0;
				signal[1] = 1'b0;
				signal[0] = 1'b1;
			end
		endcase
	end
	
endmodule					