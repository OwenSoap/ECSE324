#include "./drivers/inc/vga.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/audio.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/wavetable.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/slider_switches.h"

// Method for generating signal using the formula provided in mannual and wavetable
double generateSignal(float f, int t) {
	float index = ((int)(f*t)) % 48000;
	int intIndex = (int)index;
	float decimalIndex = index - intIndex;
	float signal = (1.0 - decimalIndex) * sine[intIndex] + decimalIndex * sine[intIndex + 1];
	return signal;	
}

// Display welcome and vloume and insturctions on the screen
void displayInstructions() {
	
	VGA_clear_charbuff_ASM();
	VGA_clear_pixelbuff_ASM();

	VGA_write_char_ASM(0,0, 'W');
	VGA_write_char_ASM(1,0, 'E');
	VGA_write_char_ASM(2,0, 'L');
	VGA_write_char_ASM(3,0, 'C');
	VGA_write_char_ASM(4,0, 'O');
	VGA_write_char_ASM(5,0, 'M');
	VGA_write_char_ASM(6,0, 'E');
	VGA_write_char_ASM(7,0, ' ');
	VGA_write_char_ASM(8,0, 'T');
	VGA_write_char_ASM(9,0, 'O');
	VGA_write_char_ASM(10,0, ' ');
	VGA_write_char_ASM(11,0, 'G');
	VGA_write_char_ASM(12,0, 'R');
	VGA_write_char_ASM(13,0, 'O');
	VGA_write_char_ASM(14,0, 'U');
	VGA_write_char_ASM(15,0, 'P');
	VGA_write_char_ASM(16,0, ' ');
	VGA_write_char_ASM(17,0, '2');
	VGA_write_char_ASM(18,0, '9');
	VGA_write_char_ASM(19,0, '!');

	VGA_write_char_ASM(0,1, ' ');
	VGA_write_char_ASM(1,1, ' ');
	VGA_write_char_ASM(2,1, 'Y');
	VGA_write_char_ASM(3,1, 'I');
	VGA_write_char_ASM(4,1, ' ');
	VGA_write_char_ASM(5,1, ' ');
	VGA_write_char_ASM(6,1, 'Z');
	VGA_write_char_ASM(7,1, 'H');
	VGA_write_char_ASM(8,1, 'U');
	VGA_write_char_ASM(9,1, ' ');
	VGA_write_char_ASM(10,1, '2');
	VGA_write_char_ASM(11,1, '6');
	VGA_write_char_ASM(12,1, '0');
	VGA_write_char_ASM(13,1, '7');
	VGA_write_char_ASM(14,1, '1');
	VGA_write_char_ASM(15,1, '6');
	VGA_write_char_ASM(16,1, '0');
	VGA_write_char_ASM(17,1, '0');
	VGA_write_char_ASM(18,1, '6');

	VGA_write_char_ASM(0,2, 'S');
	VGA_write_char_ASM(1,2, 'H');
	VGA_write_char_ASM(2,2, 'A');
	VGA_write_char_ASM(3,2, 'L');
	VGA_write_char_ASM(4,2, 'U');
	VGA_write_char_ASM(5,2, 'O');
	VGA_write_char_ASM(6,2, ' ');
	VGA_write_char_ASM(7,2, 'W');
	VGA_write_char_ASM(8,2, 'U');
	VGA_write_char_ASM(9,2, ' ');
	VGA_write_char_ASM(10,2, '2');
	VGA_write_char_ASM(11,2, '6');
	VGA_write_char_ASM(12,2, '0');
	VGA_write_char_ASM(13,2, '7');
	VGA_write_char_ASM(14,2, '1');
	VGA_write_char_ASM(15,2, '3');
	VGA_write_char_ASM(16,2, '9');
	VGA_write_char_ASM(17,2, '2');
	VGA_write_char_ASM(18,2, '3');
	
	VGA_write_char_ASM(53,0, 'V');
	VGA_write_char_ASM(54,0, 'O');
	VGA_write_char_ASM(55,0, 'L');
	VGA_write_char_ASM(56,0, 'U');
	VGA_write_char_ASM(57,0, 'M');
	VGA_write_char_ASM(58,0, 'E');
	VGA_write_char_ASM(59,0, ':');
	VGA_write_char_ASM(60,0, ' ');

	VGA_write_char_ASM(53,1, 'R');
	VGA_write_char_ASM(54,1, 'R');
	VGA_write_char_ASM(55,1, 'E');
	VGA_write_char_ASM(56,1, 'S');
	VGA_write_char_ASM(57,1, 'S');
	VGA_write_char_ASM(58,1, ' ');
	VGA_write_char_ASM(59,1, '<');
	VGA_write_char_ASM(60,1, ' ');
	VGA_write_char_ASM(61,1, 'D');
	VGA_write_char_ASM(62,1, 'E');
	VGA_write_char_ASM(63,1, 'C');
	VGA_write_char_ASM(64,1, 'R');
	VGA_write_char_ASM(65,1, 'E');
	VGA_write_char_ASM(66,1, 'A');
	VGA_write_char_ASM(67,1, 'S');
	VGA_write_char_ASM(68,1, 'E');
	VGA_write_char_ASM(69,1, ' ');
	VGA_write_char_ASM(70,1, 'V');
	VGA_write_char_ASM(71,1, 'O');
	VGA_write_char_ASM(72,1, 'L');
	VGA_write_char_ASM(73,1, 'U');
	VGA_write_char_ASM(74,1, 'M');
	VGA_write_char_ASM(75,1, 'E');

	VGA_write_char_ASM(53,2, 'P');
	VGA_write_char_ASM(54,2, 'R');
	VGA_write_char_ASM(55,2, 'E');
	VGA_write_char_ASM(56,2, 'S');
	VGA_write_char_ASM(57,2, 'S');
	VGA_write_char_ASM(58,2, ' ');
	VGA_write_char_ASM(59,2, '>');
	VGA_write_char_ASM(60,2, ' ');
	VGA_write_char_ASM(61,2, 'I');
	VGA_write_char_ASM(62,2, 'N');
	VGA_write_char_ASM(63,2, 'C');
	VGA_write_char_ASM(64,2, 'R');
	VGA_write_char_ASM(65,2, 'E');
	VGA_write_char_ASM(66,2, 'A');
	VGA_write_char_ASM(67,2, 'S');
	VGA_write_char_ASM(68,2, 'E');
	VGA_write_char_ASM(69,2, ' ');
	VGA_write_char_ASM(70,2, 'V');
	VGA_write_char_ASM(71,2, 'O');
	VGA_write_char_ASM(72,2, 'L');
	VGA_write_char_ASM(73,2, 'U');
	VGA_write_char_ASM(74,2, 'M');
	VGA_write_char_ASM(75,2, 'E');
}
// Method for drawing wave on the screen based on frquency and amplitude given
void drawWave(float f, int amplitude) {
	
	// Clear the screen and initialize variables
	VGA_clear_pixelbuff_ASM();									
	int x, y;
	int xPosition = 0;
	unsigned short colour = 0xFFFFFF;
	// Display current volume based on amplitude
    VGA_write_char_ASM(61, 0, amplitude + 48);
	// Chose the increcement of x in wave table depends on given sampling frquecy, curent frquency
	int xGap = (int)((float)(48000 / ((320.00 / f)* 50.00)));
	// Draw the sine wave on the screen
	for(x = 0; x <= 319; x++) {
		// Draw the sine wave on the middle based on the wave table given
		y = (int)(float)(10)*(float)(amplitude)*(((float)sine[xPosition]))/((float)(sine[36000])) + 120;		
		// Draw it in white
		VGA_draw_point_ASM(x, y, colour);
		xPosition = xPosition + xGap;
		// If the x position goes beyond the sample frequency then return to the beginning 
		if (xPosition > 48000){
			xPosition = xPosition - 48000; 
		} 
	}
}

