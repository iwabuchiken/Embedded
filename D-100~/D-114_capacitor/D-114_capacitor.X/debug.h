/* 
 * File:   debug.h
 * Author: iwabuchik
 *
 * Created on 2014/12/02, 11:40
 */

#ifndef DEBUG_H
#define	DEBUG_H
//#endif

#ifdef	__cplusplus
extern "C" {
#endif

void pulse_250ms(unsigned int);
void pulse_250ms_RB2(unsigned int);

void pulse_100ms(unsigned int);
void pulse_100ms_RB2(unsigned int);

void pulse_250ms(unsigned int num) {

	int i;

	for (i = 0; i < num; i ++) {

		PORTBbits.RB1 = 1;

		__delay_ms(250);

		PORTBbits.RB1 = 0;

		__delay_ms(250);

	}

}

void pulse_250ms_RB2(unsigned int num) {

	int i;

	for (i = 0; i < num; i ++) {

		PORTBbits.RB2 = 1;

		__delay_ms(250);

		PORTBbits.RB2 = 0;

		__delay_ms(250);

	}

}

void pulse_100ms(unsigned int num) {

	int i;

	for (i = 0; i < num; i ++) {

		PORTBbits.RB1 = 1;

		__delay_ms(100);

		PORTBbits.RB1 = 0;

		__delay_ms(100);

	}

}

void pulse_100ms_RB2(unsigned int num) {

	int i;

	for (i = 0; i < num; i ++) {

		PORTBbits.RB2 = 1;

		__delay_ms(100);

		PORTBbits.RB2 = 0;

		__delay_ms(100);

	}

}





#ifdef	__cplusplus
}
#endif

#endif	/* DEBUG_H */

