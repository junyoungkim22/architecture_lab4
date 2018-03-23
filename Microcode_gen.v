`timescale 1ns/1ns
`define WORD_SIZE 16    // data and address word size

`define stageIF 0;
`define stageID 1;
`define stageEX 2;
`define stageMEM 3;
`define stageWB 4;

`define NUM_RT 15;
`define completed_signal 7;

module Microcod_gen(clk, instruction, required_RTs, signal);
	input clk;
	wire clk;
	input instruction;
	wire [`WORD_SIZE-1:0] instruction;
	
	output required_RTs;
	reg [`NUM_RT-1:0] required_RTs;
	output wire [11:0] signal;


	// TODO : Implement your microcode gen
	reg [2:0] current_stage;
	reg [2:0] next_stage;
	reg [`NUM_COMPLETED_SIGNAL-1:0] completed_signal;

	control_unit (required_RTs, completed_signal, signal);


	always@(posedge clk)
	begin
		current_stage = next_stage;
	end

	always @(*)
	begin
		next_stage = current_stage + 1;

		if(instruction[15:12] == `ALU_OP)       // R-type
		begin
			case(instruction[5:0])
				`FUNC_ADD: signal = 12'h810;   // ADD
				`FUNC_SUB: signal = 12'h811;	
				`FUNC_SHR: signal = 12'h81a;
				`FUNC_SHL: signal = 12'h81d;
				`FUNC_ORR: signal = 12'h816;
				`FUNC_NOT: signal = 12'h819;
				`FUNC_TCP: signal = 12'h81c;
				`FUNC_AND: signal = 12'h815;
				`FUNC_WWD: 
					required_RTs = 0;
					case (current_stage)
						`stageIF: required_RTs[0]=1;
						`stageID: 
						begin
							required_RTs[4]=1;
							completed_signal[0]=1;
						end
						`stageEX: 
						begin
							next_stage = stageWB;
							completed_signal[4:1] = 0;
							required_RTs[6]=1;
						end
						`stageMEM: ;
						`stageWB: required_RTs[14] = 1;
					endcase
			endcase
		end
		else
		begin
			case(instruction[15:12])
				`ADI_OP: signal = 12'h030;
				`SWD_OP: signal = 12'h060;
				`LWD_OP: signal = 12'h960;
				`BNE_OP: signal = 12'h201;
				`BEQ_OP: signal = 12'h201;
				`JMP_OP: signal = 12'h400;
				`LHI_OP: signal = 12'h03f;
				`ORI_OP: signal = 12'h036;
			endcase
		end
	end
endmodule