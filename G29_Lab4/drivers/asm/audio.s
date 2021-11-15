	.text
	.equ FIFOSPACE_BASE, 0xFF203044
	.equ LEFTDATA_BASE, 0xFF203048
	.equ RIGHTDATA_BASE, 0xFF20304C
	.global audio_ASM

audio_ASM:

		LDR R1, =FIFOSPACE_BASE		// Let R1 point to the address of FIFOSPACE_BASE
		LDR R2, [R1]				// Load the value in R1 into R2

		AND R3, R2, #0xFF000000		// Load only the WSLC value
		CMP R3, #0					// Compare the WSLC value with 0
		MOVEQ R0, #0				// If it is 0 then return 0 to show invalid
		BEQ END_AUDIO				// Return

		AND R4, R2, #0x00FF0000		// Load only the WSRC value
		CMP R4, #0					// Compare the WSRC value with 0
		MOVEQ R0, #0				// If it is 0 then return 0 to show invalid
		BEQ END_AUDIO				// Return

		LDR R5, =LEFTDATA_BASE		// Let R5 point to the address of LEFTDATA_BASE
		LDR R6, =RIGHTDATA_BASE		// Let R6 point to the address of RIGHTDATA_BASE
			
		STR R0, [R5]				// Store R0 in to LEFTDATA_BASE address
		STR R0, [R6]				// Store R0 in to RIGHTDATA_BASE address
		MOV R0, #1					// Return one to show ths value is valid

END_AUDIO:		
		BX LR						// Return
	.end