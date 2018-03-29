`include "opcodes.v"

module alu_control (instruction, OP);
	input [`WORD_SIZE - 1:0] instruction;
	output reg [3:0] OP;
	wire [5:0] func = instruction[5:0];
	wire [3:0] opcode = instruction[15:12];

	always @ (*) begin
		if(opcode == 4'hf) begin            //rtype
			case(func)
				`FUNC_ADD : OP = 4'h0;
				`FUNC_SUB : OP = 4'h1;
				`FUNC_SHR : OP = 4'ha;
				`FUNC_SHL : OP = 4'hd;
				`FUNC_ORR : OP = 4'h6;
				`FUNC_NOT : OP = 4'h9;
				`FUNC_TCP : OP = 4'hc;
				`FUNC_AND : OP = 4'h5;
				`FUNC_WWD : OP = 4'h0;
			endcase
		end
		else begin
			case(opcode)
				`ADI_OP : OP = 4'h0;
				`ORI_OP : OP = 4'h6;
				`LHI_OP : OP = 4'hf;
				`LWD_OP : OP = 4'h0;
				`SWD_OP : OP = 4'h0;
				`BNE_OP : OP = 4'h0;
				`BEQ_OP : OP = 4'h0;
				`JMP_OP : OP = 4'h0;
			endcase
		end
	end

endmodule
