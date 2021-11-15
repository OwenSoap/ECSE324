#include <stdio.h>

#include "./drivers/inc/VGA.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/audio.h"

void test_char() {
	int x,y;
	char c = 0;
	
	for (y=0; y<=59; y++) {
		for (x=0; x<=79; x++) {
			VGA_write_char_ASM(x, y, c++);
		}
	}
}

void test_byte() {
	int x,y;
	char c = 0;
	
	for (y=0; y<=59; y++) {
		for (x=0; x<=79; x+=3) {
			VGA_write_byte_ASM(x, y, c++);
		}
	}
}

void test_pixel() {
	int x,y;
	unsigned short colour = 0;
	
	for (y=0; y<=239; y++) {
		for (x=0; x<=319; x++) {
			VGA_draw_point_ASM(x,y,colour++);
		}
	}
}

void vga() {
	while (1) {
		if (read_slider_switches_ASM()!=0 && PB_data_is_pressed_ASM(PB0)){
			test_byte();
			//VGA_write_byte_ASM(0, 0, 0xAA)
		}
		else if(read_slider_switches_ASM()==0 && PB_data_is_pressed_ASM(PB0)){
			test_char();
		}
		else if (PB_data_is_pressed_ASM(PB1)){
			test_pixel();
		}
		else if (PB_data_is_pressed_ASM(PB2)) {
			VGA_clear_charbuff_ASM();
		}
		else if (PB_data_is_pressed_ASM(PB3)) {
			VGA_clear_pixelbuff_ASM();
		}
	}
}

void ps2keyboard() {
	// Initialize the variables
	char a;
	int x = 0;
	int y = 0;
	// Clear the screen
	VGA_clear_charbuff_ASM();
	VGA_clear_pixelbuff_ASM();
	// Write the char in 0,3,5 order
	while(1) {
		if (read_PS2_data_ASM(&a)) {
			VGA_write_byte_ASM(x, y, a);
			x += 3;
			if (x > 78) {
				x = 0;
				y += 1;
				if (y > 59) {
					y = 0;
					VGA_clear_charbuff_ASM();
				}
			}			
		}
	}
}

void audio(){
	// Since we want 100Hz and the sampling rate is 48k samples/sec we made 240 1 and 240 0
	while(1){
		int i = 0;
		int j = 0;
		while (i < 240){	
		if(audio_ASM(0x00FFFFFF)==1){
				i++;
			}
		}
		while (j < 240){
			if(audio_ASM(0x00000000)==1){
				j++;
			}
		}
	}
}

int main(){
	//vga();
	//ps2keyboard();
	audio();
	return 0;
}
