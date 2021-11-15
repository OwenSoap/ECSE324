#include <stdio.h>
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/ISRs.h"

int main(){

// Slider Switches
/*
	while(1){
		write_LEDs_ASM(read_slider_switches_ASM());
	}

*/
// Basic I/O
/*
	
	//HEX_flood_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);
	//HEX_clear_ASM(HEX0 | HEX1 | HEX2 |HEX3 | HEX4| HEX5);
	//HEX_write_ASM(HEX0 | HEX1 | HEX2 |HEX3 | HEX4| HEX5,15);

	while(1){
			
			// Read the value input by slide switches
			int n = read_slider_switches_ASM();
			write_LEDs_ASM(n);
			
			// If no slide switches is on then only flood HEX4 and HEX5
			if (n == 0) {
				HEX_flood_ASM(HEX4 | HEX5);
			}
		
			// If the leftmost slide switch is on then clear everything
			if (n >= 512) {
				HEX_clear_ASM( HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5 );
			
			// If the input value is less than 16 then display the value depends on the button pushed
			}else if (n < 16){
				HEX_flood_ASM(HEX4 | HEX5);
				if ( PB_data_is_pressed_ASM(PB0) ) {
					HEX_clear_ASM( HEX0 | HEX1 | HEX2 | HEX3 );
					HEX_write_ASM(HEX0, n);
				}
				if ( PB_data_is_pressed_ASM(PB1) ) {
					HEX_clear_ASM( HEX0 | HEX1 | HEX2 | HEX3 );
					HEX_write_ASM(HEX1, n);
				}
				if ( PB_data_is_pressed_ASM(PB2) ) {
					HEX_clear_ASM( HEX0 | HEX1 | HEX2 | HEX3 );
					HEX_write_ASM(HEX2, n);
				}
				if ( PB_data_is_pressed_ASM(PB3) ) {
					HEX_clear_ASM( HEX0 | HEX1 | HEX2 | HEX3 );
					HEX_write_ASM(HEX3, n);
				}
			
			// Else if the value is too large then display nothing except flooding HEX4 and HEX5
			}else{
				HEX_flood_ASM(HEX4 | HEX5);
				HEX_clear_ASM( HEX0 | HEX1 | HEX2 | HEX3 );
			}
			
		}

*/
// Timer
/*

		int count0 = 0, count1 = 0, count2 = 0,count3 = 0;

		HPS_TIM_config_t hps_tim;

		hps_tim.tim = TIM0|TIM1|TIM2|TIM3;
		hps_tim.timeout = 1000000;
		hps_tim.LD_en = 1;
		hps_tim.INT_en = 1;
		hps_tim.enable = 1;
	
		HPS_TIM_config_ASM(&hps_tim);
	
		while(1) {
			if (HPS_TIM_read_INT_ASM(TIM0)) {
				HPS_TIM_clear_INT_ASM(TIM0);
				if(++count0 == 16) 
					count0 = 0;
				HEX_write_ASM(HEX0, count0);
			}
			if (HPS_TIM_read_INT_ASM(TIM1)) {
				HPS_TIM_clear_INT_ASM(TIM1);
				if(++ count1 == 16)
					count1 = 0;
				HEX_write_ASM(HEX1, count1);
			}
			if (HPS_TIM_read_INT_ASM(TIM2)) {
				HPS_TIM_clear_INT_ASM(TIM2);
				if(++count2 ==16)
					count2 = 0;
				HEX_write_ASM(HEX2, count2);
			}

			if (HPS_TIM_read_INT_ASM(TIM3)) {
				HPS_TIM_clear_INT_ASM(TIM3);
				if(++count3==16)
					count3 = 0;
				HEX_write_ASM(HEX3, count3);
			}
		}


*/
// Stopwatch
/*
	// Initialize all parameters
	int ms = 0;
	int s = 0;
	int min = 0;
	int enable = 1;

	// Setup the timer configuration that for digital display
	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0;
	hps_tim.timeout = 1000;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;
	HPS_TIM_config_ASM(&hps_tim);

	// Setup the timer configuration that for push buttom
	HPS_TIM_config_t hps_tim_pb;
	hps_tim_pb.tim = TIM1;
	hps_tim_pb.timeout = 5000;
	hps_tim_pb.LD_en = 1;
	hps_tim_pb.INT_en = 1;
	hps_tim_pb.enable = 1;
	HPS_TIM_config_ASM(&hps_tim_pb);

	while(1) {
		// Start the timer if there is a input and the timer is enable
		if (HPS_TIM_read_INT_ASM(TIM0) && enable) {
			HPS_TIM_clear_INT_ASM(TIM0);		
			ms += 1; 	// Increcement 1ms each time
			// If millisecond reaches 1000 then increase the second
			if (ms == 1000) {
				ms = 0;
				s++;
			}
			// If second reaches 60 then increase the minute
			if (s == 60) {
				s = 0;
				min++;
			}
			// If minute reaches 60 then set everything to be zero
			if (min == 60) {
				min = 0;
				s = 0;
				ms = 0;
			}
			HEX_write_ASM(HEX0, ((ms % 100) / 10));	// HEX0 displays 10 ms
			HEX_write_ASM(HEX1, (ms / 100));  		// HEX1 displays  100ms
			HEX_write_ASM(HEX2, (s % 10));			// HEX2 displays  1s
			HEX_write_ASM(HEX3, (s / 10));			// HEX3 displays  10s
			HEX_write_ASM(HEX4, (min % 10));		// HEX4 displays  1min
			HEX_write_ASM(HEX5, (min / 10));		// HEX5 displays  10min
		}

		// Start the stop timer
		if (HPS_TIM_read_INT_ASM(TIM1)) {
			HPS_TIM_clear_INT_ASM(TIM1);		
			if (PB_data_is_pressed_ASM(PB0) && (!enable)) { 			// If PB0 is pressed and the timer is off, start the timer
				enable = 1;
			} else if (PB_data_is_pressed_ASM(PB1) && (enable)) { 		// If PB1 is pressed and the timer is on, stop the timer
				enable = 0;
			} else if (PB_data_is_pressed_ASM(PB2)) { 					// If PB2 is pressed, reset the timer
				ms = 0;
				s = 0;
				min = 0;
				enable = 0;
				HEX_write_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5, 0);
			}
		}
	}

*/
// Interrupt example 
/*
	int_setup(1, (int []){199});
	
	int count = 0;
	HPS_TIM_config_t hps_tim;

	hps_tim.tim = TIM0;
	hps_tim.timeout = 1000000;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;

	HPS_TIM_config_ASM(&hps_tim);

	while(1) {

		if (HPS_TIM0_INT_FLAG) {
			HPS_TIM0_INT_FLAG = 0;
			if (+count == 15) {
				count = 0;
			}
			HEX_write_ASM(HEX0, count);
		}
	}

*/
// Interrupt stopwatch

	int_setup(2, (int []) {73, 199});				// Enable interrupts ID for PB_KEY (73) and Timer(199)
	enable_PB_INT_ASM(PB0 | PB1 | PB2);				// Enable interrupts for pushbuttons
	
	// Initialize all parameters
	int ms = 0;
	int s = 0;
	int min = 0;
	int enable = 1;

	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0;
	hps_tim.timeout = 1000;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;
	HPS_TIM_config_ASM(&hps_tim);

	while(1) {

		// If the timer interrupt flag is on then enter the block
		if (HPS_TIM0_INT_FLAG) { 
			// If the timer is on then start the timer 
			if (enable) {
				ms += 1; 		// Increcement 1ms each time
				// If millisecond reaches 1000 then increase the second
				if (ms == 1000) {
					ms = 0;
					s++;
				}
				// If second reaches 60 then increase the minute
				if (s == 60) {
					s = 0;
					min++;
				}
				// If minute reaches 60 then set everything to be zero
				if (min == 60) {
					min = 0;
					s = 0;
					ms = 0;
				}
				HEX_write_ASM(HEX0, ((ms % 100) / 10));	// HEX0 displays 10 ms
				HEX_write_ASM(HEX1, (ms / 100));  		// HEX1 displays  100ms
				HEX_write_ASM(HEX2, (s % 10));			// HEX2 displays  1s
				HEX_write_ASM(HEX3, (s / 10));			// HEX3 displays  10s
				HEX_write_ASM(HEX4, (min % 10));		// HEX4 displays  1min
				HEX_write_ASM(HEX5, (min / 10));		// HEX5 displays  10min
			}
			HPS_TIM0_INT_FLAG = 0;		// Put down the timer interrupt flag
		}

		// Check for pushbutton interrupts from the pushbuttons on every iteration
		if (PB_INT_FLAG > 0) { 
			if ((PB_INT_FLAG & 1) && (!enable)) { 				// If PB0 is pressed and the timer is off then start the timer
				enable = 1;
			} else if ((PB_INT_FLAG & 2) && (enable)) { 		// If PB1 is pressed and the timer is on then stop the timer
				enable = 0;
			} else if (PB_INT_FLAG & 4) { 						// If PB2 is pressed then reset the timer 
				ms = 0;
				s = 0;
				min = 0;
				enable = 0;
				HEX_write_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5, 0);
			}
			PB_INT_FLAG = 0;			// Put down the pushbutton interrupt flag
		}
	}

	return 0;
}
