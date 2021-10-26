	.syntax			unified
	.cpu			cortex-m4
	.text


/* uint32_t Incr(uint32_t x); */
	.global			Add
	.thumb_func
	.align
Add:
	PUSH			{LR}
	ADD			R0,R0,R1	// adds value in R0 and R1
	POP			{PC}
	BX			LR

/* uint32_t Decr(uint32_t x); */
	.global			Less1
	.thumb_func
	.align
Less1:
	PUSH			{LR} 
	SUB			R0,R0,1		// returns value in R0-1, a-1
	POP			{PC}
	BX			LR

/* uint32_t Square2x(uint32_t x); */
	.global			Square2x
	.thumb_func
	.align
Square2x:
	PUSH			{LR}
	ADD			R0,R0,R0	// x+x
	BL			Square		// calling the square function to take the square of R0
	POP			{PC}
	BX			LR
	
/* uint32_t Last(uint32_t x); */
	.global			Last
	.thumb_func
	.align
Last:
	PUSH			{R0,LR}
	BL 			SquareRoot	// calling the square root function to take the square root
	POP			{R1,LR}
	ADD			R0,R1,R0	// add original x and the square root of x
	BX			LR
	
	.end
