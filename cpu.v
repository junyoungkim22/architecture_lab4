`timescale 1ns/1ns
`include "data_path.v"
`include "controller.v"

module cpu(Clk, Reset_N, readM1, address1, data1, readM2, writeM2, address2, data2, num_inst, output_port, is_halted);
	input Clk;
	wire Clk;

	input Reset_N;
	wire Reset_N;
	
	output readM1;
	wire readM1;

	output [`WORD_SIZE-1:0] address1;
	wire [`WORD_SIZE-1:0] address1;

	output readM2;
	wire readM2;

	output writeM2;
	wire writeM2;

	output [`WORD_SIZE-1:0] address2;
	wire [`WORD_SIZE-1:0] address2;
	
	input [`WORD_SIZE-1:0] data1;
	wire [`WORD_SIZE-1:0] data1;

	inout [`WORD_SIZE-1:0] data2;
	wire [`WORD_SIZE-1:0] data2;

	output [`WORD_SIZE-1:0] num_inst;     //to control
	wire [`WORD_SIZE-1:0] num_inst;

	output [`WORD_SIZE-1:0] output_port;
	wire [`WORD_SIZE-1:0] output_port;

	output is_halted;
	wire is_halted;

	wire [`WORD_SIZE-1:0] output_reg;
	wire [3:0] opcode;
	reg [`WORD_SIZE-1:0] PC;
	wire [`WORD_SIZE-1:0] nextPC;
	wire [14:0] signal;
	// TODO : Implement your multi-cycle CPU!
	data_path DP (
		Clk, 
		Reset_N,
		readM1, 
		address1, 
		data1, 
		readM2, 
		writeM2, 
		address2, 
		data2, 
		output_reg, 
		opcode,
		PC,
		nextPC,
		signal
	);

	controller CPU_CON (Clk, opcode, Reset_N, signal, num_inst);

	initial begin
		PC <= 0;
	end

	always @ (posedge Clk) begin
		if(!Reset_N) begin
			PC <= 0;
		end
		else begin
			PC <= nextPC;
		end
	end


	initial begin
	end
	
endmodule