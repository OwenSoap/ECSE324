.text
			.equ HEX0TO3_BASE, 0xFF200020
			.equ HEX4TO5_BASE, 0xFF200030
			.global HEX_clear_ASM, HEX_flood_ASM, HEX_write_ASM

HEX_clear_ASM:
			LDR	R2, =HEX0TO3_BASE		// Load the memory address of HEX0-3 in R2
			LDR R3, =HEX4TO5_BASE		// Load the memory address of HEX4-5 in R3
			LDR R4, [R2]				// Load the content into R4
			LDR R5, [R3]				// Load the content into R4
					
CLEAR0:		TST R0, #1					// Check the input whther includes HEX0
			BEQ CLEAR1					// If not jump to CLEAR1
			AND R4, R4, #0xFFFFFF00		// If yes the clear HEX0

CLEAR1:  	LSR R0, #1					// Check the input		
			TST R0, #1					// whether includes HEX1
			BEQ CLEAR2					// If not jump to CLEAR2
			AND R4, R4, #0xFFFF00FF		// If yes the clear HEX1

CLEAR2:  	LSR R0, #1					// Check the input				
			TST R0, #1					// whether includes HEX2
			BEQ CLEAR3					// If not jump to CLEAR3
			AND R4, R4, #0xFF00FFFF		// If yes the clear HEX2

CLEAR3:  	LSR R0, #1					// Check the input			
			TST R0, #1					// whether includes HEX3
			BEQ CLEAR4					// If not jump to CLEAR4
			AND R4, R4, #0x00FFFFFF		// If yes the clear HEX3

CLEAR4:  	LSR R0, #1					// Check the input			
			TST R0, #1					// whether includes HEX4
			BEQ CLEAR5					// If not jump to CLEAR5
			AND R5, R5, #0xFFFFFF00		// If yes the clear HEX4

CLEAR5:  	LSR R0, #1					// Check the input
			TST R0, #1					// whether includes HEX5
			BEQ CLEAR6					// If not jump to CLEAR6
			AND R5, R5, #0xFFFF00FF		// If yes the clear HEX5

CLEAR6:  	STR R4, [R2]				// Store R4 into memory
			STR R5, [R3]				// Store R5 into memory
			B END

HEX_flood_ASM:
			LDR	R2, =HEX0TO3_BASE		// Load the memory address of HEX0-3 in R2
			LDR R3, =HEX4TO5_BASE		// Load the memory address of HEX4-5 in R3
			LDR R4, [R2]				// Load the content into R4
			LDR R5, [R3]				// Load the content into R4
			
FLOOD0:		TST R0, #1					// Check the input whether includes HEX0
			BEQ FLOOD1					// If not jump to FLOOD1
			ORR	R4, R4, #0x000000FF     // Update the HEX0 value to be full display
	
FLOOD1:		LSR	R0, #1					// Check the input
			TST R0, #1					// whether includes HEX1
			BEQ FLOOD2					// If not jump to FLOOD
			ORR	R4, R4, #0x0000FF00		// Update the HEX1 value to be full display
	
FLOOD2:		LSR	R0, #1					// Check the input
			TST R0, #1					// whether includes HEX2
			BEQ FLOOD3					// If not jump to FLOOD3
			ORR	R4, R4, #0x00FF0000		// Update the HEX2 value to be full display
		
FLOOD3:		LSR	R0, #1					// Check the input
			TST R0, #1					// whether includes HEX3
			BEQ FLOOD4					// If not jump to FLOOD4
			ORR	R4, R4, #0xFF000000		// Update the HEX3 value to be full display
		
FLOOD4:		LSR	R0, #1					// Check the input
			TST R0, #1					// whether includes HEX4
			BEQ FLOOD5					// If not jump to FLOOD5
			ORR	R5, R5, #0x000000FF		// Update the HEX4 value to be full display

FLOOD5:		LSR	R0, #1					// Check the input
			TST R0, #1					// whether includes HEX5
			BEQ FLOOD6					// If not jump to FLOOD6
			ORR	R5, R5, #0x0000FF00		// Update the HEX5 value to be full display

FLOOD6:		STR R4, [R2]				// Store R4 into memory
			STR R5, [R3]				// Store R5 into memory
			B END

HEX_write_ASM:
CHECKO:		CMP R1, #0					// Check the input value
			BGT CHECK1					// If it's not 0 jump to CHECK1
			MOV R1, #63					// Set 7-segments to display 0
			B	ST_WRITE

CHECK1:		CMP R1, #1					// Check the input value
			BGT CHECK2					// If it's not 1 jump to CHECK2
			MOV R1, #6					// Set 7-segments to display 1
			B	ST_WRITE

CHECK2:		CMP R1, #2					// Check the input value
			BGT CHECK3					// If it's not 2 jump to CHECK3
			MOV R1, #91					// Set 7-segments to display 2
			B	ST_WRITE

CHECK3:		CMP R1, #3					// Check the input value
			BGT CHECK4					// If it's not 3 jump to CHECK4
			MOV R1, #79					// Set 7-segments to display 3
			B	ST_WRITE

