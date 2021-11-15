	.text
	
	.global A9_PRIV_TIM_ISR
	.global HPS_GPIO1_ISR
	.global HPS_TIM0_ISR
	.global HPS_TIM1_ISR
	.global HPS_TIM2_ISR
	.global HPS_TIM3_ISR
	.global FPGA_INTERVAL_TIM_ISR
	.global FPGA_PB_KEYS_ISR
	.global FPGA_Audio_ISR
	.global FPGA_PS2_ISR
	.global FPGA_JTAG_ISR
	.global FPGA_IrDA_ISR
	.global FPGA_JP1_ISR
	.global FPGA_JP2_ISR
	.global FPGA_PS2_DUAL_ISR
	
	.global HPS_TIM0_INT_FLAG
	.global HPS_TIM1_INT_FLAG
	.global HPS_TIM2_INT_FLAG
	.global HPS_TIM3_INT_FLAG
	.global PB_INT_FLAG

HPS_TIM0_INT_FLAG:
	.word 0x0

HPS_TIM1_INT_FLAG:
	.word 0x0

HPS_TIM2_INT_FLAG:
	.word 0x0

HPS_TIM3_INT_FLAG:
	.word 0x0

PB_INT_FLAG:
	.word 0x0

A9_PRIV_TIM_ISR:
	BX LR
	
HPS_GPIO1_ISR:
	BX LR
	
HPS_TIM0_ISR:
	
	PUSH {LR}							// Push LR to stack
	MOV R0, #0x1						// Set R0 to be 0001
	BL HPS_TIM_clear_INT_ASM			// Clear Timer0
	
	LDR R0, =HPS_TIM0_INT_FLAG			// Load the address of HPS_TIM0_INT_FLAG into R0
	MOV R1, #1							// Load a 1 into R1
	STR R1, [R0]						// Store R1 into RO
	POP {LR}							// POP LR from stack

	BX LR
	
HPS_TIM1_ISR:
	
	PUSH {LR}							// Push LR to stack
	MOV R0, #0x2						// Set R0 to be 00010
	BL HPS_TIM_clear_INT_ASM			// Clear Timer1
	
	LDR R0, =HPS_TIM1_INT_FLAG			// Load the address of HPS_TIM1_INT_FLAG into R0
	MOV R1, #1							// Load a 1 into R1
	STR R1, [R0]						// Store R1 into RO
	POP {LR}							// POP LR from stack

	BX LR
	
HPS_TIM2_ISR:
	
	PUSH {LR}							// Push LR to stack
	MOV R0, #0x4						// Set R0 to be 0100
	BL HPS_TIM_clear_INT_ASM			// Clear Timer2
	
	LDR R0, =HPS_TIM2_INT_FLAG			// Load the address of HPS_TIM2_INT_FLAG into R0
	MOV R1, #1							// Load a 1 into R1
	STR R1, [R0]						// Store R1 into RO
	POP {LR}							// POP LR from stack

	BX LR
	
HPS_TIM3_ISR:
	PUSH {LR}							// Push LR to stack
	MOV R0, #0x8						// Set R0 to be 1000
	BL HPS_TIM_clear_INT_ASM			// Clear Timer3
	
	LDR R0, =HPS_TIM3_INT_FLAG			// Load the address of HPS_TIM3_INT_FLAG into R0
	MOV R1, #1							// Load a 1 into R1
	STR R1, [R0]						// Store R1 into RO
	POP {LR}							// POP LR from stack

	BX LR
	
FPGA_INTERVAL_TIM_ISR:
	BX LR
	
FPGA_PB_KEYS_ISR:
	PUSH {LR}							// Push LR to stack

	BL read_PB_edgecap_ASM				// Read the button that has been pushed
	LDR R1, =PB_INT_FLAG				// Load address of PB_INT_FLAG into R1

	STR R0, [R1]						// Store the value in R1 into R0
	
	BL PB_clear_edgecap_ASM				// Clear edgecap to reset the interrupt
	
	POP {LR}							// POP LR from stack
	BX LR
	
FPGA_Audio_ISR:
	BX LR
	
FPGA_PS2_ISR:
	BX LR
	
FPGA_JTAG_ISR:
	BX LR
	
FPGA_IrDA_ISR:
	BX LR
	
FPGA_JP1_ISR:
	BX LR
	
FPGA_JP2_ISR:
	BX LR
	
FPGA_PS2_DUAL_ISR:
	BX LR
	
	.end
