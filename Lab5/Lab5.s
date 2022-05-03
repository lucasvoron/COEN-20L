	.syntax			unified
	.cpu			cortex-m4
	.text


/* uint64_t TireDiam(uint32_t W, uint32_t A, uint32_t R); */
	.global			TireDiam
	.thumb_func
	.align
TireDiam:
	PUSH			{R4}			// save value in R4
	MUL				R1,R0,R1		// R1 stores the multplication of A*W
	MOV				R4,R1			// Saves the value of A*W in R4
	LDR				R3,=1270		// Loads R3 with the value of 1270

	UDIV			R1,R1,R3		// Divides (A*W) by 1270 and stores that value in R1
	ADD				R1,R1,R2		// Adds R + (A*W)/1270 and puts the quotient into R1

	UDIV			R0,R4,R3		// Takes the stored value of (A*W) and divides it by 1270
	MLS				R0,R0,R3,R4		// Multiplies and subtracts the value from R4

	POP				{R4}			// pop value that was pushed earlier
	BX				LR

/* uint64_t TireCirc(uint32_t W, uint32_t A, uint32_t R); */
	.global			TireCirc
	.thumb_func
	.align
TireCirc:
	PUSH			{R4-R6,LR}		// save values in R4 and R5
	BL				TireDiam		// calls first function to get quotient and remainder from diameter
	LDR				R4,=4987290		// R4 stores the value of 4987290
	LDR				R5,=3927		// R5 stores the value of 3927
	MUL				R4,R1,R4		// Multiplies Quotient*4987290
	MUL				R5,R0,R5		// Multiplies Remainder*3927
	ADD				R4,R4,R5		// Adds values in R4 and R5
	LDR				R6,=1587500		// R6 stores the value of 1587500

	UDIV			R1,R4,R6		// Divides the numerator by R6

	UDIV			R0,R4,R6		// Takes the numerator and divides it by R6
	MLS				R0,R0,R6,R4		// Multiplies and subtracts the value from R4

	POP				{R4-R6,PC}			// pop values that were pushed earlier
	BX				LR

	.end