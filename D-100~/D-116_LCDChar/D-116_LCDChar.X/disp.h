#ifndef DISP_H
#define	DISP_H
//#endif

#ifndef MAIN_H
#include "main.h"
#endif

#ifndef SD1602_4BIT_H
#include "SD1602_4bit_mode.h"
#endif


///////////////////////

// includes

/////////////////////
//#ifndef MAIN_H
//#include "main.h"
//#endif

//#ifndef LIB_D_108_V_2_5_3_H
//#include "lib_v_1.h"
//#endif

#ifndef LIB__H
#include "lib.h"
#endif

///////////////////////

// externs

///////////////////////
#ifdef	__cplusplus
extern "C" {
#endif

//	///////////////////////
//

//	// protos
//
//	///////////////////////

	void _Display2(void);

	void test_Disp(void);

	void _Display(void);

	///////////////////////

	// funcs

	///////////////////////

	void
	_Display(void) {

	//	strcpy(s, msg_1);

		///////////////////////

		// line: 1

		///////////////////////
		SD1602_control(0x02);	// Cursor => at home
								// Exec time => 1.64 ms

		__delay_ms(2);			// delay: wait for completion

		SD1602_print(msg_Project_Name);

//		pulse_100ms(3);
//
		///////////////////////

		// line: 2

		///////////////////////
		SD1602_control(0xC0);	// Cursor => second line
								// Exec time => 40 us
//
		__delay_us(100);

		SD1602_print(msg_Initial);


//		conv_Dex_to_Binary(hex, binary);
//
//		for (i = 0; i < 12; i ++) {
//
//			binary_display[3 + i] = binary[i];
//
//		}
//
//		conv_Hex_to_CharCode_2Digits(hex, msg_Hex_2Digit);
//
//		binary_display[0] = msg_Hex_2Digit[0];
//		binary_display[1] = msg_Hex_2Digit[1];
//		binary_display[2] = ' ';
//
//		SD1602_print(binary_display);

	}//_Display

//	void _Display(void);
//	void _Display__SW_Start(void);
//	void _Display__SW_Stop(void);

	//	void
//	_Display(void) {
//
//	//	strcpy(s, msg_1);
//
//		///////////////////////
//
//		// line: 1
//
//		///////////////////////
//		SD1602_control(0x02);	// Cursor => at home
//								// Exec time => 1.64 ms
//
//		__delay_ms(2);
//
//		SD1602_print(msg_Project_Name);
//
//		pulse_100ms(3);
//
//		///////////////////////
//
//		// line: 2
//
//		///////////////////////
//		SD1602_control(0xC0);	// Cursor => second line
//								// Exec time => 40 us
//
//		conv_Dex_to_Binary(hex, binary);
//
//		for (i = 0; i < 12; i ++) {
//
//			binary_display[3 + i] = binary[i];
//
//		}
//
//		conv_Hex_to_CharCode_2Digits(hex, msg_Hex_2Digit);
//
//		binary_display[0] = msg_Hex_2Digit[0];
//		binary_display[1] = msg_Hex_2Digit[1];
//		binary_display[2] = ' ';
//
//		SD1602_print(binary_display);
//
//	}//_Display
//
//	void
//	_Display__SW_Start(void) {
//
//	//	strcpy(s, msg_1);
//
//		///////////////////////
//
//		// line: 1
//
//		///////////////////////
//		SD1602_control(0x02);	// Cursor => at home
//								// Exec time => 1.64 ms
//
//		__delay_ms(2);
//
//		SD1602_print(msg_Project_Name);
//
//		pulse_100ms(3);
//
//		///////////////////////
//
//		// line: 2
//
//		///////////////////////
//		SD1602_control(0xC0);	// Cursor => second line
//								// Exec time => 40 us
//
//		SD1602_print(msg_SW_Start);
//
//	}//_Display
//
//	void
//	_Display__SW_Stop(void) {
//
//	//	strcpy(s, msg_1);
//
//		///////////////////////
//
//		// line: 1
//
//		///////////////////////
//		SD1602_control(0x02);	// Cursor => at home
//								// Exec time => 1.64 ms
//
//		__delay_ms(2);
//
//		SD1602_print(msg_Project_Name);
//
//		pulse_100ms(3);
//
//		///////////////////////
//
//		// line: 2
//
//		///////////////////////
//		SD1602_control(0xC0);	// Cursor => second line
//								// Exec time => 40 us
//
//		SD1602_print(msg_SW_Stop);
//
//	}//_Display



#ifdef	__cplusplus
}
#endif

#endif	/* #ifndef DISP_H */
