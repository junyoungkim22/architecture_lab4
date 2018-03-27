//`timescale 1ns/1ns
`define WORD_SIZE 16    // data and address word size



module controller(clk, opcode, Reset_N, signal, num_inst);
	input clk;
	wire clk;
	input opcode;
	wire [3:0] opcode;
	//wire [5:0] instruction;
	input Reset_N;
	wire Reset_N;
	
	//output state;
	reg [4:0] state;
	output wire [14:0] signal;

	output reg [`WORD_SIZE-1:0] num_inst;
	// TODO : Implement your microcode gen
	// state
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

	reg [4:0] next_state;
	//reg [`NUM_COMPLETED_SIGNAL-1:0] completed_signal;
	reg [`WORD_SIZE-1:0] next_num_inst;
	//control_unit (required_RTs, signal);

	control_unit control(state, signal);
	
	always@(posedge clk)
	begin
		if(!Reset_N) begin
			num_inst <= 0;
			next_num_inst <= 0;
			state <= state_reset;
			next_state <= state_IF;
		end
		else begin
			num_inst <= next_num_inst;
			state <= next_state;
		end
	end
	/*RWD, ENI, DSI are not implemented */
	always @(*) begin
		case(state)
			state_reset: begin
				next_state = state_IF;
			end
			state_IF: begin
				case(opcode)
					4'b1111: begin
						next_state = state_ID1;
					end
					4'b0000: begin //BNE
						next_state = state_ID4;
					end
					4'b0001: begin //BEQ
						next_state = state_ID4;
					end
					4'b0010: begin //BGZ
						next_state = state_ID4;
					end
					4'b0011: begin //BLZ
						next_state = state_ID4;
					end
					4'b0100: begin //ADI
						next_state = state_ID6;
					end
					4'b0101: begin //ORI
						next_state = state_ID6;
					end
					4'b0110: begin //LHI
						next_state = state_ID6;
					end
					4'b0111: begin //LWD
						next_state = state_ID2;
					end
					4'b1000: begin //SWD
						next_state = state_ID3;
					end
					4'b1001: begin //JMP
						next_state = state_ID5;
					end
					4'b1010: begin //JAL
						next_state = state_ID5;
					end
				endcase
			end
			state_ID1: begin
				next_state = state_EX1;
			end
			state_ID2: begin
				next_state = state_EX2;
			end
			state_ID3: begin
				next_state = state_EX3;
			end
			state_ID4: begin
				next_state = state_EX4;
			end
			state_ID5: begin
				next_state = state_IF;
				next_num_inst = num_inst+1;
			end
			state_ID6: begin
				next_state = state_EX6;
			end
			state_EX1: begin
				next_state = state_MEM1;
			end
			state_EX2: begin
				next_state = state_MEM2;
			end
			state_EX3: begin
				next_state = state_MEM3;
			end
			state_EX4: begin
				next_state = state_IF;
				next_num_inst = num_inst+1;
			end
			state_EX5: begin
				next_state = state_IF;
				//next_num_inst = num_inst+1;
			end
			state_EX6: begin
				next_state = state_MEM4;
			end
			state_MEM1: begin	//for R-type
				next_state = state_IF;
				next_num_inst = num_inst+1;
			end
			state_MEM2: begin	//for LW
				next_state = state_WB;
			end
			state_MEM3: begin
				next_state = state_IF;
				next_num_inst = num_inst+1;
			end
			state_MEM4: begin
				next_state = state_IF;
				next_num_inst = num_inst+1;
			end
			state_WB: begin
				next_state = state_IF;
				next_num_inst = num_inst+1;
			end
		endcase
	end
endmodule