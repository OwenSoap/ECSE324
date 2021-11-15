			.text
			.global _start

_start:
			LDR R0, =N  	  // R0 points to the size of the array location
			ADD R1, R0, #4    // R1 point to the first number
			ADD R2, R0, #4	  // R2 point to the first number
			LDR R3, [R1]      // R3 holds the sum of the array
			LDR R4, [R0]	  // R4 holds the number of the array as the first counter
			LDR R5, [R0]      // R5 holds the number of the array as the second counter 
			LDR R6, [R0]	  // R6 holds the number of the array as the third cpunter
			ADD R6, R6, #1    // Let the R6 to be 1 larger than the length of the array to visit all elements 
			
SUMLOOP:	SUBS R4, R4, #1   // Decrement the loop counter in order to stop when the array is empty 
			BEQ AVGLOOP       // Jump to average computing if counter reaches zero(sum finished) 
			ADD R1, R1, #4    // R1 point to the next number
			LDR R7, [R1]      // R7 holds the value of next element in the list
			ADD R3, R3, R7	  // Add each number into the R3 which holds the sum
			B SUMLOOP 		  // Keep summing 

AVGLOOP:	LSR R5, #1        // Divide the length of the array by two
			CMP R4, R5	      // Compare the size of R5 with the size of R4 (which is zero)
			BGE FINLOOP       // If R4 greater or equalto R5 jump to FINLLOP for centering
			ASR R3, #1        // Divide the sum of the array by two
			B AVGLOOP         // Keep calculating average

FINLOOP:	SUBS R6, R6, #1   // Decrement the third loop counter in order to stop when the array is empty 
			BEQ  END		  // If counter reaches zero jump to the end
			LDR  R7, [R2]     // R7 holds the value next element in the list
			SUB	 R7, R7, R3   // Subtracr each element by the average
			STR  R7, [R2]     // Store the result value of each element in memory
			ADD  R2, R2, #4   // R2 points to next element
			B FINLOOP         // Keep Calculating the difference

END:		B END 				// Infinite loop 
	
N: 			.word   8			// Length of the array 
NUMBERS: 	.word 	2, 4, 6, 8, 1, 15, 5, 7		// The list data 
	
