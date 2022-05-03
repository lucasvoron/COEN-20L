	.syntax			unified
	.cpu			cortex-m4
	.text


/* uint32_t ReverseBits(uint32_t word) ; */
	.global			ReverseBits
	.thumb_func
	.align
ReverseBits:
    .rept           32
    LSLS            R0,R0,1         // shift left and put the most significant bit into carry
    RRX             R1,R1           // add carry to the right of R1
    .endr

    MOV             R0,R1           // move R1, that holds reverse, back into R0
    BX              LR

/* uint32_t ReverseBytes(uint32_t word) ; */
	.global			ReverseBytes
	.thumb_func
	.align
ReverseBytes:
    UBFX            R1,R0,0,8       // get the least significant byte starting at bit 0
    BFI             R2,R1,24,8      // insert the first byte starting at position 24
    UBFX            R1,R0,8,8       // get the second byte starting at bit 8
    BFI             R2,R1,16,8      // insert the second byte starting at position 16
    UBFX            R1,R0,16,8      // get the third byte starting at bit 16
    BFI             R2,R1,8,8       // insert the third byte starting at positon 8
    UBFX            R1,R0,24,8      // get the fourth byte starting at bit 24
    BFI             R2,R1,0,8       // insert the fourth byte starting at position 0
    MOV             R0,R2           // move the reversed bytes in R2 into R0
    BX              LR

	.end
