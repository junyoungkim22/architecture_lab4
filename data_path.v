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
	signal,
	is_halted
);

	input clk;
	input reset_n;
	output readM1;
	output [`WORD_SIZE-1:0] address1;
	output readM2;
	output writeM2;
	output [`WORD_SIZE-1:0] address2;
	input [`WORD_SIZE-1:0] data1;
	output [`WORD_SIZE-1:0] data2;
	output reg [`WORD_SIZE-1:0] output_reg;
	output [3:0] opcode;
	input [`WORD_SIZE-1:0] PC;
	output [`WORD_SIZE-1:0] nextPC;
	input [15:0] signal;
	output is_halted;

	//registers
	reg [`WORD_SIZE-1:0] instruction;
	reg [`WORD_SIZE-1:0] memData;

	//check if instruction is HLT
	reg isHLT;
	assign is_halted = isHLT;
	//reg isWWD;

	//control signals
	wire [1:0] PCSource = signal[15:14];
	wire ALUOp = signal[13];
	wire [1:0] ALUSrcB = signal[12:11];
	wire ALUSrcA = signal[10];
	wire RegWrite = isHLT ? 0 : signal[9];
	wire RegDst = signal[8:7];
	wire PCWriteCond = signal[6];
	wire PCWrite = isHLT ? 0 : signal[5];
	wire IorD = signal[4];
	wire MemRead = signal[3];
	wire MemWrite = signal[2];
	wire MemtoReg = signal[1];
	wire IRWrite = isHLT ? 0 : signal[0];

	//only going to use data2 for writing, so make data2 in memory be z
	wire readM2 = 0;

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
	wire [3:0] OP = ALUOp ? (PCWrite ? 0 : alu_control_output) : (PCWriteCond ? 1 : 0);
	wire [`WORD_SIZE-1:0] ALUOut;
	wire equal;
	wire bigger;
	reg [`WORD_SIZE-1:0] ALUOutReg;

	//output of ALU
	wire [`WORD_SIZE-1:0] calc_address = ALUOutReg;

	//assign writedata of alu
	assign writeData = MemtoReg ? memData : ALUOutReg;


	//jump logic
	wire [`WORD_SIZE-1:0] jumpTarget = {PC[15:12], instruction[11:0]};

	//branch logic
	//wire bcond = (opcode == `BNE_OP) ? equal : !equal;
	wire bcond; 

	wire [`WORD_SIZE-1:0] calcPC = (PCSource <= 1) ? ((PCSource) ? ALUOutReg : ALUOut) : jumpTarget;
	wire updatePC = (bcond && PCWriteCond) || PCWrite;

	assign nextPC = updatePC ? calcPC : PC;


	assign readM1 = MemRead;
	assign address1 = (!IorD) ? PC : calc_address;
	assign writeM2 = MemWrite ? 1 : 0;
	assign address2 = calc_address;
	assign data2 = readData2;

	//don't write if WWD instruction
	wire regFileWrite = isWWD ? 0 : RegWrite;

	alu_control AC(instruction, alu_control_output);
	register_file regFile (r1, r2, rd, writeData, regFileWrite, readData1, readData2, clk, reset_n);
	ALU alu(A, B, OP, ALUOut, opcode, bcond);

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

	initial begin
		memData <= 0;
		isHLT <= 0;
		ALUOutReg <= 0;
	end

	always @ (posedge clk) begin
		if(!reset_n) begin
			//instruction <= 0;
			memData <= 0;
			isHLT <= 0;
			ALUOutReg <= 0;
			//isWWD <= 0;
			//isHLT = 0;
			
		end
		/*
		else begin
			if(MemRead) begin
				memData <= data1;
			end
		end
		*/
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

	always @ (instruction) begin
		if(opcode == 15) begin
			if(instruction[5:0] == 29) isHLT = 1;
			//else if(instruction[5:0] == 29) isHLT = 1;
		end
		else begin
			isHLT = 0;
			//isHLT = 0;
		end
	end
	

	
	
endmodule				