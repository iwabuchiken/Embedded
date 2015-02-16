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

		///////////////////////

		// line: 1

		///////////////////////
		SD1602_control(0x02);	// Cursor => at home
								// Exec time => 1.64 ms

		__delay_ms(2);			// delay: wait for completion

		SD1602_print(msg_Project_Name);

		///////////////////////

		// line: 2

		///////////////////////
		SD1602_control(0xC0);	// Cursor => second line
								// Exec time => 40 us
//
		__delay_us(100);

		SD1602_print(msg_Initial);

	}//_Display

	void
//	_Display_2Lines(char *line1, const char *line2) {
	_Display_2Lines(char *line1, char *line2) {

		///////////////////////////////
		//
		// clear: display
		//
		 ///////////////////////////////
		SD1602_control(0x01);	// LCD => clear

		__delay_ms(2);			// "Execute time(max.)" => 1.64 ms

		///////////////////////

		// line: 1

		///////////////////////
//		SD1602_control(0x02);	// Cursor => at home
//								// Exec time => 1.64 ms
//
//		__delay_ms(2);			// delay: wait for completion

		SD1602_print(line1);

		///////////////////////

		// line: 2

		///////////////////////
		SD1602_control(0xC0);	// Cursor => second line
								// Exec time => 40 us
//
		__delay_us(100);

		SD1602_print(line2);

	}//_Display


	void
	//	_Display_2Lines(char *line1, const char *line2) {
	_Display_Line2(char *line, int len) {

		///////////////////////////////
		//
		// prep: chars
		//
		 ///////////////////////////////
		char msg[16];

		if (len > 15) {

			len = 15;

		}

		// initialize chars
		int i;

		for (i = 0; i < 16 - 1; i) {
	//		for (i = 0; i < 16; i) {

			msg[i] = ' ';

		}

		msg[15] = '\0';

		// set: line
		// modify len
		if (line[len - 1] == '\0') {

			len -= 1;

		}

		for (i = 0; i < len; i) {

			msg[i] = line[i];

		}

		///////////////////////

		// disp: line

		///////////////////////
		SD1602_control(0xC0);	// 2nd line, 1st digit
//		SD1602_control(0x40);	// 2nd line, 1st digit

		SD1602_print(msg);

	}//_Display_Line2(char *line, int len)


#ifdef	__cplusplus
}
#endif

#endif	/* #ifndef DISP_H */
