	.syntax			unified
	.cpu			cortex-m4
	.text


/* void MatrixMultiply(int32_t A[3][3], int32_t B[3][3], int32_t C[3][3]); */
	.global			MatrixMultiply
	.thumb_func
	.align
MatrixMultiply: // R4=row, R5=col, R6=k
	PUSH			{R4-R11,LR}	    // save values
    MOV             R7,R0           // store original a in R7
    MOV             R8,R1           // store original b in R8
    MOV             R9,R2           // store original c in R9
    
    LDR             R4,=0           // load R4, row, = to zero
Outer:
    CMP             R4,2            // compare row and 2
    BGT             Done            // branch to Done if greater than 2

    LDR             R5,=0           // load R5, col, = to zero
Middle:
    CMP             R5,2            // compare col and 2
    BGT             OuterInc        // branch to OuterInc if greater than 2
                                    // a + 4(3(row)+col)
    LDR             R11,=3          // load constant 3 into R11
    MUL             R10,R4,R11      // multiply 3 and row and place 3(row) into R10
    ADD             R10,R10,R5      // add 3(row) and col, R5 and place it into R10
    LDR             R11,=4          // load constant 4 into R11
    MUL             R10,R10,R11     // multiply 4 and R11 (3(row)+col)
    ADD             R0,R7,R10       // add R7, original value of a to 4(3(row)+col)
    LDR             R11,=0          // load the constant 0 into R11
    STR             R11,[R0]        // store 0 in the de-referenced address of R0

    LDR             R6,=0           // load R6, k, = to zero
Inner:
    CMP             R6,2            // compare k and 2
    BGT             MiddleInc       // if greater than 2 branch to MiddleInc
                                    // a + 4(3(row)+col)
    LDR             R11,=3          // load constant 3 into R11
    MUL             R10,R4,R11      // multiply 3 and row and place 3(row) into R10
    ADD             R10,R10,R5      // add 3(row) and col, R5 and place it into R10
    LDR             R11,=4          // load constant 4 into R11
    MUL             R10,R10,R11     // multiply 4 and R10 (3(row)+col)
    ADD             R0,R7,R10       // add R7, original value of a to 4(3(row)+col)
    LDR             R0,[R0]         // load the value into R0

                                    // b + 4(3(row)+k)
    LDR             R11,=3          // load constant 3 into R11
    MUL             R10,R4,R11      // multiply 3 and row and place 3(row) into R10
    ADD             R10,R10,R6      // add 3(row) and k, R6 and place it into R10
    LDR             R11,=4          // load constant 4 into R11
    MUL             R10,R10,R11     // multiply 4 and R10 (3(row)+col)
    ADD             R1,R8,R10       // add R8, original value of b to 4(3(row)+k)
    LDR             R1,[R1]         // load the value into R1

                                    // c + 4(3(k)+col)
    LDR             R11,=3          // load constant 3 into R11
    MUL             R10,R6,R11      // multiply 3 and k and place 3(k) into R10
    ADD             R10,R10,R5      // add 3(k) and col, R5 and place it into R10
    LDR             R11,=4          // load constant 4 into R11
    MUL             R10,R10,R11     // multiply 4 and R10 (3(k)+col)
    ADD             R2,R9,R10       // add R9, original value of c to 4(3(k)+col)
    LDR             R2,[R2]         // load the value into R2

                                    // a + 4(3(row)+col)
    BL              MultAndAdd      // call MultAndAdd with a[row][call] in R0, b[row][k] in R1, c[k][col] in R2
    LDR             R11,=3          // load constant 3 into R11
    MUL             R10,R4,R11      // multiply 3 and row and place 3(row) into R10
    ADD             R10,R10,R5      // add 3(row) and col, R5 and place it into R10
    LDR             R11,=4          // load constant 4 into R11
    MUL             R10,R10,R11     // multiply 4 and R10 (3(row)+col)
    ADD             R1,R7,R10       // add R7, original value of a to 4(3(row)+col)
//  STR             R0,[R1,R10,LSL 2]
    STR             R0,[R1]         // *** store R0 from MultAndAdd into the de-referenced value of R1

    ADD             R6,R6,1         // increment k
    B               Inner           // loop back to Inner

MiddleInc:
    ADD             R5,R5,1         // increment col
    B               Middle          // loop back to Middle

OuterInc:
    ADD             R4,R4,1         // increment row
    B               Outer           // loop back to Outer

Done:
	POP				{R4-R11,PC}		// pop value that was pushed earlier

	.end
    