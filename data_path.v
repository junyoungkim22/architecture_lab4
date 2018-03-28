`include "opcodes.v" 
`include "alu.v"
`include "register_file.v"
`include "alu_control.v"	   

module data_path (
	clk,
	reset_n,
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

	input clk;
	input reset_n;
	output readM1;
	output [`WORD_SIZE-1:0] address1;
	output readM2;
	output writeM2;
	output [`WORD_SIZE-1:0] address2;
	input [`WORD_SIZE-1:0] data1;
	inout [`WORD_SIZE-1:0] data2;
	output reg [`WORD_SIZE-1:0] output_reg;
	output [3:0] opcode;
	input [`WORD_SIZE-1:0] PC;
	output [`WORD_SIZE-1:0] nextPC;
	input [14:0] signal;

	//registers
	reg [`WORD_SIZE-1:0] instruction;
	reg [`WORD_SIZE-1:0] memData;

	//control signals
	/*
	wire PCWriteCond = ;
	wire PCWrite;
	wire IorD;
	wire MemRead;
	wire MemWrite;
	wire MemToReg;
	wire IRWrite;
	wire PCSource;
	wire ALUOp;
	wire [1:0] ALUSrcB;
	wire ALUSrcA;
	wire RegWrite;
	wire RegDst;
	*/
	wire [1:0] PCSource = signal[14:13];
	wire ALUOp = signal[12];
	wire [1:0] ALUSrcB = signal[11:10];
	wire ALUSrcA = signal[9];
	wire RegWrite = signal[8];
	wire RegDst = signal[7];
	wire PCWriteCond = signal[6];
	wire PCWrite = signal[5];
	wire IorD = signal[4];
	wire MemRead = signal[3];
	wire MemWrite = signal[2];
	wire MemtoReg = signal[1];
	wire IRWrite = signal[0];

	//inputs and outputs for register file
	wire [1:0] r1 = instruction[11:10];
	wire [1:0] r2 = instruction[9:8];
	wire [1:0] rd;
	assign rd = RegDst ? instruction[7:6] :  instruction[9:8];
	wire [`WORD_SIZE-1:0] writeData;
	wire [`WORD_SIZE-1:0] readData1;
	wire [`WORD_SIZE-1:0] readData2;

	//sign-extended instruction[7:0]
	wire [`WORD_SIZE-1:0] sign_extended = { {8{instruction[7]}}, instruction[7:0] };
	wire [`WORD_SIZE-1:0] zero_extended = {8'h00, instruction[7:0]};         //use for ori op

	//opcode
	assign opcode = instruction[15:12];

	//check if instruction if WWD
	wire isWWD = (opcode == 15) ? ((instruction[5:0] == 28) ? 1 : 0) : 0;

	//alu control output
	wire [3:0] alu_control_output;

	//inputs and outputs for regALU
	wire [`WORD_SIZE-1:0] A = ALUSrcA ? readData1 : PC;
	wire [`WORD_SIZE-1:0] beforeB = (ALUSrcB >= 2) ? ((ALUSrcB == 2) ? sign_extended : zero_extended) : ((ALUSrcB == 1) ? 1 : readData2);
	wire [`WORD_SIZE-1:0] B = isWWD ? (PCWrite ? 1 : 0) : beforeB;
	wire [3:0] OP = ALUOp ? (PCWrite ? 0 : alu_control_output) : 0;
	wire [`WORD_SIZE-1:0] ALUOut;
	wire equal;
	reg [`WORD_SIZE-1:0] ALUOutReg;

	//output of ALU
	wire [`WORD_SIZE-1:0] calc_address = ALUOut;

	//set value of output reg
	//assign output_reg = isWWD ? ALUOut : 0;

	//assign writedata of alu
	assign writeData = MemtoReg ? memData : ALUOutReg;


	//jump logic
	wire [`WORD_SIZE-1:0] jumpTarget = {PC[15:12], instruction[11:0]};

	//branch logic
	wire bcond = (instruction[15:12] == `BNE_OP) ? equal : !equal; 

	wire [`WORD_SIZE-1:0] calcPC = (PCSource <= 1) ? ((PCSource) ? ALUOut + 1 : ALUOut) : jumpTarget;
	wire updatePC = (bcond && PCWriteCond) || PCWrite;

	assign nextPC = updatePC ? calcPC : PC;


	assign readM1 = MemRead;
	assign address1 = (!IorD) ? PC : calc_address;
	assign writeM2 = MemWrite ? 1 : 0;
	assign address2 = calc_address;
	assign data2 = MemWrite ? readData2 : `WORD_SIZE'bz;

	//don't write if WWD instruction
	wire regFileWrite = isWWD ? 0 : RegWrite;

	alu_control AC(instruction, alu_control_output);
	register_file regFile (r1, r2, rd, writeData, regFileWrite, readData1, readData2, clk, reset_n);
	ALU alu(A, B, OP, ALUOut, equal);

/*
	always @ (posedge clk) begin
		if(!reset_n) begin
			instruction <= 0;
			memData <= 0;
		end
		else begin
			if(MemRead) begin
				if(!IorD) begin 
					if(IRWrite) instruction <= data1;
				end
			end
			else memData <= data1;
		end
	end
*/
	always @ (posedge clk) begin
		if(!reset_n) begin
			//instruction <= 0;
			memData <= 0;
		end
		else begin
			if(MemRead) begin
				memData <= data1;
			end
		end
	end

	/*
	always @ (negedge clk) begin
		if(reset_n) begin
			if(MemRead) begin
				if(!IorD) begin 
					if(IRWrite) begin 
						instruction <= data1;
					end
				end
			end
			//else memData <= data1;
		end
	end
	*/
	always @ (data1) begin
		if(reset_n) begin
			if(MemRead) begin
				if(!IorD) begin 
					if(IRWrite) begin 
						instruction <= data1;
					end
				end
				else begin	// for data
					if(MemRead) begin
						memData <= data1;
					end
				end
			end
			//else memData <= data1;
		end
	end

	always @ (posedge RegWrite) begin
		if(isWWD) output_reg = ALUOut;
	end

	always @ (negedge ALUOp) begin
		ALUOutReg = ALUOut;
	end

	
	
endmodule				