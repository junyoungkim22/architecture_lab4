	.ORG    0
		JMP	ENTRY
VAR1	.BSC 0x0001
VAR2	.BSC 0xFFFF
STACK	.BSS 32
ENTRY:		LHI	$0, 0
24		WWD	$0	; TEST #1-1 : LHI (= 0x0000)
25		LHI	$1, 0
26		WWD	$1	; TEST #1-2 : LHI (= 0x0000)
27		LHI	$2, 0
28		WWD	$2	; TEST #1-3 : LHI (= 0x0000)
29		LHI	$3, 0
2a		WWD	$3	; TEST #1-4 : LHI (= 0x0000)

2b		ADI	$0, $1, 1
2c		WWD	$0	; TEST #2-1 : ADI (= 0x0001)
2d		ADI	$0, $0, 1
2e		WWD	$0	; TEST #2-2 : ADI (= 0x0002)

2f		ORI	$1, $2, 1
30		WWD	$1	; TEST #3-1 : ORI (= 0x0001)
31		ORI	$1, $1, 2
32		WWD	$1	; TEST #3-2 : ORI (= 0x0003)
33		ORI	$1, $1, 3
34		WWD	$1	; TEST #3-3 : ORI (= 0x0003)

35		ADD	$3, $0, $2
36		WWD	$3	; TEST #4-1 : ADD (= 0x0002)
37		ADD	$3, $1, $2
38		WWD	$3	; TEST #4-2 : ADD (= 0x0003)
39		ADD	$3, $0, $1
3a		WWD	$3	; TEST #4-3 : ADD (= 0x0005)

3b		SUB	$3, $0, $2
3c		WWD	$3	; TEST #5-1 : SUB (= 0x0002)
3d		SUB	$3, $2, $0
3e		WWD	$3	; TEST #5-2 : SUB (= 0xFFFE)
3f		SUB	$3, $1, $2
40		WWD	$3	; TEST #5-3 : SUB (= 0x0003)
41		SUB	$3, $2, $1
42		WWD	$3	; TEST #5-4 : SUB (= 0xFFFD)
43		SUB	$3, $0, $1
44		WWD	$3	; TEST #5-5 : SUB (= 0xFFFF)
45		SUB	$3, $1, $0
46		WWD	$3	; TEST #5-6 : SUB (= 0x0001)

47		AND	$3, $0, $2
48		WWD	$3	; TEST #6-1 : AND (= 0x0000)
49		AND	$3, $1, $2
4a		WWD	$3	; TEST #6-2 : AND (= 0x0000)
4b		AND	$3, $0, $1
4c		WWD	$3	; TEST #6-3 : AND (= 0x0002)

4d		ORR	$3, $0, $2
4e		WWD	$3	; TEST #7-1 : ORR (= 0x0002)
4f		ORR	$3, $1, $2
50		WWD	$3	; TEST #7-2 : ORR (= 0x0003)
51		ORR	$3, $0, $1
52		WWD	$3	; TEST #7-3 : ORR (= 0x0003)

53		NOT	$3, $0
54		WWD	$3	; TEST #8-1 : NOT (= 0xFFFD)
55		NOT	$3, $1
56		WWD	$3	; TEST #8-2 : NOT (= 0xFFFC)
57		NOT	$3, $2
58		WWD	$3	; TEST #8-3 : NOT (= 0xFFFF)

59		TCP	$3, $0
5a		WWD	$3	; TEST #9-1 : TCP (= 0xFFFE)
5b		TCP	$3, $1
5c		WWD	$3	; TEST #9-2 : TCP (= 0xFFFD)
5d		TCP	$3, $2
5e		WWD	$3	; TEST #9-3 : TCP (= 0x0000)

5f		SHL	$3, $0
60		WWD	$3	; TEST #10-1 : SHL (= 0x0004)
6a		SHL	$3, $1
6b		WWD	$3	; TEST #10-2 : SHL (= 0x0006)
6c		SHL	$3, $2
6d		WWD	$3	; TEST #10-3 : SHL (= 0x0000)

