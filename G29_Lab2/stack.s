		.text
		.global _start

_start:
			LDR R0, =N
			LDR R1,[R0, #4]		// Load the first value into R1
			LDR R2,[R0, #8]		// Load the second value into R2
			LDR R3,[R0, #12]	// Load the third value into R3

PUSH:		STR R3, [SP, #-4]!	// PUSH the R3
			STR R2, [SP, #-4]!	// PUSH the R2
			STR R1, [SP, #-4]!	// PUSH the R1

POP: 		LDR R4, [SP], #4	// POP the value from top of the stack into R4
			LDR R4, [SP], #4	// POP the value from top of the stack into R4
			LDR R4, [SP], #4	// POP the value from top of the stack into R4

END:		B END				// Infinite loop

N: 			.word   3			// Number of elements in the list 
NUMBERS: 	.word 	4, 5, -3	// The list of data 
