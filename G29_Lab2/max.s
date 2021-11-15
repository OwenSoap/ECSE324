			.text
			.global _start

_start:
			LDR R4, =RESULT			// R4 points to the result lication
			LDR R2, [R4, #4]  		// R2 holds the number of elements in the list
			ADD R3, R4, #8			// R3 points to the first number
			LDR R0, [R3]			// R0 holds the first number in the list
			PUSH {R4,LR} 			// PUSH R4, LR into stack
			BL MAX					// Call subroutine MAX for finding max
			POP {R4,LR}				// POP R4, LR out of stack
			STR R0, [R4]			// Store the largest number result into R4
			B END

MAX:
			SUBS R2, R2, #1			// Decrement the loop counter
			BXEQ LR					// If the counter reaches 0 back to main class
			ADD R3, R3, #4			// R3 points the next number in the list
		    LDR R1, [R3]			// R1 holds the value of next element
			CMP R0, R1				// Compare the result and R1
		    BGE MAX  				// If the result is greater then back to MAX 
			MOV R0, R1				// If R1 is greater then swap R0 R1
			B MAX					// Back to the loop

END:		B END					// Infinite loop

RESULT:		.word 0
N:			.word 8
NUMBERS:    .word 4, 20, -3, 6
			.word 1, 85, 2, 5	
