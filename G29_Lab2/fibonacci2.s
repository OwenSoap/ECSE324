			.text                           
          	.global _start
_start:
            LDR  	R0, N			// Load the vlaue of input into R0 
            PUSH 	{R4,LR}        	// PUSH R4 and LR into the stack
            BL   	FIB             // Call FIB subroutine
            POP  	{R4,LR}         // POP R4 and LR from stack
            STR  	R0, [R4]        // Store the final resulr into R4
            B    	END             

FIB:        CMP  	R0, #1         	// If the input value is greater than 1 
            BGT  	REC            	// Then call recursion subroutine
            MOV  	R0, #1         	// Otherwise make the result to be 1
			BX      LR              // Return to the main method

REC:        MOV  	R1, R0         	// Put the input value into R1 used as counter 
            SUB  	R0, R1, #1      // Decrease R1 by one and load it in R0 so R0 will be n-1
            PUSH 	{R1,LR}      	// PUSH R1 and LR into stack
            BL   	FIB             // Back to FIB to check whether the R0 reaches 1
            POP  	{R1,LR}      	// POP R1 and LR from stack
            MOV  	R2, R0          // Move the value of R0 to R2 and let R2 to be n-1
            SUB  	R0, R1, #2      // Make R0 to be n-2
            PUSH 	{R1,R2,LR}      // PUSH R1 R2 and LR into stack
            BL   	FIB             // Back to FIB to check whether R0 reaches 1
            POP  	{R1,R2,LR}      // POP R1 R2 and LR from stack
            ADD  	R0, R0, R2      // Adding value of n-2 and n-1 and store the result in R0
			BX		LR

END:        B		END

N:          .word 5
