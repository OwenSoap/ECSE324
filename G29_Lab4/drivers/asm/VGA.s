	.text
	.equ PIX_buffer_BASE, 0xC8000000
	.equ CHAR_buffer_BASE, 0xC9000000
	.global VGA_clear_charbuff_ASM
	.global VGA_clear_pixelbuff_ASM
	.global VGA_write_char_ASM
	.global VGA_write_byte_ASM
	.global VGA_draw_point_ASM

VGA_clear_charbuff_ASM:
		
		MOV R0, #80    				// X counter
		MOV R1, #59	   				// Y counter 
		LDR R2, =CHAR_buffer_BASE 	// Let R2 point to BASE Address
		MOV R3, #0					// Use R3 as 0 to clear

CHAR_CLEAR_X:
		
		SUB R0, R0, #1				// Decrease X counter
		CMP R0, #0					// Compare X counter with 0
		BLT END_CLEAR_CHAR			// If X less than 0 move to end
		MOV R1, #59 				// Reset Y when each time starts new X

CHAR_CLEAR_Y:

		CMP R1, #0					// Compare Y counter with 0
		BLT CHAR_CLEAR_X			// If Y less than 0 move to X decreasment
		
		MOV R4, R1					// Get Y counter
		LSL R4, #7					// Shift 7 bits to get Y0000000 for buffer address
		ORR R4, R4, R2				// Add Y position in base address
		ORR R4, R4, R0				// Add X position in base address
			
		STRB R3, [R4]				// Store 0 in byte format dor char in the location we want to clear
		SUB R1, R1, #1				// Decrease Y counter	
		B CHAR_CLEAR_Y				// Back to check next Y counter

END_CLEAR_CHAR:

		BX LR						// Return 

VGA_clear_pixelbuff_ASM:
		
		MOV R0, #300    			// X counter
		ADD R0, R0, #20				// Add 20 since it cannot handle more than 300
		MOV R1, #239	   			// Y counter 
		LDR R2, =PIX_buffer_BASE 	// Let R2 point to the base Address
		MOV R3, #0					// Use R3 as 0 to clear

PIX_CLEAR_X:
		
		SUB R0, R0, #1				// Decrease X counter
		CMP R0, #0					// Compare X counter with 0
		BLT END_CLEAR_PIX			// If X is less than 0 then return
		MOV R1, #239 				// Reset Y	

PIX_CLEAR_Y:

		CMP R1, #0					// Compare Y counter with 0
		BLT PIX_CLEAR_X				// If Y less than 0 move to X decreasment
		
		MOV R4, R1					// Get Y counter
		LSL R4, #10					// Shift 10 bits to get Y0000000000 for buffer address
		ORR R4, R4, R2				// Add Y position in base address

		MOV R5, R0					// Take the X position
		LSL R5, #1					// Shift 1 bit to get X0
		ORR R4, R4, R5				// Add X position in base address
			
		STRH R3, [R4]				// Store 0 in half word format in the location we want to clear
		SUB R1, R1, #1				// Decrease Y counter	
		B PIX_CLEAR_Y				// Return to clear Y

END_CLEAR_PIX:

		BX LR						// Return

VGA_write_char_ASM:
			
		LDR R3, =CHAR_buffer_BASE	// Let R3 point to the CHAR_buffer_BASE address

		CMP R0, #79					// Check Whether X is in the range
		BGT END_WRITE_CHAR			// If not then return
		CMP R0, #0					// Check Whether X is in the range
		BLT END_WRITE_CHAR			// If not then return
		CMP R1, #59					// Check Whether Y is in the range
		BGT END_WRITE_CHAR			// If not then return
		CMP R1, #0					// Check Whether Y is in the range
		BLT END_WRITE_CHAR			// If not then return

		MOV R4, R1					// Take the Y position in R4
		LSL R4, #7					// Shift 7 bits to get Y0000000 for buffer address
		ORR R4, R4, R3				// Add Y position in base address
		ORR R4, R4, R0				// Add X position in base address
	
		STRB R2, [R4]				// Write the character we want

END_WRITE_CHAR:

		BX LR						// Return

VGA_write_byte_ASM:
		
		LDR R3, =CHAR_buffer_BASE	// Let R3 point to the CHAR_buffer_BASE address
		
		CMP R0, #79					// Check Whether X is in the range
		BGT END_WRITE_BYTE			// If not then return
		CMP R0, #0					// Check Whether X is in the range
		BLT END_WRITE_BYTE			// If not then return
		CMP R1, #59					// Check Whether Y is in the range
		BGT END_WRITE_BYTE			// If not then return
		CMP R1, #0					// Check Whether Y is in the range
		BLT END_WRITE_BYTE			// If not then return

		MOV R4, R2					// Take the input char into R4
		LSR R4, #4					// Remove rightmost 4 bits for comparison
		CMP R4, #10					// Check whether the digit is a letter or number
		ADDGE R4, R4, #55			// If it is a letter then assign a correct one with ASCII table
		ADDLT R4, R4, #48			// If it is a number then assign a correct one with ASCII table
		
		MOV R5, R1					// Take the Y position into R5
		LSL R5, #7					// Shift 7 bits to get Y0000000 for buffer address
		ORR R5, R5, R3				// Add Y position in base address
		ORR R5, R5, R0 				// Add X position in base address
		STRB R4, [R5]				// Write the byte into the address we want

		ADD R0, R0, #1				// Move x to write 1
		CMP R0, #79					// Check whether X position has reched right side
		MOVGT R0, #0				// If yes then move back to the left side
		ADDGT R1, #1				// And increase Y by 1
		CMP R1, #59					// Check Whether Y reaches the bottom
		MOVGT R1, #0				// If yes then move Y back to the top
									
		AND R2, #0xF				// Keep the last four bits of the input
		CMP R2, #10					// Check whether the digit is a letter or number
		ADDGE R2, R2, #55			// If it is a letter then assign a correct one with ASCII table
		ADDLT R2, R2, #48			// If it is a number then assign a correct one with ASCII table
		MOV R5, R1					// Take the Y position into R5
		LSL R5, #7					// Shift 7 bits to get Y0000000 for buffer address
		ORR R5, R5, R3				// Add Y position in base address
		ORR R5, R5, R0 				// Add X position in base address
		STRB R2, [R5]				// Write the byte into the address we want

END_WRITE_BYTE:

		BX LR						// Return

VGA_draw_point_ASM:

		LDR R3, =PIX_buffer_BASE	// Let R3 point to the PIX_buffer_BASE address
	
		MOV R4, #300 				// X counter
		ADD R4, R4, #19				// Add 19 since it cannot handle more than 300
		CMP R0, R4					// Check whether X is in the range
		BGT END_DRAW_POINT			// If not then return
		CMP R0, #0 					// Check whether X is in the range
		BLT END_DRAW_POINT			// If not then return
		CMP R1, #239				// Check whether Y is in the range
		BGT END_DRAW_POINT			// If not then return
		CMP R1, #0					// Check whether Y is in the range
		BLT END_DRAW_POINT			// If not then return

		MOV R5, R1					// Take the Y position into R5
		LSL R5, #10					// Shift 10 bits to get Y0000000000 for buffer address
		ORR R5, R5, R3				// Add Y position in base address
		MOV R6, R0 					// Take the X position into R6
		LSL R6, #1					// Shift 1 bit to get X0
		ORR R5, R5, R6 				// Add X position in base address
		STRH R2, [R5]				// Write the color in half word fromat into the address we want

END_DRAW_POINT:

		BX LR						// Back to main class
	.end
