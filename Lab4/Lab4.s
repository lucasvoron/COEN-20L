	.syntax			unified
	.cpu			cortex-m4
	.text


/* void UseLDRB(void *dst, void *src); */
	.global			UseLDRB
	.thumb_func
	.align
UseLDRB:
	PUSH			{R4-R5}			// save values in R4 and R5
	.rept			128				// repeat loop 128 times to copy 4 bytes each time
	LDRB			R2,[R1]			// load one byte from R1 to R2
	LDRB			R3,[R1,1]		// load one byte from R1+1 to R3, increment by 1 because it is 1 byte
	LDRB			R4,[R1,2]		// load one byte from next to next register
	LDRB			R5,[R1,3]		// load one byte from next to next register

	STRB			R2,[R0]			// store one byte from R0 to R2
	STRB			R3,[R0,1]		// store one byte from R0+1 to R3
	STRB			R4,[R0,2]		// store one byte from next to next register
	STRB			R5,[R0,3]		// store one byte from next to next register

	ADD				R1,R1,4			// update the starting point for load
	ADD				R0,R0,4			// update the starting point for store
	.endr
	POP				{R4-R5}			// pop values that were pushed earlier
	BX				LR

/* void UseLDRH(void *dst, void *src); */
	.global			UseLDRH
	.thumb_func
	.align
UseLDRH:
	PUSH			{R4-R5}			// save values in R4 and R5
	.rept			64				// repeat loop 64 times and copy 8 bytes each time
	LDRH			R2,[R1]			// load one byte from R1 to R2
	LDRH			R3,[R1,2]		// load one byte from R1+2 to R3, increment by 2 because a half-word is 2 bytes
	LDRH			R4,[R1,4]		// load one byte from next to next register
	LDRH			R5,[R1,6]		// load one byte from next to next register

	STRH			R2,[R0]			// store one byte from R0 to R2
	STRH			R3,[R0,2]		// store one byte from R0+2 to R3
	STRH			R4,[R0,4]		// store one byte from next to next register
	STRH			R5,[R0,6]		// store one byte from next to next register

	ADD				R1,R1,8			// update the starting point for load
	ADD				R0,R0,8			// update the starting point for store
	.endr
	POP				{R4-R5}			// pop values that were pushed earlier
	BX				LR

/* void UseLDR(void *dst, void *src); */
	.global			UseLDR
	.thumb_func
	.align
UseLDR:
	.rept			128				// repeat loop 128 times and copy 4 bytes each time
	LDR				R2,[R1],4		// load 4 bytes from R1 to R2
	STR				R2,[R0],4		// store 4 bytes from R2 to R0
	.endr
	BX				LR
	
/* void UseLDRD(void *dst, void *src); */
	.global			UseLDRD
	.thumb_func
	.align
UseLDRD:
	.rept			64				// repeat loop 64 times and copy 8 bytes each time
	LDRD			R2,R3,[R1],8	// load 8 bytes from R1 to R2 and R3
	STRD			R2,R3,[R0],8	// store 8 bytes from R2 and R3 to R0
	.endr
	BX				LR

/* void UseLDM(void *dst, void *src); */
	.global			UseLDM
	.thumb_func
	.align
UseLDM:
	PUSH			{R4-R9}			// save values that are in R4-R9
	.rept			16				// repeat loop 16 times and copy 4 bytes for each of the 8 registers
	LDMIA			R1!,{R2-R9}		// load each register from R2-R9 into R1 every loop through
	STMIA			R0!,{R2-R9}		// store each register from R2-R9 into R0 every loop through
	.endr
	POP				{R4-R9}			// pop values that were pushed earlier
	BX				LR

	.end


