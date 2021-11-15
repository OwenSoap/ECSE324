	.text
	.equ PS2_Data_BASE, 0xFF200100
	.global read_PS2_data_ASM

read_PS2_data_ASM:
		
		LDR R1, =PS2_Data_BASE		// Let R1 point to the address of PS2_Data_BASE
		LDR R2, [R1]				// Load the value at the address into R2
		AND R3, R2, #32768			// Get the value only at the RVALID bit move it into R3
		CMP R3, #0					// Compare R3 with 0
		BEQ INVALID					// If R3 is 0 then return invalid
		
		AND R2, R2, #0xFF			// Otherwise get the last byte in this address
		STRB R2, [R0]				// Store it as byte format into char pointer
		MOV R0, #1					// Return 1 to show it is valid
		BX LR						// Return

INVALID: 
		MOV R0, #0					// Return 0 to show it is invalid
		BX LR						// Return
	.end
 