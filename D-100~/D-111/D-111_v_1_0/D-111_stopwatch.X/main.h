#ifndef MAIN_H
#define	MAIN_H
#endif

///////////////////////

// commons

///////////////////////
#define true	1
#define false	0

#define EQ_500MS	4500
//#define EQ_500MS	9765

#define ADCH    1
#define ADCL    0xCD

#define MAX_NUM 1023

//REF http://www9.plala.or.jp/sgwr-t/c/sec16.html
typedef unsigned int usi;


///////////////////////

// lib.h

///////////////////////
	///////////////////////

	// vars

	///////////////////////
	char binary[9];
	char binary_display[12];
	char binary_display_16[17];	// 16 chars + 1 null char = 17
	char binary_display_8[9];	// "3FF 1023" (8 chars + null char)
	char binary_display_9[10];	// "1DC 1.245\0" (9 chars + null char)

	char temp_4[4];				// 3-bit decimal number
	char temp_5[5];				// 4-digit number string => ADRESH, ADRESL

	char msg_Project_Name[]  = "D-111 v-1.0-2";
	char msg_2[]  = "INT!";

	char msg_SW_Start[]  = "SW starts";
	char msg_SW_Stop[]  = "SW stops";

	char msg_Hex_2Digit[3];	// 2-digit hex
							// length is 3 => 2 digits and '0' char

	int adcH = ADCH, adcL = ADCL, hex = ADCL;

	char s[20];

	double ref = 5.0;

	unsigned int msg_num = 0;	// message number
							// 0 => version; 1 => greeting

	unsigned int msg_Len;
	unsigned int i;			// index for iterator
	unsigned int flag_Intr = false;
	unsigned int count;

	// stopwatch status
	usi st_Stopwatch = -1;

	///////////////////////

	// flags

	///////////////////////
	usi f_Clicked = true;

	///////////////////////

	// protos

	///////////////////////
	void conv_Dex_to_Binary(int, char[9]);

	void conv_2Hex_to_String(int, int, char[5]);

	void conv_Hex_to_Decimal_String(int, char[5]);

	void conv_1Hex_to_String(int, char[4]);
	void conv_Float_to_String(float, char[6]);
	void conv_Hex_to_3Digit_String(int, char[4]);	// 3 digits + null char = 4
	void conv_ADC_to_FloatString(int, int, double, char[6]);

	void _While__Clicked(int);

	void
	conv_Hex_to_CharCode_2Digits
	(signed char, char[]);
///////////////////////

// disp.h

///////////////////////
	///////////////////////

	// protos

	///////////////////////
	void _Display(void);
	void _Display__SW_Start(void);
	void _Display__SW_Stop(void);
