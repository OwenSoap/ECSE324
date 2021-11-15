			.text
			.equ PUSH_DATA, 0xFF200050
			.equ PUSH_MASK, 0xFF200058
			.equ PUSH_EDGE, 0xFF20005C
			.global read_PB_data_ASM
			.global PB_data_is_pressed_ASM
			.global read_PB_edgecap_ASM
			.global PB_edgecap_is_pressed_ASM
			.global PB_clear_edgecap_ASM
			.global enable_PB_INT_ASM
			.global disable_PB_INT_ASM


read_PB_data_ASM:					
			
			LDR R1, =PUSH_DATA		// Load the memory address of PUSH_DATA into R1
			LDR R0, [R1]			// Get the content stored in the memory address and put it into R0
			BX LR					

PB_data_is_pressed_ASM:			
	
			LDR R1, =PUSH_DATA		// Load the memory address of PUSH_DATA into R1
			LDR R1, [R1]			// Get the content stored in the memory address and put it into R1
			AND R0, R1, R0			// Check wehther the input stream matches the string in memory
			BX LR 					

read_PB_edgecap_ASM:				
	
			LDR R0, =PUSH_EDGE		// Load the memory address of PUSH_edge into R0
			LDR R0, [R0]			// Get the content stored in the memory address and put it into R0	
			BX LR 	

PB_edgecap_is_pressed_ASM:		

			LDR R1, =PUSH_EDGE		// Load the memory address of PUSH_DATA into R1
			LDR R1, [R1]			// Get the content stored oin the memory address and put it into R1
			AND R0, R1, R0			// Check wehther the input string matches the string in memory
			BX LR 				

PB_clear_edgecap_ASM:			
									
			LDR R1, =PUSH_EDGE		// Load the memory address of PUSH_EDGE into R1
			STR R0, [R1]			// Store the content of input variable into R0
			BX LR 					

enable_PB_INT_ASM:		

			LDR R1, =PUSH_MASK		// Load the memory address of PUSH_MASK into R1
			STR R0, [R1]			// Store the content of input variable into R0
			BX LR 					

disable_PB_INT_ASM:			

			LDR R1, =PUSH_MASK		// Load the memory address of PUSH_MASK into R1
			MVN R0, R0				// Invert the imput string
			STR R0, [R1]			// Store the content of input variable into R0
			BX LR 				

.end