CHECK4:		CMP R1, #4					// Check the input value
			BGT CHECK5					// If it's not 4 jump to CHECK5
			MOV R1, #102				// Set 7-segments to display 4
			B	ST_WRITE	

CHECK5:		CMP R1, #5					// Check the input value
			BGT CHECK6					// If it's not 5 jump to CHECK6
			MOV R1, #109				// Set 7-segments to display 5
			B	ST_WRITE

CHECK6:		CMP R1, #6					// Check the input value
			BGT CHECK7					// If it's not 6 jump to CHECK7
			MOV R1, #125				// Set 7-segments to display 6
			B	ST_WRITE

CHECK7:		CMP R1, #7					// Check the input value
			BGT CHECK8					// If it's not 7 jump to CHECK8
			MOV R1, #7					// Set 7-segments to display 7
			B	ST_WRITE

CHECK8:		CMP R1, #8					// Check the input value
			BGT CHECK9					// If it's not 8 jump to CHECK9
			MOV R1, #127				// Set 7-segments to display 8
			B	ST_WRITE

CHECK9:		CMP R1, #9					// Check the input value
			BGT CHECK10					// If it's not 9 jump to CHECK10
			MOV R1, #111				// Set 7-segments to display 9
			B	ST_WRITE

CHECK10:	CMP R1, #10					// Check the input value
			BGT CHECK11					// If it's not 10 jump to CHECK11
			MOV R1, #119				// Set 7-segments to display 10
			B	ST_WRITE

CHECK11:	CMP R1, #11					// Check the input value
			BGT CHECK12					// If it's not 11 jump to CHECK12
			MOV R1, #127				// Set 7-segments to display 11
			B	ST_WRITE

CHECK12:	CMP R1, #12					// Check the input value
			BGT CHECK13					// If it's not 12 jump to CHECK13
			MOV R1, #57					// Set 7-segments to display 12
			B	ST_WRITE

CHECK13:	CMP R1, #13					// Check the input value
			BGT CHECK14					// If it's not 13 jump to CHECK14
			MOV R1, #63					// Set 7-segments to display 13
			B	ST_WRITE

CHECK14:	CMP R1, #14					// Check the input value
			BGT CHECK15					// If it's not 14 jump to CHECK15
			MOV R1, #121				// Set 7-segments to display 14
			B	ST_WRITE

CHECK15:	MOV R1, #113				// Set 7-segments to display 15

ST_WRITE:	LDR	R3, =HEX0TO3_BASE		// Load the memory address of HEX0-3 in R3
			LDR R4, =HEX4TO5_BASE		// Load the memory address of HEX4-5 in R4
			LDR R7, [R3]				// Load the content into R7
			LDR R8, [R4]				// Load the content into R8
			MOV R5, R1					// Move the value in R1 into R5 for HEX4-5 display
			
WRITE0:		TST R0, #1					// Check the input whether inludes HEX0
			BEQ	WRITE1					// If not jump to WRITE1
			AND R7, R7, #0xFFFFFF00		// Clear the display first
			ORR R7, R7, R1				// Write the display with corresponding number

WRITE1:		LSR R0, #1					// Shift to next input
			LSL	R1, #8					// Shift the number to next display
			TST R0, #1					// Check the input whether inludes HEX1
			BEQ	WRITE2					// If not jump to WRITE2
			AND R7, R7, #0xFFFF00FF		// Clear the display first
			ORR R7, R7, R1				// Write the display with corresponding number

WRITE2:		LSR R0, #1					// Shift to next input
			LSL	R1, #8					// Shift the number to next display
			TST R0, #1					// Check the input whether inludes HEX2
			BEQ	WRITE3					// If not jump to WRITE3
			AND R7, R7, #0xFF00FFFF		// Clear the display first
			ORR R7, R7, R1				// Write the display with corresponding number

WRITE3:		LSR R0, #1					// Shift to next input
			LSL	R1, #8					// Shift the number to next display
			TST R0, #1					// Check the input whether inludes HEX3
			BEQ	WRITE4					// If not jump to WRITE4
			AND R7, R7, #0x00FFFFFF		// Clear the display first
			ORR R7, R7, R1				// Write the display with corresponding number

WRITE4:		LSR R0, #1					// Shift to next input
			TST R0, #1					// Check the input whether inludes HEX4
			BEQ	WRITE5					// If not jump to WRITE5
			AND R8, R8, #0xFFFFFF00		// Clear the display first
			ORR R8, R8, R5				// Write the display with corresponding number

WRITE5:		LSR R0, #1					// Shift to next input
			LSL	R5, #8					// Shift the number to next display
			TST R0, #1					// Check the input whether inludes HEX5
			BEQ	WRITE6					// If not jump to WRITE6
			AND R8, R8, #0xFFFF00FF		// Clear the display first
			ORR R8, R8, R5				// Write the display with corresponding number

WRITE6:		STR R7, [R3]				// Store R7 into memory
			STR R8, [R4]				// Store R8 into memory
			B END							

END:
			BX LR						// Return to main
			.end
