			.text
			.global _start

_start:
			LDR R4, =RESULT   // R4 points to the result location
			LDR R2, [R4, #4]  // R2 holds the number of elements in the list
			ADD R3, R4, #8    // R3 points to the first number
			LDR R0, [R3]      // R0 holds the first number in the list for max comparation
			LDR R5, [R3]	  // R5 holds the first number in the list for min comparation

MAXLOOP:	SUBS R2, R2, #1   // Decrement the loop counter
			BEQ STDDEV        // Jump to STDDEV loop if counter has reached 0
			ADD R3, R3, #4    // R3 points to the next number
			LDR R1, [R3]      // R1 holds the value next element in the list
			CMP R0, R1        // Check if next value is greater than the maximum
			BGE MINLOOP 	  // If no, go to MINLOOP 
			MOV R0, R1		  // If yes, update the current max to R0 

MINLOOP:	CMP R1, R5        // Check if the next number is greater than the min
			BGE MAXLOOP       // If yes branch back to the MAXLOOP 
			MOV R5, R1        // If no, update the current min to R5
			B MAXLOOP		  // Back to MAXLOOP

STDDEV: 	SUBS R0, R0, R5   // Substract max and min and store it in R0
			LSR R0, R0, #2    // Divide the value in RO by 4 fo standar deviation
			STR R0, [R4]	  // Store the standart deviation result to the memory location 

END:		B END 			  // Infinite loop 
	
RESULT: 	.word	0		  // Memory assigned for result location 
N: 			.word   4		  // Number of entries in the list 
NUMBERS: 	.word 	4, -6		// The list data 
			.word 	-3, 6		