int main() {
	// Display welcome first
	displayInstructions();
	int s = 0;	// Signal variable
	int t = 0;	// Time variable
	int amp = 5;	// Default amplitude to be 5
	int keystate[8] = {0, 0, 0, 0, 0, 0, 0, 0, 0};	// Array for key state
	float freqs[8] = {130.813, 146.832, 164.814, 174.614, 195.998, 220.000, 246.942, 261.626};	// Given frequency for piano 
	float oldf = 0;	// Old frequency for upadating
	int olda = 0; 	// Old amplitude for updating
	char data;		// Data to store input key press
	int keyReleased = 0;	// Boolean value to check if the key is released

while(1){
	
	float f = 0;		
	// Check the input on keyboard
	if (read_ps2_data_ASM(&data)) {
		switch (data){
			// Key A = C = 130.813Hz
			case 0x1C:
				if(keyReleased == 1){
					keystate[0] = 0;
					keyReleased = 0;
				} else {
					keystate[0] = 1;
				}
				break;
			// Key S = D = 146.832Hz
			case 0x1B:
				if(keyReleased == 1){
					keystate[1] = 0;
					keyReleased = 0;
				} else {
					keystate[1] = 1;
				}
				break;
			// Key D = E = 164.814Hz
			case 0x23:
				if(keyReleased == 1){
					keystate[2] = 0;
					keyReleased = 0;
				} else {
					keystate[2] = 1;
				}
				break;
			// Key F = F = 174.614Hz
			case 0x2B:
				if(keyReleased == 1){
					keystate[3] = 0;
					keyReleased = 0;
				} else {
					keystate[3] = 1;
				}
				break;
			// Key J = G = 195.998Hz
			case 0x3B:
				if(keyReleased == 1){
					keystate[4] = 0;
					keyReleased = 0;
				} else {
					keystate[4] = 1;
				}
				break;
			// Key K = A = 220.000Hz
			case 0x42:
				if(keyReleased == 1){
					keystate[5] = 0;
					keyReleased = 0;
				} else {
					keystate[5] = 1;
				}
				break;
			// Key L = B = 246.942Hz
			case 0x4B:
				if(keyReleased == 1){
					keystate[6] = 0;
					keyReleased = 0;
				} else {
					keystate[6] = 1;
				}
				break;
			// Key ; = C = 261.626Hz
			case 0x4C:
				if(keyReleased == 1){
					keystate[7] = 0;
					keyReleased = 0;
				} else {
					keystate[7] = 1;
				}
				break;
			// Key > for increasing volume
			case 0x49:
				if(keyReleased == 1){
					if(amp<9){
						amp++;
						keyReleased = 0;
					}
				}
				break;
			// Key < for decreasing volume
			case 0x41:
				if(keyReleased == 1 ){
					if(amp>0){
						amp--;
						keyReleased = 0;
					}
				}
				break;
			// Check for the break code to see if a key is released
			case 0xF0: 
				keyReleased = 1;
				break;
			// Default setting that no key is pressed 
			default:
				keyReleased = 0;
			}
	  	}
		// Initialize some variables for generating signal
		int i;
		float freSum = 0;
		int hit = 0;
		// Check which key(s) is(are) pressed 
		for (i = 0; i < 8; i++) {
			if (keystate[i]) {
				freSum = freSum +  freqs[i];
				hit++;
			}
		}
		// If more than one key are prssed, take the average frequency to play
		if (hit > 0){
			f = freSum / hit;
		} else {
			f = 0;
		}
		// Only draw the signal when the data is updated
		if (oldf != f || olda != amp) {
			oldf = f;
			olda = amp;
			drawWave(f, amp);
		}
		// When frequency is not zero, generate correspoding sound and play it out using while loop instead of timer
		if(f != 0 ) {
			while(t < (48000/f)){							
				s = amp * generateSignal(f,t);
				audio_write_data_ASM(s,s);
				t++;
			}
			t = 0;
			s = 0;		
		}
	}
	return 0;
}
