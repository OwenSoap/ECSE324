			.text
			.global _start

_start:
			LDR R0, =N  	// R0 points to N as the size of the array
			MOV R1, #0 		// R1 stored as boolean variable: sorted, initialized as 0 which means not sorted
			LDR R2, [R0]	// R2 holds the number of the array as a counter
			CMP R2, #2      // Compare size and 2 to check if there is more than 2 elements
			BGE WHILOOP		// Return to while loop if there is more than 2 elements
			B END			// If only one element then sorted finished 

WHILOOP:	CMP R1, #1   	// Check if boolean variable is sorted (while(!Sorted))
			BEQ END			// If sorted then finished
			MOV R3, #1      // R3 holds as counter and set it to be 1 since we maximun need N-1 swaps
			ADD R4, R0, #4	// Let R4 to point to the first element in the array
			ADD R5, R0, #8	// Let R5 to point to the second element in the array
			MOV R1, #1		// Set boolean variable R1 o be sorted

FORLOOP:	CMP R3, R2		// Check current number and the number of the array 
			BEQ WHILOOP		// Back to while loop if checked completed
			ADD R3, #1      // Counter++ 
			LDR R6, [R4]	// Set new register R6 to store R4 in case of swapping  
			LDR R7, [R5]	// Set new register R7 to store R5 in case of swapping  
			CMP R7, R6		// Compare two values 
			BGT IFSTATE		// If R7 is larger then skip swapping
			STR R6, [R5]    // Swap two elements and store them in the memory
			STR R7, [R4]
			ADD R4, R4, #4	// Point R4 to next element
			ADD R5, R5, #4	// Point R5 to next element
			MOV R1, #0		// Set boolean variable R1 to be not sorted
			B FORLOOP		// Keep sorting

IFSTATE:	STR R6, [R4]	// Store two variables in order
			STR R7, [R5]	 
			ADD R4, R4, #4	// Point R4 to next element
			ADD R5, R5, #4	// Point R5 to next element
			B FORLOOP		// Return to FORLOOP and keep sorting

END:		B END 			// Infinite loop 
	
N: 			.word   10			// Number of entries in the list 
NUMBERS: 	.word 	4, 5, -3, 9, 6		// The list data 
			.word 	-1, 8, -2, 10, 7	
