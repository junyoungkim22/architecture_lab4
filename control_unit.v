`include "opcodes.v" 	   

module control_unit (required_RTs, signal);
	input [13:0] required_RTs;
	output reg [11:0] signal;
	//signal order : RegDst, Jump, Branch, MemRead, MemtoReg,
	//               MemWrite, ALUSrc, RegWrite, ALUOp(4 bits)

	initial
	begin
		signal = 0;
	end

	always @ (*)
	begin
		
	end
	
endmodule					