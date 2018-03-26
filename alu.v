`include "opcodes.v"
						 
module ALU(A,B,OP,C, equal);

	input signed [`WORD_SIZE-1:0]A;
	input signed [`WORD_SIZE-1:0]B;
	input [3:0]OP;
	output signed [`WORD_SIZE-1:0]C;					   
	output reg equal;

	reg[15:0] C;
	
	initial begin
	equal = 0;
	end

	always @ (A or B or OP) begin
		equal = 0;
		if(OP == 4'b0000) begin C = A + B; end
		else if(OP == 4'b0001) begin
			C = A - B;
			if(C == 0) equal = 0;    //A=B
			else equal = 1;
		end
		else if (OP == 4'b0010) begin C <= ~(A & B); end
		else if (OP == 4'b0011) begin C <= ~(A | B); end
		else if (OP == 4'b0100) begin C <= A ~^ B; end
		else if (OP == 4'b0101) begin C <= (A & B); end
		else if (OP == 4'b0110) begin C <= (A | B); end
		else if (OP == 4'b0111) begin C <= (A ^ B); end
		else if (OP == 4'b1000) begin C <= A; end
		else if (OP == 4'b1001) begin C <= ~A; end
		else if (OP == 4'b1010) begin C <= {A[15], A[15:1]}; end
		else if (OP == 4'b1011) begin C <= A >>> 1; end
		else if (OP == 4'b1100) begin C <= ~(A) + 1; end            //TCP
		else if (OP == 4'b1101) begin C <= A << 1; end
		else if (OP == 4'b1110) begin C <= A <<< 1; end
		else if (OP == 4'b1111) begin C <= {B[7:0], 8'h00}; end     //LHI
	end
	
endmodule