6e		SHR	$3, $0
6f		WWD	$3	; TEST #11-1 : SHR (= 0x0001)
70		SHR	$3, $1
		WWD	$3	; TEST #11-2 : SHR (= 0x0001)
		SHR	$3, $2
		WWD	$3	; TEST #11-3 : SHR (= 0x0000)

		LWD	$0, $2, VAR1
		WWD	$0	; TEST #12-1 : LWD (= 0x0001)
		LWD	$1, $2, VAR2
		WWD	$1	; TEST #12-2 : LWD (= 0xFFFF)

		SWD	$1, $2, VAR1
		SWD	$0, $2, VAR2

		LWD	$0, $2, VAR1
		WWD	$0	; TEST #13-1 : WWD (= 0xFFFF)
		LWD	$1, $2, VAR2
		WWD	$1	; TEST #13-2 : WWD (= 0x0001)

		JMP	JMP0
JMP0:		WWD	$0	; TEST #14-1 : JMP (= 0xFFFF)
		JMP	JMP1
		HLT
JMP1:		WWD	$1	; TEST #14-2 : JMP (= 0x0001)

		BNE	$2, $3, BNE1
		JMP	BNE2
BNE1:		HLT
BNE2:		WWD	$0	; TEST #15-1 : BNE (= 0xFFFF)

		BNE	$1, $2, BNE3
		HLT
BNE3:		WWD	$1	; TEST #15-2 : BNE (= 0x0001)

		BEQ	$1, $2, BEQ1
		JMP	BEQ2
BEQ1:		HLT
BEQ2:		WWD	$0	; TEST #16-1 : BEQ (= 0xFFFF)

		BEQ	$2, $3, BEQ3
		HLT
BEQ3:		WWD	$1	; TEST #16-2 : BEQ (= 0x0001)

		BGZ	$0, BGZ1
		JMP	BGZ2
BGZ1:		HLT
BGZ2:		WWD	$0	; TEST #17-1 : BGZ (= 0xFFFF)

		BGZ	$1, BGZ3
		HLT
BGZ3:		WWD	$1	; TEST #17-2 : BGZ (= 0x0001)

		BGZ	$2, BGZ4
		JMP	BGZ5
BGZ4:		HLT
BGZ5:		WWD	$0	; TEST #17-3 : BGZ (= 0xFFFF)

		BLZ	$0, BLZ1
		HLT
BLZ1:		WWD	$1	; TEST #18-1 : BLZ (= 0x0001)

		BLZ	$1, BLZ2
		JMP	BLZ3
BLZ2:		HLT
BLZ3:		WWD	$0	; TEST #18-2 : BLZ (= 0xFFFF)

		BLZ	$2, BLZ4
		JMP	BLZ5
BLZ4:		HLT
BLZ5:		WWD	$1	; TEST #18-3 : BLZ (= 0x0001)

		JAL	SIMPLE1
		WWD	$0	; TEST #19-1 : JAL & JPR (= 0xFFFF)

		JAL	SIMPLE2
		HLT
		WWD	$1	; TEST #19-2 : JAL & JPR (= 0x0001)

		LHI	$3, 0
		ORI	$3, $3, STACK

		LHI	$0, 0
		ADI	$0, $0, 5
		JAL	FIB
		WWD	$0	; TEST #19-3 : JAL & JPR (= 0x0008)

		JMP	PREFIB1
PREFIB2:	ADI	$1, $2, 0
		JRL	$1
		WWD	$0	; TEST #20 : JAL & JRL & JPR (= 0x0022)

		HLT		; FINISHED

SIMPLE2:	ADI	$2, $2, 1
SIMPLE1:	JPR	$2
		HLT

PREFIB1:	JAL	PREFIB2

FIB:		ADI	$1, $0, -1
		BGZ	$1, FIBRECUR
		LHI	$0, 0
		ORI	$0, $0, 1
		JPR	$2
		HLT
FIBRECUR:	SWD	$2, $3, 0
		SWD	$0, $3, 1		
		ADI	$3, $3, 2
		ADI	$0, $0, -2
		JAL	FIB
		LWD	$1, $3, -1
		SWD	$0, $3, -1
		ADI	$0, $1, -1
		JAL	FIB
		LWD	$1, $3, -1
		LWD	$2, $3, -2
		ADD	$0, $0, $1
		ADI	$3, $3, -2
		JPR	$2
		HLT
	.END