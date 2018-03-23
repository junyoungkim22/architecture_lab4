# architecture_lab4
multi-cycle cpu

Microcontroller output  
0 PC &leftarrow; PC+4  
1 PC &leftarrow; ALUOut (if PCWriteCond is asserted)  
2 PC &leftarrow; PC[ 31:28 ],IR[ 25:0 ],2’b00  
3 IR &leftarrow; MEM[ PC ]  
4 A  &leftarrow; RF[ IR[ 25:21 ] ]  
5 B  &leftarrow; RF[ IR[ 20:16 ] ]  
6 ALUOut &leftarrow; A + B  
7 ALUOut &leftarrow; A + sign-extend (IR[ 15:0 ])  
8 ALUOut &leftarrow; PC + ( sign-extend (IR[ 15:0 ]) <<2 )  
9 MDR &leftarrow; MEM[ ALUOut ]  
10 MEM[ ALUOut ] &leftarrow; B  
11 RF[ IR[ 15:11 ] ] &leftarrow; ALUOut,  
12 RF[ IR[ 20:16 ] ] &leftarrow; ALUOut  
13 RF[ IR[ 20:16 ] ] &leftarrow; MDR  
14 outputport &leftarrow; ALUOut

CompletedSignal  
0 Set B = 0  
1  
